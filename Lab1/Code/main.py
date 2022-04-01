#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sys
from PyQt5.QtWidgets import *
import pymysql

from gui.system import Ui_system
from gui.student import Ui_student
from gui.teacher import Ui_teacher
from gui.administrator import Ui_administrator

class systemUi(QMainWindow, Ui_system):
    def __init__(self):
        super(systemUi, self).__init__()
        self.setupUi(self)

class studentUi(QMainWindow, Ui_student):
    def __init__(self):
        super(studentUi, self).__init__()
        self.setupUi(self)

class teacherUi(QMainWindow, Ui_teacher):
    def __init__(self):
        super(teacherUi, self).__init__()
        self.setupUi(self)

class administratorUi(QMainWindow, Ui_administrator):
    def __init__(self):
        super(administratorUi, self).__init__()
        self.setupUi(self)


if __name__ == "__main__":
    mysql_conn = pymysql.connect(host= 'localhost', port= 3306, charset='utf8',
                            user= 'root', password= '1234567890', 
                            database= 'teaching_management_system')
    app = QApplication(sys.argv)
    system = systemUi()
    student = studentUi()
    teacher = teacherUi()
    administrator = administratorUi()
    system.show()
    system.studentbutton.clicked.connect(lambda:{system.close(), student.show()})
    system.teacherbutton.clicked.connect(lambda:{system.close(), teacher.show()})
    system.administratorbutton.clicked.connect(lambda:{system.close(), administrator.show()})
    student.backbutton.clicked.connect(lambda:{student.close(),system.show()})
    teacher.backbutton.clicked.connect(lambda:{teacher.close(),system.show()})
    administrator.backbutton.clicked.connect(lambda:{administrator.close(),system.show()})



    
    sys.exit(app.exec_())


