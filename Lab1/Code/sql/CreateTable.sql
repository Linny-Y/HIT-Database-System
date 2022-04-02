
DROP TABLE IF EXISTS `choose`;
DROP TABLE IF EXISTS `time`;
DROP TABLE IF EXISTS `classroom`;
DROP TABLE IF EXISTS `teach`;
DROP TABLE IF EXISTS `schedule`;
DROP TABLE IF EXISTS `course`;
DROP TABLE IF EXISTS `employment`;
DROP TABLE IF EXISTS `teacher`;
DROP TABLE IF EXISTS `student`;
DROP TABLE IF EXISTS `class`;
DROP TABLE IF EXISTS `faculty`;
-- ----------------------------
-- Table structure for faculty
-- ----------------------------
CREATE TABLE `faculty`  (
    `fno` varchar(4) NOT NULL COMMENT '学院编号',
    `fname` varchar(30) NOT NULL COMMENT '学院名称',
    primary key (`fno`),
    key (`fname`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '学院';

-- ----------------------------
-- Table structure for class
-- ----------------------------
CREATE TABLE `class`  (
    `cno` varchar(10) NOT NULL COMMENT '班级编号',
    `grade` varchar(10) NOT NULL COMMENT '年级',
    -- `num` INTEGER COMMENT '人数',
    `fno` varchar(4) NOT NULL COMMENT '学院编号',
    primary key (`cno`),
    foreign key (`fno`) references `faculty`(`fno`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '班级';

-- ----------------------------
-- Table structure for student
-- ----------------------------
CREATE TABLE `student`  (
    `sno` varchar(20) NOT NULL COMMENT '学号',
    `sname` varchar(40) NOT NULL COMMENT '学生姓名',
    `ssex` varchar(10) check (`ssex` in('male','female')) NOT NULL COMMENT '学生性别',
    `cno` varchar(10) NOT NULL COMMENT '班级编号',
    `sage` INTEGER NOT NULL COMMENT '年龄',
    -- `sphone` varchar(15) COMMENT '电话号码',
    -- `saddress` varchar(200) COMMENT '家庭住址',
    primary key (`sno`),
    foreign key (`cno`) references `class`(`cno`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '学生';

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
CREATE TABLE `teacher`  (
    `tno` varchar(20) NOT NULL COMMENT '教师工号',
    `tname` varchar(40) NOT NULL COMMENT '教师姓名',
    `fno` varchar(4) NOT NULL COMMENT '学院编号',
    -- `tpost` varchar(10) NOT NULL COMMENT '职称',
    -- `tdegree` varchar(10) NOT NULL COMMENT '学位',
    -- `etime` DATE NOT NULL COMMENT '聘用日期',
    primary key (`tno`),
    key (`tname`),
    foreign key (`fno`) references `faculty`(`fno`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '教师';


-- ----------------------------
-- Table structure for course
-- ----------------------------
CREATE TABLE `course`  (
    `courseno` varchar(20) NOT NULL COMMENT '课程号',
    `coursename` varchar(50) NOT NULL COMMENT '课程名称',
    -- `credit` INTEGER NOT NULL COMMENT '学分',
    -- `hour` INTEGER NOT NULL COMMENT '课时',
    `facultyno` varchar(4) NOT NULL COMMENT '开课学院编号',
    primary key (`courseno`),
    foreign key (`facultyno`) references `faculty`(`fno`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '课程';

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
CREATE TABLE `schedule`  (
    `courseno` varchar(20) NOT NULL COMMENT '课程号',
    `scheduleno` SMALLINT AUTO_INCREMENT COMMENT '开课号',
    `teacherno` varchar(20) NOT NULL COMMENT '教师工号',
    `year` INT(5) NOT NULL COMMENT '年份',
    `semester` varchar(10) NOT NULL COMMENT '学期',
    -- `capacity` INTEGER NOT NULL COMMENT '选课容量',
    -- `snum` INTEGER DEFAULT 0 COMMENT '选课人数',
    check (`semester`in('spring','summer','autumn')),
    primary key (`scheduleno`),
    foreign key (`courseno`) references `course`(`courseno`),
    foreign key (`teacherno`) references `teacher`(`tno`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '课程安排';


-- ----------------------------
-- Table structure for classroom
-- ----------------------------
CREATE TABLE `classroom`  (
    `classroomno` varchar(20) NOT NULL COMMENT '教室编号',
    `building` varchar(10) NOT NULL COMMENT '所在教学楼名称',
    -- `roomcapacity` INTEGER NOT NULL COMMENT '教室容量',
    primary key (`classroomno`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '教室';

-- ----------------------------
-- Table structure for time
-- ----------------------------
CREATE TABLE `time`  (
    `scheduleno` SMALLINT NOT NULL COMMENT '开课班号',
    `time` varchar(1) check (`time`in('1','2','3','4','5','6')) NOT NULL COMMENT '上课时间',
    `classroomno` varchar(20) NOT NULL COMMENT '教室编号',
    primary key (`scheduleno`,`time`),
    foreign key (`scheduleno`) references `schedule`(`scheduleno`),
    foreign key (`classroomno`) references `classroom`(`classroomno`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '时间教室安排';

-- ----------------------------
-- Table structure for choose
-- ----------------------------
CREATE TABLE `choose`  (
    `studentno` varchar(20) NOT NULL COMMENT '学号',
    `courseno` varchar(20) NOT NULL COMMENT '课程号',
    `scheduleno` SMALLINT NOT NULL COMMENT '开课班号',
    `teacherno` varchar(20) NOT NULL COMMENT '教师工号',
    `score` varchar(3) COMMENT '成绩',
    -- `recorddate` datetime COMMENT '成绩上传时间',
    primary key (`studentno`,`courseno`),
    foreign key (`studentno`) references `student`(`sno`),
    foreign key (`courseno`) references `course`(`courseno`),
    foreign key (`scheduleno`) references `schedule`(`scheduleno`),
    foreign key (`teacherno`) references `teacher`(`tno`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT '选课';
