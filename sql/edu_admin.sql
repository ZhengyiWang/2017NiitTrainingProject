drop database if exists edu_admin;

create database edu_admin;
use edu_admin;

-- ----------------------------
-- Table structure for academy
-- ----------------------------
DROP TABLE IF EXISTS `academy`;
CREATE TABLE `academy` (
  `academyId` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '学院Id',
  `academyName` varchar(20) NOT NULL COMMENT '学院名称',
  --`shortName` varchar(10) NOT NULL COMMENT '学院简称',
  `dean` varchar(10) NOT NULL COMMENT '院长',
  `tel` varchar(20) NOT NULL COMMENT '学院办公室电话',
  `email` varchar(50) DEFAULT NULL COMMENT '学院邮箱',
  `address` varchar(100) DEFAULT NULL COMMENT '学院地址',
  PRIMARY KEY (`academyId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='学院';

-- ----------------------------
-- Records of academy
-- ----------------------------


-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `adminId` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员Id',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `subjectId` smallint(6) NOT NULL COMMENT '学院Id/专业Id（如果是专业级管理员，则为专业ID，否则为学院ID）',
  `roleId` tinyint(4) NOT NULL COMMENT '角色Id（0：超级管理员；1：院级管理员；2:专业级管理员）',
  `registerTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `lastTime` datetime DEFAULT NULL COMMENT '上次登录时间',
  PRIMARY KEY (`adminId`),
  KEY `fk_admin_role` (`roleId`),
  CONSTRAINT `fk_admin_role` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Records of admin
-- ----------------------------


-- ----------------------------
-- Table structure for allotinfo
-- ----------------------------
DROP TABLE IF EXISTS `allotinfo`;
CREATE TABLE `allotinfo` (
  `studentNum` char(12) NOT NULL COMMENT '学号',
  `schoolYear` char(9) NOT NULL COMMENT '学年',
  `type` smallint(6) NOT NULL COMMENT '申请类别（1：助学金，2：国家励志奖学金，3：国家奖学金）',
  KEY `fk_allotInfo_student` (`studentNum`),
  KEY `fk_allotInfo_schoolYear` (`schoolYear`),
  CONSTRAINT `fk_allotInfo_student` FOREIGN KEY (`studentNum`) REFERENCES `student` (`studentNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分配信息';

-- ----------------------------
-- Records of allotinfo
-- ----------------------------


-- ----------------------------
-- Table structure for applyinfo
-- ----------------------------
DROP TABLE IF EXISTS `applyinfo`;
CREATE TABLE `applyinfo` (
  `studentNum` char(12) NOT NULL COMMENT '学号',
  `fileId` varchar(32) NOT NULL DEFAULT '' COMMENT '文件Id',
  `type` smallint(6) NOT NULL COMMENT '申请类别（1：助学金，2：国家励志奖学金，3：国家奖学金，4：勤工岗位）',
  `classId` int(11) DEFAULT NULL,
  `studentName` varchar(10) DEFAULT NULL,
  KEY `fk_applyInfo_student` (`studentNum`),
  KEY `fk_applyInfo_upFile` (`fileId`),
  KEY `classId` (`classId`),
  KEY `studentName` (`studentName`),
  CONSTRAINT `applyinfo_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`classId`),
  CONSTRAINT `fk_applyInfo_student` FOREIGN KEY (`studentNum`) REFERENCES `student` (`studentNum`),
  CONSTRAINT `fk_applyInfo_upFile` FOREIGN KEY (`fileId`) REFERENCES `upfile` (`fileId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='申请信息';

-- ----------------------------
-- Records of applyinfo
-- ----------------------------


-- ----------------------------
-- Table structure for awards
-- ----------------------------
DROP TABLE IF EXISTS `awards`;
CREATE TABLE `awards` (
  `studentNum` char(12) NOT NULL COMMENT '学号',
  `awardsName` varchar(40) NOT NULL COMMENT '奖项名称',
  `rewardsBureau` varchar(40) NOT NULL COMMENT '颁奖单位',
  `obtainTime` date NOT NULL COMMENT '获奖时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='获奖信息';

-- ----------------------------
-- Records of awards
-- ----------------------------


-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `classId` int(11) NOT NULL AUTO_INCREMENT COMMENT '班级Id',
  `className` varchar(20) NOT NULL COMMENT '班级名称',
  `majorId` smallint(6) NOT NULL COMMENT '专业Id',
  `grade` char(4) NOT NULL COMMENT '年级',
  `classTeacher` varchar(10) NOT NULL COMMENT '班主任',
  `teacherTel` varchar(20) DEFAULT NULL COMMENT '班主任联系电话',
  `monitor` varchar(10) DEFAULT NULL COMMENT '班长',
  `monitor_connection` varchar(20) DEFAULT NULL COMMENT '班长联系方式',
  PRIMARY KEY (`classId`),
  KEY `fk_class_major` (`majorId`),
  KEY `fk_class_grade` (`grade`),
  CONSTRAINT `fk_class_grade` FOREIGN KEY (`grade`) REFERENCES `grade` (`grade`),
  CONSTRAINT `fk_class_major` FOREIGN KEY (`majorId`) REFERENCES `major` (`majorId`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='班级';

-- ----------------------------
-- Records of class
-- ----------------------------


-- ----------------------------
-- Table structure for classscore
-- ----------------------------
DROP TABLE IF EXISTS `classscore`;
CREATE TABLE `classscore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classId` int(11) NOT NULL COMMENT '班级id值',
  `schoolyear` varchar(255) NOT NULL COMMENT '学年',
  `teamum` int(255) NOT NULL DEFAULT '0' COMMENT '该学年的第几学期',
  `status` int(11) NOT NULL COMMENT '0表示已经导入成绩，1表示已经产生成绩统计结果的',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='该表保存已经导入某一学年成绩的班级';

-- ----------------------------
-- Records of classscore
-- ----------------------------


-- ----------------------------
-- Table structure for conductbasicdata
-- ----------------------------
DROP TABLE IF EXISTS `conductbasicdata`;
CREATE TABLE `conductbasicdata` (
  `id` int(10) NOT NULL,
  `conduct_basic` varchar(30) NOT NULL COMMENT '操行分统计中的一些固定数据',
  `conduct_score` double(10,2) NOT NULL COMMENT '分数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操行分的一些基本的不变的数据存储表';

-- ----------------------------
-- Records of conductbasicdata
-- ----------------------------
INSERT INTO `conductbasicdata` VALUES ('1', '思想道德素质|基本分', '60');

-- ----------------------------
-- Table structure for conducthavenext
-- ----------------------------
DROP TABLE IF EXISTS `conducthavenext`;
CREATE TABLE `conducthavenext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conduct_havenext` varchar(40) NOT NULL COMMENT '操行分有下一级项目的项',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of conducthavenext
-- ----------------------------
INSERT INTO `conducthavenext` VALUES ('1', '思想道德素质|奖励加分项');
INSERT INTO `conducthavenext` VALUES ('2', '思想道德素质|扣分项');
INSERT INTO `conducthavenext` VALUES ('3', '社会实践能力|技术技能');

-- ----------------------------
-- Table structure for conductitem
-- ----------------------------
DROP TABLE IF EXISTS `conductitem`;
CREATE TABLE `conductitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conduct_name` varchar(255) NOT NULL COMMENT '手动添加的操行分项',
  `conduct_superitem` int(10) NOT NULL COMMENT '该操行分的上一级项',
  `schoolyear` varchar(255) NOT NULL COMMENT '学年',
  PRIMARY KEY (`id`),
  KEY `superitem` (`conduct_superitem`),
  KEY `schoolyear` (`schoolyear`),
  CONSTRAINT `schoolyear` FOREIGN KEY (`schoolyear`) REFERENCES `schoolyear` (`schoolYear`),
  CONSTRAINT `superitem` FOREIGN KEY (`conduct_superitem`) REFERENCES `conducthavenext` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of conductitem
-- ----------------------------
INSERT INTO `conductitem` VALUES ('1', '挑战杯', '3', '2014-2015');
INSERT INTO `conductitem` VALUES ('2', '义务献血', '1', '2014-2015');
INSERT INTO `conductitem` VALUES ('3', '中文演讲比赛', '3', '2014-2015');
INSERT INTO `conductitem` VALUES ('4', '模拟面试大赛', '3', '2014-2015');
INSERT INTO `conductitem` VALUES ('5', '职业规划大赛', '3', '2014-2015');
INSERT INTO `conductitem` VALUES ('6', '书画艺术作品大赛', '3', '2014-2015');

-- ----------------------------
-- Table structure for conductnotnext
-- ----------------------------
DROP TABLE IF EXISTS `conductnotnext`;
CREATE TABLE `conductnotnext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conduct_nothavenext` varchar(40) DEFAULT NULL COMMENT '操行分没有下一级项目的项',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of conductnotnext
-- ----------------------------
INSERT INTO `conductnotnext` VALUES ('1', '社会实践能力|科技创新');
INSERT INTO `conductnotnext` VALUES ('2', '社会实践能力|组织管理分');
INSERT INTO `conductnotnext` VALUES ('3', '社会实践能力|特殊分');

-- ----------------------------
-- Table structure for conduct_next_score
-- ----------------------------
DROP TABLE IF EXISTS `conduct_next_score`;
CREATE TABLE `conduct_next_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` varchar(255) NOT NULL COMMENT '外键，学生',
  `c_item` int(10) NOT NULL COMMENT '外键，关联conductitem表',
  `score` double(10,4) NOT NULL COMMENT '分数',
  PRIMARY KEY (`id`),
  KEY `c_item` (`c_item`),
  CONSTRAINT `c_item` FOREIGN KEY (`c_item`) REFERENCES `conductitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of conduct_next_score
-- ----------------------------


-- ----------------------------
-- Table structure for conduct_notnext_score
-- ----------------------------
DROP TABLE IF EXISTS `conduct_notnext_score`;
CREATE TABLE `conduct_notnext_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` varchar(255) NOT NULL COMMENT '学生外键',
  `c_notnext` int(11) NOT NULL COMMENT '外键，没有下一级项目的操行分项目表',
  `score` double NOT NULL,
  `schoolyear` varchar(255) NOT NULL COMMENT '学年',
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `notnext_item` (`c_notnext`),
  KEY `schooleyear` (`schoolyear`),
  CONSTRAINT `notnext_item` FOREIGN KEY (`c_notnext`) REFERENCES `conductnotnext` (`id`),
  CONSTRAINT `schooleyear` FOREIGN KEY (`schoolyear`) REFERENCES `schoolyear` (`schoolYear`),
  CONSTRAINT `sid` FOREIGN KEY (`sid`) REFERENCES `student` (`studentNum`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of conduct_notnext_score
-- ----------------------------
INSERT INTO `conduct_notnext_score` VALUES ('1', '201111621314', '1', '2.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('2', '201111621320', '1', '2.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('3', '201111621321', '1', '2.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('4', '201211621201', '1', '7.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('5', '201211621202', '1', '9.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('6', '201211621201', '2', '6.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('7', '201211621202', '2', '9', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('8', '201211621201', '3', '4.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('9', '201211621202', '3', '9.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('10', '201211621207', '2', '2', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('11', '201211621211', '2', '4', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('12', '201211621206', '1', '0.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('13', '201211621208', '1', '0.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('14', '201211621211', '1', '0.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('15', '201211621213', '1', '0.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('16', '201211621226', '1', '0.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('17', '201211621228', '1', '0.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('18', '201211621230', '1', '0.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('19', '201211621231', '1', '0.5', '2014-2015');
INSERT INTO `conduct_notnext_score` VALUES ('20', '201211621233', '1', '1', '2014-2015');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `cno` varchar(20) NOT NULL COMMENT '课程名',
  `majorID` smallint(6) DEFAULT NULL COMMENT '外键，专业',
  `grade` int(10) DEFAULT NULL COMMENT ' 年级，类似12级的就是12',
  `course_status` int(10) NOT NULL COMMENT '课程的状态，0为必修，1为选修，2为体育课',
  `credit` double(10,2) DEFAULT NULL COMMENT '学分',
  `schoolyear` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `major` (`majorID`),
  CONSTRAINT `major` FOREIGN KEY (`majorID`) REFERENCES `major` (`majorId`)
) ENGINE=InnoDB AUTO_INCREMENT=839 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('624', 'C++程序设计', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('625', '大学英语III', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('626', '高等数学I', '1', '12', '0', '4.50', '2014-2015');
INSERT INTO `course` VALUES ('627', '计算机导论', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('632', '青年学生健康教育', '1', '12', '0', '1.50', '2014-2015');
INSERT INTO `course` VALUES ('634', '思想道德修养与法律基础', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('637', '形势与政策教育I', '1', '12', '0', '1.50', '2014-2015');
INSERT INTO `course` VALUES ('640', 'C++程序设计课程设计', '1', '12', '0', '1.00', '2014-2015');
INSERT INTO `course` VALUES ('645', '大学物理III', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('646', '大学物理实验III', '1', '12', '0', '2.50', '2014-2015');
INSERT INTO `course` VALUES ('651', '电路与模拟电子技术', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('655', '高等数学Ⅰx2', '1', '12', '0', '5.50', '2014-2015');
INSERT INTO `course` VALUES ('663', '军事理论', '1', '12', '0', '2.50', '2014-2015');
INSERT INTO `course` VALUES ('690', '中国近现代史纲要', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('699', '大学英语3', '1', '12', '0', '3.50', '2013-2014');
INSERT INTO `course` VALUES ('717', '离散数学', '1', '12', '0', '3.50', '2013-2014');
INSERT INTO `course` VALUES ('720', '马克思主义基本原理', '1', '12', '0', '3.50', '2013-2014');
INSERT INTO `course` VALUES ('733', '数据结构', '1', '12', '0', '2.50', '2013-2014');
INSERT INTO `course` VALUES ('734', '数据结构课程设计', '1', '12', '0', '1.00', '2013-2014');
INSERT INTO `course` VALUES ('735', '数字电路逻辑设计', '1', '12', '0', '3.50', '2013-2014');
INSERT INTO `course` VALUES ('743', '线性代数', '1', '12', '0', '3.50', '2013-2014');
INSERT INTO `course` VALUES ('745', '形势与政策教育2', '1', '12', '0', '1.50', '2013-2014');
INSERT INTO `course` VALUES ('763', '大学英语V', '1', '12', '0', '3.50', '2013-2014');
INSERT INTO `course` VALUES ('767', '概率论与数理统计', '1', '12', '0', '3.00', '2013-2014');
INSERT INTO `course` VALUES ('774', '汇编语言', '1', '12', '0', '3.00', '2013-2014');
INSERT INTO `course` VALUES ('775', '汇编语言课程实习', '1', '12', '0', '1.00', '2013-2014');
INSERT INTO `course` VALUES ('776', '计算机组成原理', '1', '12', '0', '3.00', '2013-2014');
INSERT INTO `course` VALUES ('777', '计算机组成原理课程实习', '1', '12', '0', '1.00', '2013-2014');
INSERT INTO `course` VALUES ('786', '毛泽东思想和中国特色社会主义理论体系概论', '1', '12', '0', '4.00', '2013-2014');
INSERT INTO `course` VALUES ('794', '数据库原理及应用', '1', '12', '0', '3.50', '2013-2014');
INSERT INTO `course` VALUES ('795', '数据库原理及应用课程设计', '1', '12', '0', '1.00', '2013-2014');
INSERT INTO `course` VALUES ('811', 'Java程序设计', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('812', 'Java程序设计课程设计', '1', '12', '0', '1.00', '2014-2015');
INSERT INTO `course` VALUES ('815', '操作系统', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('819', '计算机接口技术', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('820', '计算机接口技术课程实习', '1', '12', '0', '3.00', '2014-2015');
INSERT INTO `course` VALUES ('821', '计算机网络', '1', '12', '0', '3.50', '2014-2015');
INSERT INTO `course` VALUES ('822', '计算机职业素质教育', '1', '12', '0', '2.50', '2014-2015');
INSERT INTO `course` VALUES ('823', '计算机专业英语', '1', '12', '0', '3.00', '2014-2015');
INSERT INTO `course` VALUES ('824', '软件工程', '1', '12', '0', '3.00', '2014-2015');
INSERT INTO `course` VALUES ('825', '形势与政策教育IV', '1', '12', '0', '1.50', '2014-2015');

-- ----------------------------
-- Table structure for dormitory
-- ----------------------------
DROP TABLE IF EXISTS `dormitory`;
CREATE TABLE `dormitory` (
  `dormitoryId` int(11) NOT NULL AUTO_INCREMENT COMMENT '宿舍Id',
  `dormitoryNum` varchar(10) NOT NULL COMMENT '宿舍号',
  `yardId` smallint(6) NOT NULL COMMENT '区域Id',
  PRIMARY KEY (`dormitoryId`),
  KEY `fk_dormitory_yard` (`yardId`),
  CONSTRAINT `fk_dormitory_yard` FOREIGN KEY (`yardId`) REFERENCES `yard` (`yardId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='宿舍';

-- ----------------------------
-- Records of dormitory
-- ----------------------------


-- ----------------------------
-- Table structure for downfile
-- ----------------------------
DROP TABLE IF EXISTS `downfile`;
CREATE TABLE `downfile` (
  `fileId` char(32) NOT NULL COMMENT '文件Id',
  `fileName` varchar(255) NOT NULL COMMENT '文件名',
  `fileUrl` varchar(255) NOT NULL COMMENT '文件路径',
  `releaseTime` datetime NOT NULL COMMENT '发布时间',
  `adminId` int(11) NOT NULL COMMENT '上传者',
  `description` varchar(100) NOT NULL COMMENT '文件描述',
  PRIMARY KEY (`fileId`),
  KEY `fk_downFile_admin` (`adminId`),
  CONSTRAINT `fk_downFile_admin` FOREIGN KEY (`adminId`) REFERENCES `admin` (`adminId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件下载';

-- ----------------------------
-- Records of downfile
-- ----------------------------
INSERT INTO `downfile` VALUES ('5b371a7b4340474abbc57f5d0aa3d8cb', '国家奖学金申请表.doc', '', '2014-12-01 16:53:52', '1', '国家奖学金申请表');
INSERT INTO `downfile` VALUES ('738e95f4ce6d4721a9ab65dac7c8a712', '广东海洋大学学生及家庭情况调查表.doc', '', '2014-12-01 16:53:52', '1', '广东海洋大学学生及家庭情况调查表');
INSERT INTO `downfile` VALUES ('ac63abe21e734df1926c4fc60c1d4d76', '国家助学贷款申请表.doc', '', '2014-12-01 16:53:52', '1', '国家助学贷款申请表');
INSERT INTO `downfile` VALUES ('d50a1a02b7ab4fbebf7c2a4881a94716', '国家励志奖学金申请表.doc', '', '2014-12-01 16:53:52', '1', '国家励志奖学金申请表');
INSERT INTO `downfile` VALUES ('f485b02fb50443b998197046942287c2', '家庭经济困难证明.doc', '', '2014-12-01 16:53:52', '1', '家庭经济困难证明');
INSERT INTO `downfile` VALUES ('f9da4bb8a66c43b09454389c6bed3f56', '家长承诺书.doc', '', '2014-12-01 16:53:52', '1', '家长承诺书');
INSERT INTO `downfile` VALUES ('fd48a767fb8e48cfa5e092d9fdfb4802', '勤工助学申请表.doc', '', '2014-12-01 16:53:52', '1', '勤工助学申请表');

-- ----------------------------
-- Table structure for excellentapply
-- ----------------------------
DROP TABLE IF EXISTS `excellentapply`;
CREATE TABLE `excellentapply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` char(255) NOT NULL COMMENT '学号',
  `leval` int(11) NOT NULL COMMENT '奖学金等级，1为一等奖，以此类推',
  `schoolyear` varchar(255) NOT NULL COMMENT '学年',
  `classid` int(255) DEFAULT NULL COMMENT '班级',
  PRIMARY KEY (`id`),
  KEY `classid` (`classid`),
  CONSTRAINT `classid` FOREIGN KEY (`classid`) REFERENCES `class` (`classId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of excellentapply
-- ----------------------------

-- ----------------------------
-- Table structure for extend_table
-- ----------------------------
DROP TABLE IF EXISTS `extend_table`;
CREATE TABLE `extend_table` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `extend_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of extend_table
-- ----------------------------

-- ----------------------------
-- Table structure for family
-- ----------------------------
DROP TABLE IF EXISTS `family`;
CREATE TABLE `family` (
  `studentNum` char(12) NOT NULL COMMENT '学号',
  `level` varchar(10) DEFAULT '' COMMENT '困难等级 (0：特殊困难，1：困难，2：一般困难)',
  `schoolYear` char(9) NOT NULL COMMENT '学年',
  `tel` varchar(20) NOT NULL COMMENT '家庭电话',
  `address` varchar(50) DEFAULT '' COMMENT '家庭地址',
  --`origin` varchar(20) DEFAULT NULL COMMENT '家庭出身',
  `householdType` varchar(10) NOT NULL COMMENT '家庭户口类型',
  `familySize` smallint(6) NOT NULL COMMENT '家庭人口总数',
  `monthlyIncome` int(11) NOT NULL COMMENT '家庭月收入(整数)',
  --`perMonthlyIncome` int(11) NOT NULL COMMENT '人均月收入(整数)',
  --`sourceIncome` varchar(20) NOT NULL COMMENT '收入来源',
  `comment` varchar(100) DEFAULT NULL COMMENT '备注',
  KEY `fk_family_student` (`studentNum`),
  KEY `fk_family_schoolYear` (`schoolYear`),
  CONSTRAINT `fk_family_schoolYear` FOREIGN KEY (`schoolYear`) REFERENCES `schoolyear` (`schoolYear`),
  CONSTRAINT `fk_family_student` FOREIGN KEY (`studentNum`) REFERENCES `student` (`studentNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='家庭情况';

-- ----------------------------
-- Records of family
-- ----------------------------


-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade` (
  `grade` char(4) NOT NULL COMMENT '年级（如：2011）',
  PRIMARY KEY (`grade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='年级';

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES ('2014');
INSERT INTO `grade` VALUES ('2015');
INSERT INTO `grade` VALUES ('2016');
INSERT INTO `grade` VALUES ('2017');
INSERT INTO `grade` VALUES ('2018');
INSERT INTO `grade` VALUES ('2019');
INSERT INTO `grade` VALUES ('2020');
INSERT INTO `grade` VALUES ('2021');

-- ----------------------------
-- Table structure for jobarrange
-- ----------------------------
DROP TABLE IF EXISTS `jobarrange`;
CREATE TABLE `jobarrange` (
  `studentNum` char(12) NOT NULL COMMENT '学号',
  `schoolYear` char(9) NOT NULL COMMENT '学年',
  `arrangeJob` varchar(20) NOT NULL COMMENT '安排岗位',
  `path` varchar(200) NOT NULL COMMENT '申请表路径',
  `salary` int(11) DEFAULT NULL COMMENT '工资',
  `comment` varchar(50) DEFAULT NULL COMMENT '备注',
  KEY `fk_jobArrange_student` (`studentNum`),
  KEY `fk_jobArrange_schoolYear` (`schoolYear`),
  CONSTRAINT `fk_jobArrange_schoolYear` FOREIGN KEY (`schoolYear`) REFERENCES `schoolyear` (`schoolYear`),
  CONSTRAINT `fk_jobArrange_student` FOREIGN KEY (`studentNum`) REFERENCES `student` (`studentNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='勤工助学岗位安排';

-- ----------------------------
-- Records of jobarrange
-- ----------------------------

-- ----------------------------
-- Table structure for jobtemp
-- ----------------------------
DROP TABLE IF EXISTS `jobtemp`;
CREATE TABLE `jobtemp` (
  `studentNum` char(36) DEFAULT NULL,
  `schoolYear` char(36) DEFAULT NULL,
  `slarry` int(11) DEFAULT NULL,
  `workplace` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jobtemp
-- ----------------------------
INSERT INTO `jobtemp` VALUES ('201011621101', '2014-2015', '2100', '四饭');

-- ----------------------------
-- Table structure for loanallot
-- ----------------------------
DROP TABLE IF EXISTS `loanallot`;
CREATE TABLE `loanallot` (
  `studentNum` char(12) DEFAULT NULL COMMENT '学号',
  `loanMoney` int(11) NOT NULL COMMENT '贷款金额',
  `loanYear` char(4) NOT NULL COMMENT '贷款年份',
  KEY `fk_loanAllot_student` (`studentNum`),
  KEY `fk_loanAllot_grade` (`loanYear`),
  CONSTRAINT `fk_loanAllot_grade` FOREIGN KEY (`loanYear`) REFERENCES `grade` (`grade`),
  CONSTRAINT `fk_loanAllot_student` FOREIGN KEY (`studentNum`) REFERENCES `student` (`studentNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='贷款分配';

-- ----------------------------
-- Records of loanallot
-- ----------------------------

-- ----------------------------
-- Table structure for loanapply
-- ----------------------------
DROP TABLE IF EXISTS `loanapply`;
CREATE TABLE `loanapply` (
  `studentNum` char(12) NOT NULL COMMENT '学号',
  `applyMoney` int(11) DEFAULT NULL COMMENT '计划贷款金额',
  KEY `fk_loanApply_student` (`studentNum`),
  CONSTRAINT `fk_loanApply_student` FOREIGN KEY (`studentNum`) REFERENCES `student` (`studentNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='贷款申请';

-- ----------------------------
-- Records of loanapply
-- ----------------------------

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major` (
  `majorId` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '专业Id',
  `academyId` smallint(6) NOT NULL COMMENT '学院Id',
  `majorName` varchar(30) NOT NULL COMMENT '专业名称',
  `shortName` varchar(20) NOT NULL COMMENT '专业简称',
  `counselor` varchar(10) NOT NULL COMMENT '辅导员',
  `tel` varchar(20) DEFAULT NULL COMMENT '辅导员联系电话',
  PRIMARY KEY (`majorId`),
  KEY `fk_major_academy` (`academyId`),
  CONSTRAINT `fk_major_academy` FOREIGN KEY (`academyId`) REFERENCES `academy` (`academyId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='专业';

-- ----------------------------
-- Records of major
-- ----------------------------


-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menuId` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单Id',
  `menuUrl` varchar(100) NOT NULL COMMENT '菜单路径',
  `subject` varchar(20) DEFAULT NULL COMMENT '模块名（system:系统管理; base:综合管理...）,若为null则不是导航菜单',
  `description` varchar(50) DEFAULT NULL COMMENT '菜单描述',
  PRIMARY KEY (`menuId`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', 'system/admin_updateOwnerPassword.qdu', null, '管理员修改自己的密码');
INSERT INTO `menu` VALUES ('2', 'system/admin0.jsp', 'system', '用户管理');
INSERT INTO `menu` VALUES ('3', 'system/log.jsp', 'system', '系统日志');
INSERT INTO `menu` VALUES ('4', 'system/admin_getAcademyAdmins.qdu', null, '【超管】查询所有的【院管】');
INSERT INTO `menu` VALUES ('5', 'system/admin_getMajorAdmins.qdu', null, '【超管】查询某院的所有【专管】');
INSERT INTO `menu` VALUES ('6', 'system/admin_addAdmin.qdu', null, '【超管】添加管理员');
INSERT INTO `menu` VALUES ('7', 'system/admin_changePassword.qdu', null, '【超管】修改管理员密码');
INSERT INTO `menu` VALUES ('8', 'system/admin_deleteAdmin.qdu', null, '【超管】删除管理员');
INSERT INTO `menu` VALUES ('9', 'system/admin1.jsp', 'system', '用户管理');
INSERT INTO `menu` VALUES ('10', 'system/admin_role1GetMajorAdmins.qdu', null, '【院管】查询其院的所有【专管】');
INSERT INTO `menu` VALUES ('11', 'system/admin_role1AddMajorAdmin.qdu', null, '【院管】添加【专管】');
INSERT INTO `menu` VALUES ('12', 'system/admin_role1ChangeRole2Pwd.qdu', null, '【院管】修改【专管】密码');
INSERT INTO `menu` VALUES ('13', 'system/admin_role1DeleteMajorAdmin.qdu', null, '【院管】删除【专管】');
INSERT INTO `menu` VALUES ('14', 'base/academy.jsp', 'base', '学院信息维护');
INSERT INTO `menu` VALUES ('15', 'base/academy_add.qdu', null, '添加学院');
INSERT INTO `menu` VALUES ('16', 'base/academy_update.qdu', null, '更新学院');
INSERT INTO `menu` VALUES ('17', 'base/academy_delete.qdu', null, '删除学院');
INSERT INTO `menu` VALUES ('18', 'base/academy_queryByPage.qdu', null, '分页提取学院信息（用于显示学院的整体信息）');
INSERT INTO `menu` VALUES ('19', 'base/academy_getAllAcademys.qdu', null, '查询所有学院（用于下拉框）');
INSERT INTO `menu` VALUES ('20', 'base/major0.jsp', 'base', '专业信息维护');
INSERT INTO `menu` VALUES ('21', 'base/major_getMajorsByAcademyId.qdu', null, '【超管】查某院的所有专业');
INSERT INTO `menu` VALUES ('22', 'base/major_role1GetMajorsByAcademyId.qdu', null, '【院管】查本院的所有专业');
INSERT INTO `menu` VALUES ('23', 'base/class0.jsp', 'base', '班级信息维护');
INSERT INTO `menu` VALUES ('24', 'base/student.jsp', 'base', '学生信息维护');
INSERT INTO `menu` VALUES ('25', 'scholarships/meritScholarship.jsp', 'scholarships', '优秀奖学金管理');
INSERT INTO `menu` VALUES ('26', 'workstudy/nationalScholarship.jsp', 'scholarships', '国家奖学金管理');
INSERT INTO `menu` VALUES ('27', 'workstudy/attendancePosts.jsp', 'workstudy', '勤工岗位管理');
INSERT INTO `menu` VALUES ('28', 'workstudy/grants.jsp', 'workstudy', '助学金管理');
INSERT INTO `menu` VALUES ('29', 'workstudy/loans.jsp', 'workstudy', '助学贷款管理');
INSERT INTO `menu` VALUES ('30', 'workstudy/motivationalScholarships.jsp', 'workstudy', '励志奖学金管理');
INSERT INTO `menu` VALUES ('31', 'workstudy/poorStudents.jsp', 'workstudy', '贫困生管理');
INSERT INTO `menu` VALUES ('32', 'yard/yard.jsp', 'yard', '区域信息维护');
INSERT INTO `menu` VALUES ('33', 'yard/dormitory.jsp', 'yard', '宿舍信息维护');
INSERT INTO `menu` VALUES ('36', 'other/other1.jsp', 'other', '其他功能1');
INSERT INTO `menu` VALUES ('37', 'other/other2.jsp', 'other', '其他功能2');
INSERT INTO `menu` VALUES ('38', 'scholarships/scoreInput.jsp', 'scholarships', '班级成绩导入');
INSERT INTO `menu` VALUES ('39', 'scholarships/scoreInput_fileupload.qdu', null, '导入成绩表格');
INSERT INTO `menu` VALUES ('40', 'scholarships/scoreInput_scoreInput.qdu', null, '成绩导入');
INSERT INTO `menu` VALUES ('41', 'conductpoints/conductCut.jsp', 'conductpoints', '操行分数据导出');
INSERT INTO `menu` VALUES ('42', 'conductpoints/conductPoints.jsp', 'conductpoints', '操行分数据管理');
INSERT INTO `menu` VALUES ('43', 'conductpoints/conduct_getSecondConduct.qdu', null, '获得操行分二级项');
INSERT INTO `menu` VALUES ('44', 'conductpoints/conduct_getSchooltyear.qdu', null, '获得学年');
INSERT INTO `menu` VALUES ('45', 'conductpoints/conduct_insertConduct.qdu', null, '保存操行分项');
INSERT INTO `menu` VALUES ('46', 'conductpoints/conduct_getAcademy.qdu', null, '获取学院');
INSERT INTO `menu` VALUES ('47', 'conductpoints/conduct_getMajor.qdu', null, '获取专业');
INSERT INTO `menu` VALUES ('48', 'conductpoints/conduct_getClassWithMajor.qdu', null, '获取班级');
INSERT INTO `menu` VALUES ('49', 'conductpoints/conduct_getStudent.qdu', null, '获得一个班的所有学生');
INSERT INTO `menu` VALUES ('50', 'conductpoints/conduct_getConductItem.qdu', null, '获取操行分选项');
INSERT INTO `menu` VALUES ('51', 'conductpoints/conduct_insertConductScore.qdu', null, '添加操行分');
INSERT INTO `menu` VALUES ('52', 'system/admin_role1AddStudentAdmin.qdu', null, '添加学生管理员');
INSERT INTO `menu` VALUES ('53', 'system/admin_role1GetStudentAdmins.qdu', null, '获得某个学院的所有学生管理员');
INSERT INTO `menu` VALUES ('54', 'scholarships/scholarshipCut.jsp', 'scholarships', '奖学金数据导出');
INSERT INTO `menu` VALUES ('55', 'scholarships/scholarships_downDataTable.qdu', null, '导出表格');
INSERT INTO `menu` VALUES ('56', 'conductpoints/conductOut_downDataTable.qdu', null, '操行分表格的导出');
INSERT INTO `menu` VALUES ('57', 'scholarships/scholarships_showjiangxuejingByClass.qdu', null, '展示一个班的奖学金获得的情况');
INSERT INTO `menu` VALUES ('58', 'scholarships/scholarships_refresh.qdu', null, '刷新奖学金名单');
INSERT INTO `menu` VALUES ('59', 'workstudy/admin_showpoorstudent.qdu', null, '查看申请学生');
INSERT INTO `menu` VALUES ('60', 'workstudy/admin_allotStudent.qdu', null, '分配评定权限');
INSERT INTO `menu` VALUES ('61', 'workstudy/admin_showResult.qdu', null, '查看评定结果');
INSERT INTO `menu` VALUES ('62', 'workstudy/admin_saveallot.qdu', null, '分配学生');
INSERT INTO `menu` VALUES ('63', 'workstudy/admin_queryClasses.qdu', null, '查询该辅导员管理的班级');
INSERT INTO `menu` VALUES ('64', 'workstudy/admin_getApplyStudents.qdu', null, '显示一些东西');
INSERT INTO `menu` VALUES ('65', 'workstudy/admin_getLoanStudents.qdu', null, '处理贷款相关信息');
INSERT INTO `menu` VALUES ('66', 'workstudy/admin_getAttendanceStudents.qdu', null, '处理勤工岗位的信息');
INSERT INTO `menu` VALUES ('67', 'workstudy/admin_getMotivationalStudents.qdu', null, '处理励志奖学金');
INSERT INTO `menu` VALUES ('68', 'unfinish.jsp', null, '未完成评估学生的名单');
INSERT INTO `menu` VALUES ('69', 'workstudy/todo_allotManyMoney.qdu', null, '分配一些东西');
INSERT INTO `menu` VALUES ('70', 'workstudy/admin_showStudent.qdu', null, '查看学生的个人资料');
INSERT INTO `menu` VALUES ('71', 'workstudy/admin_showStudent.jsp', null, '下载学生的申请表格');
INSERT INTO `menu` VALUES ('72', 'workstudy/exporttable.jsp', 'workstudy', '导出表格');
INSERT INTO `menu` VALUES ('73', 'workstudy/admin_export.qdu', null, null);
INSERT INTO `menu` VALUES ('74', 'base/major1.jsp', 'base', '专业信息维护');
INSERT INTO `menu` VALUES ('75', 'base/major_role0AddMajor.qdu', null, '添加专业（超级管理员）');
INSERT INTO `menu` VALUES ('76', 'base/major_role0EditMajor.qdu', null, '修改专业信息（超级管理员）');
INSERT INTO `menu` VALUES ('77', 'base/major_role0DestoryMajor.qdu', null, '删除专业信息（超级管理员）');
INSERT INTO `menu` VALUES ('78', 'base/major_role1AddMajor.qdu', null, '添加专业（院级管理员）');
INSERT INTO `menu` VALUES ('79', 'base/major_role1EditMajor.qdu', null, '修改专业（院级管理员）');
INSERT INTO `menu` VALUES ('80', 'base/major_role1DestoryMajor.qdu', null, '删除专业信息（院级管理员）');
INSERT INTO `menu` VALUES ('81', 'base/class_getClasssByMajorId.qdu', null, '获取班级列表');
INSERT INTO `menu` VALUES ('82', 'base/class_role0AddClass.qdu', null, '添加班级信息');
INSERT INTO `menu` VALUES ('83', 'base/class_role0EditClass.qdu', null, '编辑班级信息');
INSERT INTO `menu` VALUES ('84', 'base/class_role0DestoryClass.qdu', null, '删除班级信息');
INSERT INTO `menu` VALUES ('85', 'base/class1.jsp', 'base', '班级信息维护');
INSERT INTO `menu` VALUES ('86', 'base/class2.jsp', 'base', '班级信息维护');
INSERT INTO `menu` VALUES ('87', 'base/studentInfo_queryStudentInfo.qdu', null, '获取学生简略信息');
INSERT INTO `menu` VALUES ('88', 'base/studentInfo_getAllInfosByNum.qdu', null, '获取学生详细信息');
INSERT INTO `menu` VALUES ('89', 'base/studentInfo_exportData.qdu', null, '导出学生信息');
INSERT INTO `menu` VALUES ('90', 'base/studentInfo_uploadFile.qdu', null, '上传学生信息或图片');
INSERT INTO `menu` VALUES ('91', 'base/studentInfo_getStudentInfoByClassName.qdu', null, '通过班级名称获取班级的所有学生');
INSERT INTO `menu` VALUES ('92', 'base/studentInfo.jsp', null, '显示学生信息');
INSERT INTO `menu` VALUES ('93', 'base/studentInfo1_editStudentInfos.qdu', null, '更改学生信息');
INSERT INTO `menu` VALUES ('94', 'base/student1.jsp', 'base', '学生信息维护');
INSERT INTO `menu` VALUES ('95', 'base/student2.jsp', 'base', '学生信息维护');
INSERT INTO `menu` VALUES ('96', 'workstudy/admin_showAllotResult.qdu', null, '查看分配的学生信息');
INSERT INTO `menu` VALUES ('97', 'base/studentInfo1_getStudentScoreBynum.qdu', null, '获取学生个人成绩');
INSERT INTO `menu` VALUES ('98', 'base/showStudent.jsp', null, '展示学生');
INSERT INTO `menu` VALUES ('99', 'base/null.jsp', null, null);
INSERT INTO `menu` VALUES ('100', 'base/personInfo.jsp', null, '显示学生个人成绩页面');
INSERT INTO `menu` VALUES ('101', 'base/personPoint.jsp', null, '显示学生操勤分页面');
INSERT INTO `menu` VALUES ('102', 'base/personScore.jsp', null, '显示学生个人成绩页面');
INSERT INTO `menu` VALUES ('103', 'base/studentInfo_forwardShowStudentpage.qdu', null, '跳转到showStudent.jsp页面');
INSERT INTO `menu` VALUES ('104', 'base/studentInfo_forwardStudentInfopage.qdu', null, '跳转到studentInfo.jsp');
INSERT INTO `menu` VALUES ('105', 'base/studentInfo_forwardStudentScorepage.qdu', null, '跳转到studentScore.jsp页面');
INSERT INTO `menu` VALUES ('106', 'base/studentInfo_forwardStudentPointpage.qdu', null, '跳转到studentPoint.jsp页面');
INSERT INTO `menu` VALUES ('107', 'base/studentInfo1_getStudentPoint.qdu', null, '获取学生操行分');
INSERT INTO `menu` VALUES ('108', 'base/studentInfo1_updateStudentScore.qdu', null, '修改学生成绩');
INSERT INTO `menu` VALUES ('109', 'base/studentInfo_updateStudentPoint.qdu', null, '修改学生操行分');


-- ----------------------------
-- Table structure for poorstudent
-- ----------------------------
DROP TABLE IF EXISTS `poorstudent`;
CREATE TABLE `poorstudent` (
  `studentNum` char(12) NOT NULL,
  `score` int(6) NOT NULL DEFAULT '0',
  `classId` int(11) NOT NULL,
  PRIMARY KEY (`studentNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of poorstudent
-- ----------------------------


-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `roleId` tinyint(4) NOT NULL COMMENT '角色Id（取值范围：0,1,2）',
  `roleName` varchar(20) NOT NULL COMMENT '角色名',
  `description` varchar(50) DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('0', '超级管理员', '管理整个系统');
INSERT INTO `role` VALUES ('1', '学院管理员', '管理本学院');
INSERT INTO `role` VALUES ('2', '专业管理员', '管理本专业');
INSERT INTO `role` VALUES ('3', '学生管理员', '帮助辅导员管理本专业');

-- ----------------------------
-- Table structure for rolemenu
-- ----------------------------
DROP TABLE IF EXISTS `rolemenu`;
CREATE TABLE `rolemenu` (
  `roleId` tinyint(4) NOT NULL DEFAULT '0' COMMENT '角色Id',
  `menuId` int(11) NOT NULL DEFAULT '0' COMMENT '菜单Id',
  PRIMARY KEY (`roleId`,`menuId`),
  KEY `fk_roleMenu_menu` (`menuId`),
  CONSTRAINT `fk_roleMenu_menu` FOREIGN KEY (`menuId`) REFERENCES `menu` (`menuId`),
  CONSTRAINT `fk_roleMenu_role` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

-- ----------------------------
-- Records of rolemenu
-- ----------------------------
INSERT INTO `rolemenu` VALUES ('0', '1');
INSERT INTO `rolemenu` VALUES ('1', '1');
INSERT INTO `rolemenu` VALUES ('2', '1');
INSERT INTO `rolemenu` VALUES ('0', '2');
INSERT INTO `rolemenu` VALUES ('0', '3');
INSERT INTO `rolemenu` VALUES ('0', '4');
INSERT INTO `rolemenu` VALUES ('0', '5');
INSERT INTO `rolemenu` VALUES ('0', '6');
INSERT INTO `rolemenu` VALUES ('0', '7');
INSERT INTO `rolemenu` VALUES ('0', '8');
INSERT INTO `rolemenu` VALUES ('1', '9');
INSERT INTO `rolemenu` VALUES ('1', '10');
INSERT INTO `rolemenu` VALUES ('1', '11');
INSERT INTO `rolemenu` VALUES ('1', '12');
INSERT INTO `rolemenu` VALUES ('1', '13');
INSERT INTO `rolemenu` VALUES ('0', '14');
INSERT INTO `rolemenu` VALUES ('0', '15');
INSERT INTO `rolemenu` VALUES ('0', '16');
INSERT INTO `rolemenu` VALUES ('0', '17');
INSERT INTO `rolemenu` VALUES ('0', '18');
INSERT INTO `rolemenu` VALUES ('0', '19');
INSERT INTO `rolemenu` VALUES ('0', '20');
INSERT INTO `rolemenu` VALUES ('0', '21');
INSERT INTO `rolemenu` VALUES ('1', '22');
INSERT INTO `rolemenu` VALUES ('0', '23');
INSERT INTO `rolemenu` VALUES ('0', '24');
INSERT INTO `rolemenu` VALUES ('0', '25');
INSERT INTO `rolemenu` VALUES ('1', '25');
INSERT INTO `rolemenu` VALUES ('2', '25');
INSERT INTO `rolemenu` VALUES ('0', '26');
INSERT INTO `rolemenu` VALUES ('1', '26');
INSERT INTO `rolemenu` VALUES ('2', '26');
INSERT INTO `rolemenu` VALUES ('0', '27');
INSERT INTO `rolemenu` VALUES ('1', '27');
INSERT INTO `rolemenu` VALUES ('2', '27');
INSERT INTO `rolemenu` VALUES ('0', '28');
INSERT INTO `rolemenu` VALUES ('1', '28');
INSERT INTO `rolemenu` VALUES ('2', '28');
INSERT INTO `rolemenu` VALUES ('0', '29');
INSERT INTO `rolemenu` VALUES ('1', '29');
INSERT INTO `rolemenu` VALUES ('2', '29');
INSERT INTO `rolemenu` VALUES ('0', '30');
INSERT INTO `rolemenu` VALUES ('1', '30');
INSERT INTO `rolemenu` VALUES ('2', '30');
INSERT INTO `rolemenu` VALUES ('0', '31');
INSERT INTO `rolemenu` VALUES ('1', '31');
INSERT INTO `rolemenu` VALUES ('2', '31');
INSERT INTO `rolemenu` VALUES ('0', '32');
INSERT INTO `rolemenu` VALUES ('0', '33');
INSERT INTO `rolemenu` VALUES ('0', '36');
INSERT INTO `rolemenu` VALUES ('1', '36');
INSERT INTO `rolemenu` VALUES ('2', '36');
INSERT INTO `rolemenu` VALUES ('0', '37');
INSERT INTO `rolemenu` VALUES ('1', '37');
INSERT INTO `rolemenu` VALUES ('2', '37');
INSERT INTO `rolemenu` VALUES ('0', '38');
INSERT INTO `rolemenu` VALUES ('1', '38');
INSERT INTO `rolemenu` VALUES ('2', '38');
INSERT INTO `rolemenu` VALUES ('0', '39');
INSERT INTO `rolemenu` VALUES ('1', '39');
INSERT INTO `rolemenu` VALUES ('2', '39');
INSERT INTO `rolemenu` VALUES ('0', '40');
INSERT INTO `rolemenu` VALUES ('1', '40');
INSERT INTO `rolemenu` VALUES ('2', '40');
INSERT INTO `rolemenu` VALUES ('0', '41');
INSERT INTO `rolemenu` VALUES ('1', '41');
INSERT INTO `rolemenu` VALUES ('2', '41');
INSERT INTO `rolemenu` VALUES ('3', '41');
INSERT INTO `rolemenu` VALUES ('0', '42');
INSERT INTO `rolemenu` VALUES ('1', '42');
INSERT INTO `rolemenu` VALUES ('2', '42');
INSERT INTO `rolemenu` VALUES ('3', '42');
INSERT INTO `rolemenu` VALUES ('0', '43');
INSERT INTO `rolemenu` VALUES ('1', '43');
INSERT INTO `rolemenu` VALUES ('2', '43');
INSERT INTO `rolemenu` VALUES ('3', '43');
INSERT INTO `rolemenu` VALUES ('0', '44');
INSERT INTO `rolemenu` VALUES ('1', '44');
INSERT INTO `rolemenu` VALUES ('2', '44');
INSERT INTO `rolemenu` VALUES ('3', '44');
INSERT INTO `rolemenu` VALUES ('0', '45');
INSERT INTO `rolemenu` VALUES ('1', '45');
INSERT INTO `rolemenu` VALUES ('2', '45');
INSERT INTO `rolemenu` VALUES ('3', '45');
INSERT INTO `rolemenu` VALUES ('0', '46');
INSERT INTO `rolemenu` VALUES ('1', '46');
INSERT INTO `rolemenu` VALUES ('2', '46');
INSERT INTO `rolemenu` VALUES ('3', '46');
INSERT INTO `rolemenu` VALUES ('0', '47');
INSERT INTO `rolemenu` VALUES ('1', '47');
INSERT INTO `rolemenu` VALUES ('2', '47');
INSERT INTO `rolemenu` VALUES ('3', '47');
INSERT INTO `rolemenu` VALUES ('0', '48');
INSERT INTO `rolemenu` VALUES ('1', '48');
INSERT INTO `rolemenu` VALUES ('2', '48');
INSERT INTO `rolemenu` VALUES ('3', '48');
INSERT INTO `rolemenu` VALUES ('0', '49');
INSERT INTO `rolemenu` VALUES ('1', '49');
INSERT INTO `rolemenu` VALUES ('2', '49');
INSERT INTO `rolemenu` VALUES ('3', '49');
INSERT INTO `rolemenu` VALUES ('0', '50');
INSERT INTO `rolemenu` VALUES ('1', '50');
INSERT INTO `rolemenu` VALUES ('2', '50');
INSERT INTO `rolemenu` VALUES ('3', '50');
INSERT INTO `rolemenu` VALUES ('0', '51');
INSERT INTO `rolemenu` VALUES ('1', '51');
INSERT INTO `rolemenu` VALUES ('2', '51');
INSERT INTO `rolemenu` VALUES ('3', '51');
INSERT INTO `rolemenu` VALUES ('1', '52');
INSERT INTO `rolemenu` VALUES ('1', '53');
INSERT INTO `rolemenu` VALUES ('0', '54');
INSERT INTO `rolemenu` VALUES ('1', '54');
INSERT INTO `rolemenu` VALUES ('2', '54');
INSERT INTO `rolemenu` VALUES ('0', '55');
INSERT INTO `rolemenu` VALUES ('1', '55');
INSERT INTO `rolemenu` VALUES ('2', '55');
INSERT INTO `rolemenu` VALUES ('0', '56');
INSERT INTO `rolemenu` VALUES ('1', '56');
INSERT INTO `rolemenu` VALUES ('2', '56');
INSERT INTO `rolemenu` VALUES ('3', '56');
INSERT INTO `rolemenu` VALUES ('0', '57');
INSERT INTO `rolemenu` VALUES ('1', '57');
INSERT INTO `rolemenu` VALUES ('2', '57');
INSERT INTO `rolemenu` VALUES ('0', '58');
INSERT INTO `rolemenu` VALUES ('1', '58');
INSERT INTO `rolemenu` VALUES ('2', '58');
INSERT INTO `rolemenu` VALUES ('2', '59');
INSERT INTO `rolemenu` VALUES ('2', '60');
INSERT INTO `rolemenu` VALUES ('1', '61');
INSERT INTO `rolemenu` VALUES ('2', '61');
INSERT INTO `rolemenu` VALUES ('2', '62');
INSERT INTO `rolemenu` VALUES ('2', '63');
INSERT INTO `rolemenu` VALUES ('2', '64');
INSERT INTO `rolemenu` VALUES ('1', '65');
INSERT INTO `rolemenu` VALUES ('2', '65');
INSERT INTO `rolemenu` VALUES ('1', '66');
INSERT INTO `rolemenu` VALUES ('2', '66');
INSERT INTO `rolemenu` VALUES ('2', '67');
INSERT INTO `rolemenu` VALUES ('2', '68');
INSERT INTO `rolemenu` VALUES ('2', '69');
INSERT INTO `rolemenu` VALUES ('1', '70');
INSERT INTO `rolemenu` VALUES ('2', '70');
INSERT INTO `rolemenu` VALUES ('1', '71');
INSERT INTO `rolemenu` VALUES ('2', '71');
INSERT INTO `rolemenu` VALUES ('1', '72');
INSERT INTO `rolemenu` VALUES ('2', '72');
INSERT INTO `rolemenu` VALUES ('1', '73');
INSERT INTO `rolemenu` VALUES ('2', '73');
INSERT INTO `rolemenu` VALUES ('1', '74');
INSERT INTO `rolemenu` VALUES ('0', '75');
INSERT INTO `rolemenu` VALUES ('0', '76');
INSERT INTO `rolemenu` VALUES ('0', '77');
INSERT INTO `rolemenu` VALUES ('1', '78');
INSERT INTO `rolemenu` VALUES ('1', '79');
INSERT INTO `rolemenu` VALUES ('1', '80');
INSERT INTO `rolemenu` VALUES ('0', '81');
INSERT INTO `rolemenu` VALUES ('1', '81');
INSERT INTO `rolemenu` VALUES ('2', '81');
INSERT INTO `rolemenu` VALUES ('0', '82');
INSERT INTO `rolemenu` VALUES ('1', '82');
INSERT INTO `rolemenu` VALUES ('2', '82');
INSERT INTO `rolemenu` VALUES ('0', '83');
INSERT INTO `rolemenu` VALUES ('1', '83');
INSERT INTO `rolemenu` VALUES ('2', '83');
INSERT INTO `rolemenu` VALUES ('0', '84');
INSERT INTO `rolemenu` VALUES ('1', '84');
INSERT INTO `rolemenu` VALUES ('2', '84');
INSERT INTO `rolemenu` VALUES ('1', '85');
INSERT INTO `rolemenu` VALUES ('2', '86');
INSERT INTO `rolemenu` VALUES ('0', '87');
INSERT INTO `rolemenu` VALUES ('1', '87');
INSERT INTO `rolemenu` VALUES ('2', '87');
INSERT INTO `rolemenu` VALUES ('0', '88');
INSERT INTO `rolemenu` VALUES ('1', '88');
INSERT INTO `rolemenu` VALUES ('2', '88');
INSERT INTO `rolemenu` VALUES ('0', '89');
INSERT INTO `rolemenu` VALUES ('1', '89');
INSERT INTO `rolemenu` VALUES ('2', '89');
INSERT INTO `rolemenu` VALUES ('0', '90');
INSERT INTO `rolemenu` VALUES ('1', '90');
INSERT INTO `rolemenu` VALUES ('2', '90');
INSERT INTO `rolemenu` VALUES ('0', '91');
INSERT INTO `rolemenu` VALUES ('1', '91');
INSERT INTO `rolemenu` VALUES ('2', '91');
INSERT INTO `rolemenu` VALUES ('0', '92');
INSERT INTO `rolemenu` VALUES ('1', '92');
INSERT INTO `rolemenu` VALUES ('2', '92');
INSERT INTO `rolemenu` VALUES ('0', '93');
INSERT INTO `rolemenu` VALUES ('1', '93');
INSERT INTO `rolemenu` VALUES ('2', '93');
INSERT INTO `rolemenu` VALUES ('1', '94');
INSERT INTO `rolemenu` VALUES ('2', '95');
INSERT INTO `rolemenu` VALUES ('2', '96');
INSERT INTO `rolemenu` VALUES ('0', '97');
INSERT INTO `rolemenu` VALUES ('1', '97');
INSERT INTO `rolemenu` VALUES ('2', '97');
INSERT INTO `rolemenu` VALUES ('0', '98');
INSERT INTO `rolemenu` VALUES ('1', '98');
INSERT INTO `rolemenu` VALUES ('2', '98');
INSERT INTO `rolemenu` VALUES ('0', '99');
INSERT INTO `rolemenu` VALUES ('1', '99');
INSERT INTO `rolemenu` VALUES ('2', '99');
INSERT INTO `rolemenu` VALUES ('0', '100');
INSERT INTO `rolemenu` VALUES ('1', '100');
INSERT INTO `rolemenu` VALUES ('2', '100');
INSERT INTO `rolemenu` VALUES ('0', '101');
INSERT INTO `rolemenu` VALUES ('1', '101');
INSERT INTO `rolemenu` VALUES ('2', '101');
INSERT INTO `rolemenu` VALUES ('0', '102');
INSERT INTO `rolemenu` VALUES ('1', '102');
INSERT INTO `rolemenu` VALUES ('2', '102');
INSERT INTO `rolemenu` VALUES ('0', '103');
INSERT INTO `rolemenu` VALUES ('1', '103');
INSERT INTO `rolemenu` VALUES ('2', '103');
INSERT INTO `rolemenu` VALUES ('0', '104');
INSERT INTO `rolemenu` VALUES ('1', '104');
INSERT INTO `rolemenu` VALUES ('2', '104');
INSERT INTO `rolemenu` VALUES ('0', '105');
INSERT INTO `rolemenu` VALUES ('1', '105');
INSERT INTO `rolemenu` VALUES ('2', '105');
INSERT INTO `rolemenu` VALUES ('0', '106');
INSERT INTO `rolemenu` VALUES ('1', '106');
INSERT INTO `rolemenu` VALUES ('2', '106');
INSERT INTO `rolemenu` VALUES ('0', '107');
INSERT INTO `rolemenu` VALUES ('1', '107');
INSERT INTO `rolemenu` VALUES ('2', '107');
INSERT INTO `rolemenu` VALUES ('0', '108');
INSERT INTO `rolemenu` VALUES ('1', '108');
INSERT INTO `rolemenu` VALUES ('2', '108');
INSERT INTO `rolemenu` VALUES ('0', '109');
INSERT INTO `rolemenu` VALUES ('1', '109');
INSERT INTO `rolemenu` VALUES ('2', '109');

-- ----------------------------
-- Table structure for schoolyear
-- ----------------------------
DROP TABLE IF EXISTS `schoolyear`;
CREATE TABLE `schoolyear` (
  `schoolYear` varchar(9) NOT NULL COMMENT '学年（如：2011-2012）',
  PRIMARY KEY (`schoolYear`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学年';

-- ----------------------------
-- Records of schoolyear
-- ----------------------------

INSERT INTO `schoolyear` VALUES ('2014-2015');
INSERT INTO `schoolyear` VALUES ('2015-2016');
INSERT INTO `schoolyear` VALUES ('2016-2017');
INSERT INTO `schoolyear` VALUES ('2017-2018');

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `sid` varchar(12) NOT NULL COMMENT '学生外键',
  `cid` int(12) NOT NULL COMMENT '课程的外键',
  `grade` double(10,0) NOT NULL COMMENT '成绩，-1表示缺考，-2表示取消资格，-3表示缓考',
  `makeup` double(10,0) DEFAULT NULL COMMENT '补考成绩',
  `schoolyear` varchar(10) DEFAULT NULL COMMENT '学年',
  PRIMARY KEY (`id`),
  KEY `course_score` (`cid`),
  KEY `student_score` (`sid`),
  CONSTRAINT `course_score` FOREIGN KEY (`cid`) REFERENCES `course` (`id`),
  CONSTRAINT `student_score` FOREIGN KEY (`sid`) REFERENCES `student` (`studentNum`)
) ENGINE=InnoDB AUTO_INCREMENT=7134 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of score
-- ----------------------------


-- ----------------------------
-- Table structure for scoreresult
-- ----------------------------
DROP TABLE IF EXISTS `scoreresult`;
CREATE TABLE `scoreresult` (
  `studentNum` char(12) NOT NULL COMMENT '学号',
  `schoolYear` char(9) NOT NULL COMMENT '学年',
  `sumScore` double(4,2) NOT NULL COMMENT '总评分数(两位整数，两位小数)',
  `filedClassCount` smallint(6) DEFAULT '0' COMMENT '挂科数目',
  `failedClassCredit` double(3,1) DEFAULT '0.0' COMMENT '挂科学分(一位小数)',
  `level` tinyint(4) NOT NULL COMMENT '评定等级（取值：0：没得奖，1：一等奖,2：二等奖,3：三等奖）',
  KEY `fk_score_student` (`studentNum`),
  KEY `fk_score_schoolYear` (`schoolYear`),
  CONSTRAINT `fk_score_schoolYear` FOREIGN KEY (`schoolYear`) REFERENCES `schoolyear` (`schoolYear`),
  CONSTRAINT `fk_score_student` FOREIGN KEY (`studentNum`) REFERENCES `student` (`studentNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合测评';

-- ----------------------------
-- Records of scoreresult
-- ----------------------------


-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `studentNum` char(12) NOT NULL COMMENT '学号',
  `studentName` varchar(10) NOT NULL COMMENT '姓名',
  `classId` int(11) NOT NULL COMMENT '班级Id',
  `password` char(32) NOT NULL COMMENT '密码',
  `sex` char(2) NOT NULL COMMENT '性别',
  `birth` date NOT NULL COMMENT '出生日期（固定格式，如：19992-01-01）',
  `IdentityNum` char(18) NOT NULL COMMENT '身份证号',
  `phoneNum` char(11) DEFAULT NULL COMMENT '手机号码',
  --`shortNum` varchar(6) DEFAULT NULL COMMENT '短号',
  `dormitory` varchar(11) DEFAULT NULL COMMENT '宿舍名',
  --`qqNum` varchar(15) DEFAULT NULL COMMENT 'QQ号码',
  --`email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `familyPhone` varchar(20) DEFAULT NULL COMMENT '家庭电话',
  `address` varchar(50) DEFAULT NULL COMMENT '家庭地址',
  `politicsStatus` varchar(10) DEFAULT NULL COMMENT '政治面貌',
  `nation` varchar(20) DEFAULT NULL COMMENT '民族',
  `nativePlace` varchar(10) DEFAULT NULL COMMENT '籍贯',
  `postcode` char(6) DEFAULT NULL COMMENT '邮编',
  `bankCardNum` varchar(20) DEFAULT NULL COMMENT '银行卡号',
  --`healthStatus` varchar(20) DEFAULT NULL COMMENT '健康状况',
  `education` varchar(10) DEFAULT NULL COMMENT '教育程度',
  --`maritalStatus` tinyint(1) DEFAULT NULL COMMENT '婚姻状况',
  `isallowevaluate` tinyint(1) DEFAULT '0' COMMENT '是否有权限进入贫困生评定',
  `photo_path` varchar(30) DEFAULT NULL COMMENT '头像',
  `timeofstart` varchar(20) DEFAULT NULL COMMENT '入学时间',
  --`highschool` varchar(20) DEFAULT NULL COMMENT '毕业中学',
  `fathername` varchar(20) DEFAULT NULL COMMENT '父亲姓名',
  `fatheroffice` varchar(32) DEFAULT NULL COMMENT '父亲工作地点',
  `mothername` varchar(20) DEFAULT NULL COMMENT '母亲姓名',
  `motheroffice` varchar(32) DEFAULT NULL COMMENT '母亲工作地点',
  --`admission_ticket` varchar(20) DEFAULT NULL COMMENT '准考证号',
  `ispoorstudent` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否为贫困生，0为否，1为是',
  `familybackground` varchar(10) DEFAULT NULL COMMENT '家庭背景（农民还是城市户口）',
  `extend_field1` varchar(20) DEFAULT NULL COMMENT '扩展字段',
  `extend_field2` varchar(20) DEFAULT NULL,
  `extend_field3` varchar(20) DEFAULT NULL,
  `extend_field4` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`studentNum`),
  KEY `index_studentNum` (`studentNum`),
  KEY `fk_student_class` (`classId`),
  KEY `fk_student_dormitory` (`dormitory`),
  CONSTRAINT `fk_student_class` FOREIGN KEY (`classId`) REFERENCES `class` (`classId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生';

-- ----------------------------
-- Records of student
-- ----------------------------


-- ----------------------------
-- Table structure for upfile
-- ----------------------------
DROP TABLE IF EXISTS `upfile`;
CREATE TABLE `upfile` (
  `fileId` char(32) NOT NULL COMMENT '文件Id',
  `fileName` varchar(255) NOT NULL COMMENT '文件名',
  `upTime` datetime NOT NULL COMMENT '上传时间',
  `fileUrl` varchar(255) NOT NULL COMMENT '文件路径',
  `uploadStaff` varchar(20) NOT NULL COMMENT '上传人员',
  `applyType` smallint(6) NOT NULL COMMENT '申请类型',
  PRIMARY KEY (`fileId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件上传';

-- ----------------------------
-- Records of upfile
-- ----------------------------


-- ----------------------------
-- Table structure for yard
-- ----------------------------
DROP TABLE IF EXISTS `yard`;
CREATE TABLE `yard` (
  `yardId` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '区域Id',
  `yardName` varchar(10) NOT NULL COMMENT '区域名称',
  `manager` varchar(10) DEFAULT NULL COMMENT '区域管理员',
  `tel` varchar(20) DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`yardId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of yard
-- ----------------------------
