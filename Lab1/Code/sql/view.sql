---------------------------------
-- Create view
---------------------------------
CREATE VIEW CS AS 
SELECT sno,sname,faculty.fno FROM faculty,class,student 
WHERE (faculty.fname = "CS") AND (faculty.fno = class.fno) AND (student.cno = class.cno) ;
