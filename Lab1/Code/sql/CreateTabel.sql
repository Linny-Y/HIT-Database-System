
-- ----------------------------
-- Table structure for faculty
-- ----------------------------
DROP TABLE IF EXISTS `faculty`;
CREATE TABLE `faculty`  (
    `fno` varchar(4) NOT NULL COMMENT '学院编号',
    `fname` varchar(30) NOT NULL COMMENT '学院名称',
    primary key (`fno`)
)COMMENT '学院';

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`  (
    `cno` varchar(10) NOT NULL COMMENT '班级编号',
    `grade` varchar(10) NOT NULL COMMENT '年级',
    `num` INTEGER COMMENT '人数',
    `fno` varchar(4) NOT NULL COMMENT '学院编号',
    primary key (`cno`),
    foreign key (`fno`) references `faculty`(`fno`)
)COMMENT '班级';

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
    `sno` varchar(20) NOT NULL COMMENT '学号',
    `sname` varchar(40) NOT NULL COMMENT '学生姓名',
    `ssex` varchar(2) check `ssex` in('男','女') NOT NULL COMMENT '学生性别',
    `sbirthday` DATE NOT NULL COMMENT '出生日期',
    `sphone` varchar(15) COMMENT '电话号码',
    `saddress` varchar(200) COMMENT '家庭住址',
    `cno` varchar(10) NOT NULL COMMENT '班级编号',
    primary key (`sno`),
    foreign key (`cno`) references `class`(`cno`)
)COMMENT '学生';

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
    `tno` varchar(20) NOT NULL COMMENT '教师工号',
    `tname` varchar(40) NOT NULL COMMENT '教师姓名',
    `tpost` varchar(10) NOT NULL COMMENT '职称',
    `tdegree` varchar(10) NOT NULL COMMENT '学位',
    primary key (`tno`)
)COMMENT '教师';

-- ----------------------------
-- Table structure for employment
-- ----------------------------
DROP TABLE IF EXISTS `employment`;
CREATE TABLE `employment`  (
    `tno` varchar(20) NOT NULL COMMENT '教师工号',
    `fno` varchar(4) NOT NULL COMMENT '学院编号',
    `etime` DATE NOT NULL COMMENT '聘用日期',
    primary key (`tno`,`fno`),
    foreign key (`tno`) references `teacher`(`tno`),
    foreign key (`fno`) references `faculty`(`fno`)
)COMMENT '聘用';

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
    `courseno` varchar(20) NOT NULL COMMENT '课程号',
    `coursename` varchar(20) NOT NULL COMMENT '课程名称',
    `credit` INTEGER NOT NULL COMMENT '学分',
    `hour` INTEGER NOT NULL COMMENT '课时',
    `fno` varchar(4) NOT NULL COMMENT '开课学院编号',
    primary key (`courseno`),
    foreign key (`fno`) references `faculty`(`fno`)
)COMMENT '课程';

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
    `courseno` varchar(20) NOT NULL COMMENT '课程号',
    `coursename` varchar(20) NOT NULL COMMENT '课程名称',
    `credit` INTEGER NOT NULL COMMENT '学分',
    `hour` INTEGER NOT NULL COMMENT '课时',
    `fno` varchar(4) NOT NULL COMMENT '开课学院编号',
    primary key (`courseno`),
    foreign key (`fno`) references `faculty`(`fno`)
)COMMENT '课程';