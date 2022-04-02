# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'student.ui'
#
# Created by: PyQt5 UI code generator 5.15.4
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import *


import sys
import pymysql

class Ui_student(object):
    def connect(self):
        con = pymysql.connect(host= 'localhost', port= 3306, charset='utf8',
                            user= 'root', password= '1234567890', 
                            database= 'teaching_management_system')
        
        return con
    # 输出备选科目
    def printCourse(self):
        con = self.connect()
        cur = con.cursor()
        cur.execute('select scheduleno,coursename,tname,year,semester,capacity,snum from schedule,course,teacher where schedule.teacherno=teacher.tno and course.courseno = schedule.courseno')
        data = cur.fetchall()
        # 打印测试
        x = 0
        for i in data:
            y = 0
            for j in i:
                self.coursetableWidget.setItem(y, x, QtWidgets.QTableWidgetItem(str(data[x][y])))
                y = y + 1
            x = x + 1
        # print(data)
    #学生选课
    def chooseCourse(self):
        sno,scheduleno = self.lineEdit_sno.text(),self.lineEdit_schno.text()
        con = self.connect()
        cur = con.cursor()
        if not sno or not scheduleno:
            QMessageBox.warning(self, '警告', '请输入学号、开课号')
        else:
            if not cur.execute('select * from student where sno=%s',[sno]):
                QMessageBox.warning(self, '警告', '学号输入错误')
                self.lineEdit_sno.clear()
            elif not cur.execute('select * from schedule where scheduleno=%s',[scheduleno]):
                QMessageBox.warning(self, '警告', '开课号输入错误')
            else:
                query = 'select courseno from schedule where scheduleno=%s'
                cur.execute(query, [scheduleno])
                courseno = cur.fetchall()[0][0]
                if cur.execute('select * from choose where studentno=%s and courseno=%s',[sno,courseno]):
                    QMessageBox.warning(self, '警告', '该选课已存在')
                else:
                    query = 'insert into choose values (%s,%s,%s,NULL)'
                    cur.execute(query, [sno,courseno,scheduleno])
                    con.commit()
        self.lineEdit_schno.clear()

    def setupUi(self, student):
        student.setObjectName("student")
        student.resize(800, 625)
        font = QtGui.QFont()
        font.setFamily("Arial")
        font.setPointSize(12)
        student.setFont(font)
        self.centralwidget = QtWidgets.QWidget(student)
        self.centralwidget.setObjectName("centralwidget")
        self.backbutton = QtWidgets.QPushButton(self.centralwidget)
        self.backbutton.setGeometry(QtCore.QRect(10, 10, 93, 28))
        self.backbutton.setObjectName("backbutton")
        self.selectCoursepushButton = QtWidgets.QPushButton(self.centralwidget)
        self.selectCoursepushButton.setGeometry(QtCore.QRect(110, 10, 93, 28))
        self.selectCoursepushButton.setObjectName("selectCoursepushButton")
        self.coursetableWidget = QtWidgets.QTableWidget(self.centralwidget)
        self.coursetableWidget.setGeometry(QtCore.QRect(20, 45, 750, 320))
        self.coursetableWidget.setObjectName("coursetableWidget")
        self.coursetableWidget.setColumnCount(100)
        self.coursetableWidget.setRowCount(7)
        item = QtWidgets.QTableWidgetItem()
        self.coursetableWidget.setVerticalHeaderItem(0, item)
        item = QtWidgets.QTableWidgetItem()
        self.coursetableWidget.setVerticalHeaderItem(1, item)
        item = QtWidgets.QTableWidgetItem()
        self.coursetableWidget.setVerticalHeaderItem(2, item)
        item = QtWidgets.QTableWidgetItem()
        self.coursetableWidget.setVerticalHeaderItem(3, item)
        item = QtWidgets.QTableWidgetItem()
        self.coursetableWidget.setVerticalHeaderItem(4, item)
        item = QtWidgets.QTableWidgetItem()
        self.coursetableWidget.setVerticalHeaderItem(5, item)
        item = QtWidgets.QTableWidgetItem()
        self.coursetableWidget.setVerticalHeaderItem(6, item)
        self.verticalLayoutWidget = QtWidgets.QWidget(self.centralwidget)
        self.verticalLayoutWidget.setGeometry(QtCore.QRect(20, 350, 361, 231))
        self.verticalLayoutWidget.setObjectName("verticalLayoutWidget")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.verticalLayoutWidget)
        self.verticalLayout.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout.setObjectName("verticalLayout")
        self.label = QtWidgets.QLabel(self.verticalLayoutWidget)
        self.label.setObjectName("label")
        self.verticalLayout.addWidget(self.label)
        self.gridLayout_3 = QtWidgets.QGridLayout()
        self.gridLayout_3.setObjectName("gridLayout_3")
        self.lineEdit_sno = QtWidgets.QLineEdit(self.verticalLayoutWidget)
        self.lineEdit_sno.setText("")
        self.lineEdit_sno.setObjectName("lineEdit_sno")
        self.gridLayout_3.addWidget(self.lineEdit_sno, 1, 1, 1, 1)
        self.label_5 = QtWidgets.QLabel(self.verticalLayoutWidget)
        self.label_5.setObjectName("label_5")
        self.gridLayout_3.addWidget(self.label_5, 1, 0, 1, 1)
        self.verticalLayout.addLayout(self.gridLayout_3)
        self.gridLayout_13 = QtWidgets.QGridLayout()
        self.gridLayout_13.setObjectName("gridLayout_13")
        self.lineEdit_schno = QtWidgets.QLineEdit(self.verticalLayoutWidget)
        self.lineEdit_schno.setText("")
        self.lineEdit_schno.setObjectName("lineEdit_schno")
        self.gridLayout_13.addWidget(self.lineEdit_schno, 1, 1, 1, 1)
        self.label_16 = QtWidgets.QLabel(self.verticalLayoutWidget)
        self.label_16.setObjectName("label_16")
        self.gridLayout_13.addWidget(self.label_16, 1, 0, 1, 1)
        self.verticalLayout.addLayout(self.gridLayout_13)
        self.horizontalLayout = QtWidgets.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        spacerItem = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.chooseButton = QtWidgets.QPushButton(self.verticalLayoutWidget)
        self.chooseButton.setObjectName("chooseButton")
        self.horizontalLayout.addWidget(self.chooseButton)
        self.verticalLayout.addLayout(self.horizontalLayout)
        student.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(student)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 800, 29))
        self.menubar.setObjectName("menubar")
        student.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(student)
        self.statusbar.setObjectName("statusbar")
        student.setStatusBar(self.statusbar)

        self.retranslateUi(student)
        QtCore.QMetaObject.connectSlotsByName(student)

        # operation
        self.selectCoursepushButton.clicked.connect(self.printCourse)
        self.chooseButton.clicked.connect(self.chooseCourse)




    def retranslateUi(self, student):
        _translate = QtCore.QCoreApplication.translate
        student.setWindowTitle(_translate("student", "学生"))
        self.backbutton.setText(_translate("student", "返回"))
        self.selectCoursepushButton.setText(_translate("student", "查询选课"))
        self.label.setText(_translate("student", "学生选课:"))
        self.label_5.setText(_translate("student", "  学号  "))
        self.label_16.setText(_translate("student", "开课号"))
        self.chooseButton.setText(_translate("student", "选择"))
        item = self.coursetableWidget.verticalHeaderItem(0)
        item.setText(_translate("student", "scheduleno"))
        item = self.coursetableWidget.verticalHeaderItem(1)
        item.setText(_translate("student", "coursename"))
        item = self.coursetableWidget.verticalHeaderItem(2)
        item.setText(_translate("student", "teachername"))
        item = self.coursetableWidget.verticalHeaderItem(3)
        item.setText(_translate("student", "year"))
        item = self.coursetableWidget.verticalHeaderItem(4)
        item.setText(_translate("student", "semester"))
        item = self.coursetableWidget.verticalHeaderItem(5)
        item.setText(_translate("student", "capacity"))
        item = self.coursetableWidget.verticalHeaderItem(6)
        item.setText(_translate("student", "snum"))
       


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    student = QtWidgets.QMainWindow()
    ui = Ui_student()
    ui.setupUi(student)
    student.show()
    sys.exit(app.exec_())
