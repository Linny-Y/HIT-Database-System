import sys
from PyQt5.QtWidgets import *
def window():
   app = QApplication(sys.argv)
   w = QWidget()
   b = QLabel(w)
   b.setText("Hello World!")
   w.setGeometry(100,100,200,100)
   b.move(50,70)
   w.setWindowTitle("py")
   w.show()
   sys.exit(app.exec_())
if __name__ == '__main__':
   window()