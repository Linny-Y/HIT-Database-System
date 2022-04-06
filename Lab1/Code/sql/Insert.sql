
-- ----------------------------
-- Records of faculty
-- ----------------------------
LOCK TABLES `faculty` WRITE;
INSERT INTO `faculty` VALUES ('001','CS');
INSERT INTO `faculty` VALUES ('002','SA');
INSERT INTO `faculty` VALUES ('003','SOM');
INSERT INTO `faculty` VALUES ('005','SEIE');
UNLOCK TABLES;

-- ----------------------------
-- Records of class
-- ----------------------------
LOCK TABLES `class` WRITE;
INSERT INTO `class` VALUES ('1901301','2019','001');
INSERT INTO `class` VALUES ('1901302','2019','001');
INSERT INTO `class` VALUES ('1903601','2019','001');
INSERT INTO `class` VALUES ('1902501','2019','002');
INSERT INTO `class` VALUES ('1902502','2019','002');
UNLOCK TABLES;

-- ----------------------------
-- Records of student
-- ----------------------------
LOCK TABLES `student` WRITE;
INSERT INTO `student` VALUES ('1190130101','zhangming','male','1901301',20);
INSERT INTO `student` VALUES ('1190130102','xuliang','male','1901301',20);
INSERT INTO `student` VALUES ('1190130201','wanghuan','female','1901302',19);
INSERT INTO `student` VALUES ('1190250101','zhangning','female','1902501',20);
INSERT INTO `student` VALUES ('1190250201','linlin','female','1902502',19);
UNLOCK TABLES;

-- ----------------------------
-- Records of teacher
-- ----------------------------
LOCK TABLES `teacher` WRITE;
INSERT INTO `teacher` VALUES ('0172510217','zhangliang','001');
INSERT INTO `teacher` VALUES ('0172510218','liming','001');
INSERT INTO `teacher` VALUES ('0172510220','wangliang','001');

INSERT INTO `teacher` VALUES ('0172510221','shiyu','001');
INSERT INTO `teacher` VALUES ('0172510219','wanghu','002');

INSERT INTO `teacher` VALUES ('0172510222','fanghua','001');
INSERT INTO `teacher` VALUES ('0172510223','wangyi','001');
INSERT INTO `teacher` VALUES ('0172510224','liushan','001');
UNLOCK TABLES;

-- ----------------------------
-- Records of course
-- ----------------------------
LOCK TABLES `course` WRITE;
INSERT INTO `course` VALUES ('CS33502','Compiler_System','001');
INSERT INTO `course` VALUES ('CS32255','Information_retrieval','001');
INSERT INTO `course` VALUES ('CS33503','Database_System','001');
UNLOCK TABLES;

-- ----------------------------
-- Records of classroom
-- ----------------------------
LOCK TABLES `classroom` WRITE;
INSERT INTO `classroom` VALUES ('A24','A');
INSERT INTO `classroom` VALUES ('A32','A');
INSERT INTO `classroom` VALUES ('A12','A');
UNLOCK TABLES;



INSERT INTO `schedule` VALUES ('CS33502',NULL,'0172510217',2022,'spring');
INSERT INTO `schedule` VALUES ('CS33502',NULL,'0172510218',2022,'spring');
INSERT INTO `schedule` VALUES ('CS33502',NULL,'0172510220',2022,'spring');

INSERT INTO `schedule` VALUES ('CS32255',NULL,'0172510221',2022,'spring');
INSERT INTO `schedule` VALUES ('CS32255',NULL,'0172510219',2022,'spring');

INSERT INTO `schedule` VALUES ('CS33503',NULL,'0172510220',2022,'spring');


