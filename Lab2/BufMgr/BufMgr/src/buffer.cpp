/**
 * @author See Contributors.txt for code contributors and overview of BadgerDB.
 *
 * @section LICENSE
 * Copyright (c) 2012 Database Group, Computer Sciences Department, University of Wisconsin-Madison.
 */

#include <memory>
#include <iostream>
#include "buffer.h"
#include "exceptions/buffer_exceeded_exception.h"
#include "exceptions/page_not_pinned_exception.h"
#include "exceptions/page_pinned_exception.h"
#include "exceptions/bad_buffer_exception.h"
#include "exceptions/hash_not_found_exception.h"

namespace badgerdb
{

	BufMgr::BufMgr(std::uint32_t bufs)
		: numBufs(bufs)
	{
		bufDescTable = new BufDesc[bufs];

		for (FrameId i = 0; i < bufs; i++)
		{
			bufDescTable[i].frameNo = i;
			bufDescTable[i].valid = false;
		}

		bufPool = new Page[bufs];

		int htsize = ((((int)(bufs * 1.2)) * 2) / 2) + 1;
		hashTable = new BufHashTbl(htsize); // allocate the buffer hash table

		clockHand = bufs - 1;
	}

	BufMgr::~BufMgr()
	{
		// flush all frames in the buffer pool.
		for (FrameId i = 0; i < numBufs; i++)
		{
			if (bufDescTable[i].valid)
			{
				BufMgr::flushFile(bufDescTable[i].file);
			}
		}

		// delete the bufDescTable.
		delete[] bufDescTable;
		// delete the buffer pool.
		delete[] bufPool;
		// delete the hash table.
		delete hashTable;
	}

	void BufMgr::advanceClock()
	{
		// advance clock hand, remebering to modulo numBufs.
		clockHand = (clockHand + 1) % numBufs;
	}

	void BufMgr::allocBuf(FrameId &frame)
	{
		uint8_t bufPinned = 0; // number of pinned frames.
		while (true)
		{
			advanceClock(); // advance clock hand.
			if (!bufDescTable[clockHand].valid)
			{ // if the frame is not valid.
				break;
			}
			if (bufDescTable[clockHand].refbit)
			{ // if the frame is referenced recently, set the refbit to false.
				bufDescTable[clockHand].refbit = false;
			}
			else
			{ // if the frame is not referenced recently.
				if (bufDescTable[clockHand].pinCnt == 0)
				{ // if the frame is not pinned.
					if (bufDescTable[clockHand].dirty)
					{ // if the frame is dirty, write the frame to disk.
						bufDescTable[clockHand].file->writePage(bufPool[clockHand]);
					}
					bufDescTable[clockHand].dirty = false; // set the dirty bit to false.
					break;
				}
				else
				{ // if the frame is pinned.
					// increase the number of pinned frames.
					bufPinned++;
					if (bufPinned == (numBufs * 2))
					{ // if all frames are pinned.
						throw BufferExceededException();
					}
				}
			}
		}
		frame = clockHand; // set the frame to the clock hand.

		if (bufDescTable[clockHand].valid)
		{ // if the frame is valid.
			try
			{ // try to remove the frame from the hash table.
				hashTable->remove(bufDescTable[clockHand].file, bufDescTable[clockHand].pageNo);
			}
			catch (const HashNotFoundException &e)
			{
			}
		}
	}

	void BufMgr::readPage(File *file, const PageId pageNo, Page *&page)
	{
		FrameId frame; // frame number of the page read.

		try
		{ // try to find the page in the hash table.
			hashTable->lookup(file, pageNo, frame);
			// set the refbit to true, if the page is found.
			bufDescTable[frame].refbit = true;
			// increase the pin count of the page, if the page is found.
			bufDescTable[frame].pinCnt++;
		}
		catch (const HashNotFoundException &e)
		{											 // if the page is not found.
			allocBuf(frame);						 // allocate a frame for the page.
			bufPool[frame] = file->readPage(pageNo); // read the page from disk.
			hashTable->insert(file, pageNo, frame);	 // insert the page into the hash table.
			bufDescTable[frame].Set(file, pageNo);	 // set the buffer descriptor of the page.
		}
		page = &bufPool[frame]; // return the page in the buffer pool.
	}

	void BufMgr::unPinPage(File *file, const PageId pageNo, const bool dirty)
	{
		FrameId frame; // frame number of the page unpinned.
		try
		{ // try to find the page in the hash table.
			hashTable->lookup(file, pageNo, frame);
			if (bufDescTable[frame].pinCnt == 0)
			{ // if the page is not pinned, throw an exception.
				throw PageNotPinnedException(file->filename(), pageNo, frame);
			}
			bufDescTable[frame].pinCnt--;		// decrease the pin count of the page.
			bufDescTable[frame].dirty |= dirty; // set the dirty bit to true, if the page is dirty.
		}
		catch (const HashNotFoundException &e)
		{
		}
	}

	void BufMgr::allocPage(File *file, PageId &pageNo, Page *&page)
	{
		Page new_page = file->allocatePage(); // allocate a page from the file.
		pageNo = new_page.page_number();	  // get the page number of the page.

		FrameId frame;							// frame number of the page allocated.
		allocBuf(frame);						// allocate a frame for the page.
		hashTable->insert(file, pageNo, frame); // insert the page into the hash table.
		bufDescTable[frame].Set(file, pageNo);	// set the buffer descriptor of the page.
		bufPool[frame] = new_page;				// set the page in the buffer pool.
		page = &bufPool[frame];					// return the page in the buffer pool.
	}

	void BufMgr::disposePage(File *file, const PageId PageNo)
	{
		FrameId frame; // frame number of the page disposed.
		try
		{
			hashTable->lookup(file, PageNo, frame); // try to find the page in the hash table.
			bufDescTable[frame].Clear();			// clear the buffer descriptor of the page.
			hashTable->remove(file, PageNo);		// remove the page from the hash table.
		}
		catch (const HashNotFoundException &e)
		{ // if the page is not found, do nothing.
		}
		file->deletePage(PageNo); // delete the page from the file.
	}

	void BufMgr::flushFile(const File *file)
	{
		for (FrameId frame = 0; frame < numBufs; frame++)
		{ // for each frame in the buffer pool.
			if (bufDescTable[frame].file == file)
			{ // if the frame belongs to the file.
				if (!bufDescTable[frame].valid)
				{ // if the frame is not valid, throw an exception.
					throw BadBufferException(frame, bufDescTable[frame].dirty, bufDescTable[frame].valid, bufDescTable[frame].refbit);
				}
				if (bufDescTable[frame].pinCnt > 0)
				{ // if the frame is pinned, throw an exception.
					throw PagePinnedException(file->filename(), bufDescTable[frame].pageNo, frame);
				}
				if (bufDescTable[frame].dirty)
				{ // if the frame is dirty, write the frame to disk.
					bufDescTable[frame].file->writePage(bufPool[frame]);
					bufDescTable[frame].dirty = false;
				}
				hashTable->remove(file, bufDescTable[frame].pageNo); // remove the frame from the hash table.
				bufDescTable[frame].Clear();						 // clear the buffer descriptor of the frame.
			}
		}
	}

	void BufMgr::printSelf(void)
	{
		BufDesc *tmpbuf;
		int validFrames = 0;

		for (std::uint32_t i = 0; i < numBufs; i++)
		{
			tmpbuf = &(bufDescTable[i]);
			std::cout << "FrameNo:" << i << " ";
			tmpbuf->Print();

			if (tmpbuf->valid == true)
				validFrames++;
		}

		std::cout << "Total Number of Valid Frames:" << validFrames << "\n";
	}

}
