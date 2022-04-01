

-- ----------------------------
-- Records of faculty
-- ----------------------------
LOCK TABLES `faculty` WRITE;
INSERT INTO `faculty` VALUES ('001','计算机科学与技术学院');
INSERT INTO `faculty` VALUES ('002','航天学院');
INSERT INTO `faculty` VALUES ('003','经管学院');
INSERT INTO `faculty` VALUES ('004','能源学院');
INSERT INTO `faculty` VALUES ('005','电子信息学院');
UNLOCK TABLES;

-- ----------------------------
-- Records of class
-- ----------------------------
LOCK TABLES `class` WRITE;
INSERT INTO `class` VALUES ('1901301','2019','60','001');
INSERT INTO `class` VALUES ('1901302','2019','57','001');
INSERT INTO `class` VALUES ('1902501','2019','53','002');
INSERT INTO `class` VALUES ('1902502','2019','55','002');
UNLOCK TABLES;

-- ----------------------------
-- Records of student
-- ----------------------------
LOCK TABLES `student` WRITE;
INSERT INTO `student` VALUES ('1190130101','张明','男','1901301','2000-09-27',NULL,NULL);
INSERT INTO `student` VALUES ('1190130102','张量','男','1901301','2000-10-09',NULL,NULL);
INSERT INTO `student` VALUES ('1190130201','王欢','女','1901302','2001-06-20',NULL,NULL);
INSERT INTO `student` VALUES ('1190250101','张宁','女','1902501','2000-08-25',NULL,NULL);
INSERT INTO `student` VALUES ('1190250201','林琳','女','1902502','2001-07-18',NULL,NULL);
UNLOCK TABLES;

