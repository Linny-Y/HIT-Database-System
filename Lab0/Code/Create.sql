DROP DATABASE company;
CREATE DATABASE COMPANY;  # 公司数据库
USE COMPANY;

CREATE TABLE `EMPLOYEE`  (  #工作人员
    `ESSN` varchar(18) PRIMARY KEY,    #工作人员身份证号
    `ENAME` varchar(100) ,    #工作人员名字
    `ADDRESS` varchar(200) ,    #工作人员住址
    `SALARY` INTEGER ,    #工作人员工资
    `SUPERSSN` varchar(18) ,    #工作人员直接领导的身份证号
    `DNO` varchar(10) ,    #所属部门号
    FOREIGN KEY (`SUPERSSN`) REFERENCES `EMPLOYEE`(`ESSN`),
    FOREIGN KEY (`DNO`) REFERENCES `DEPARTMENT`(`DNEMBER`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `DEPARTMENT`  (  # 部门
    `DNEMBER` varchar(10) PRIMARY KEY,    #部门号
    `DNAME` varchar(100),    #部门名
    `MGRSSN` varchar(18) ,    #部门领导身份证号
    `MGRSTARTDATE` date ,   #部门领导开始领导工作的日期
    FOREIGN KEY (`MGRSSN`) REFERENCES `EMPLOYEE`(`ESSN`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `PROJECT`  (   # 工程项目
    `PNO` varchar(10) PRIMARY KEY,    #工程项目号
    `PNAME` varchar(100) ,    #工程项目名
    `PLOCATION` varchar(200) ,    #工程项目所在地
    `DNO` varchar(10) ,    #工程项目所属部门号
    FOREIGN KEY (`DNO`) REFERENCES `DEPARTMENT`(`DNEMBER`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `WORKS_ON`  (   #工作安排
    `ESSN` varchar(18) ,    #工作人员身份证号
    `PNO` varchar(10) ,    #工程项目号
    `HOURS` INTEGER ,     #工作小时数
    PRIMARY KEY (`ESSN`,`PNO`),
    FOREIGN KEY (`ESSN`) REFERENCES `EMPLOYEE`(`ESSN`),
    FOREIGN KEY (`PNO`) REFERENCES `PROJECT`(`PNO`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;






