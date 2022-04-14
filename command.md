###### 连接MySQL服务器

 mysql -u root -p



###### 运行sql文件

\\. route\filename

\ .  E:\Courses\8_2022_spring\Database_System\Lab\Lab1\Code\sql\CreateTable.sql



######  创建数据库menagerie

CREATE DATABASE menagerie;

 

###### 查看MySQL中有哪些数据库

show databases; 

 

###### 使用数据库mysql

use mysql;

 

######  查看当前使用的数据库

select database();

 

###### 创建宠物信息关系pet，包含宠物名字、主人、种类、性别、出生和死亡日期

CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20),

-> species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);

 

###### 查看数据库mysql中有哪些关系

show tables;

 

###### 查看数据库mysql中关系的模式（以关系user为例）

describe user;



###### 向关系pet中插入元组

INSERT INTO pet

-> VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL);

 

###### 使用help命令来了解其他命令和变量类型等的含义

help;

help use;

 

###### 使用SQL语言在数据库mysql上进行简单查询

select * from user;

select user, host, password from user;

select count(*) from user;

select count(*) as ucount from user;

 

###### 更改关系pet中的数据

UPDATE pet SET birth = "1989-08-31" WHERE name = "Bowser";



###### 取消命令

若要取消一条正在编辑命令，键入\c并回车

 

###### 断开MySQL服务器连接

quit 或 exit

 

###### 从文件中批量导入数据

设D:\pet.txt是一个由字符Tab分隔的文本文件

Fluffy  Harold  cat f   1993-02-04 \N

Claws  Gwen   cat m  1994-03-17 \N

Buffy   Harold  dog f   1989-05-13 \N

Fang   Benny  dog m  1990-08-27 \N

Bowser Diane  dog m  1998-08-31 1995-07-29 

Chirpy  Gwen   bird f   1998-09-11 \N

Whistler Gwen   bird \N  1997-12-09 \N

Slim   Benny  snake   m  1996-04-29 \N

在MySQL提示符下执行

LOAD DATA LOCAL INFILE "D:\pet.txt" INTO TABLE pet;

 