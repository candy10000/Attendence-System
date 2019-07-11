/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 11/07/2019 19:33:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `book_price` double(10, 2) NULL DEFAULT NULL,
  `book_page` int(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1001 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (5, 'rr', 3.00, 88);
INSERT INTO `book` VALUES (8, 'b', 6.00, 88);
INSERT INTO `book` VALUES (999, 'rrr', NULL, 678);
INSERT INTO `book` VALUES (1000, 'reyd', NULL, NULL);

-- ----------------------------
-- Table structure for checkreport
-- ----------------------------
DROP TABLE IF EXISTS `checkreport`;
CREATE TABLE `checkreport`  (
  `cclock` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bdate` datetime(6) NULL DEFAULT NULL,
  `creson` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来判断是否是补卡的人，0表示补卡，1表示正常',
  `edate` datetime(6) NULL DEFAULT NULL,
  `cid` int(10) NOT NULL AUTO_INCREMENT,
  `hours` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`cid`, `cclock`) USING BTREE,
  INDEX `cclock`(`cclock`) USING BTREE,
  CONSTRAINT `cclock` FOREIGN KEY (`cclock`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of checkreport
-- ----------------------------
INSERT INTO `checkreport` VALUES ('WTT', '2019-07-07 07:48:03.000000', NULL, '异常', '2019-07-07 17:20:20.000000', 61, 5);
INSERT INTO `checkreport` VALUES ('WTT', '2019-07-08 08:01:18.000000', NULL, '正常', '2019-07-08 18:49:54.000000', 62, 9);
INSERT INTO `checkreport` VALUES ('WTT', '2019-07-08 08:01:18.000000', NULL, '异常', '2019-07-08 17:06:00.000000', 63, 5);
INSERT INTO `checkreport` VALUES ('WTT', '2019-07-08 08:01:18.000000', NULL, '早退', '2019-07-08 08:49:32.000000', 64, 0);
INSERT INTO `checkreport` VALUES ('WTT', '2019-07-08 08:49:32.000000', NULL, '正常', '2019-07-08 18:49:54.000000', 65, 9);
INSERT INTO `checkreport` VALUES ('WTT', '2019-07-08 08:49:32.000000', NULL, '异常', '2019-07-08 17:06:00.000000', 66, 5);
INSERT INTO `checkreport` VALUES ('WTT', '2019-07-08 17:06:00.000000', NULL, '早迟', '2019-07-08 18:49:54.000000', 67, 1);
INSERT INTO `checkreport` VALUES ('WYT', '2019-07-09 09:51:52.000000', NULL, '异常', '2019-07-09 16:52:56.000000', 68, 5);
INSERT INTO `checkreport` VALUES ('XRT', '2019-07-07 08:00:00.000000', NULL, '正常', '2019-07-07 18:00:00.000000', 69, 9);

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `decode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deres` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deduty` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deup` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `decode`) USING BTREE,
  INDEX `decode`(`decode`) USING BTREE,
  INDEX `deduty`(`deduty`) USING BTREE,
  INDEX `deup`(`deup`) USING BTREE,
  INDEX `deres`(`deres`) USING BTREE,
  CONSTRAINT `deres` FOREIGN KEY (`deres`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deup` FOREIGN KEY (`deup`) REFERENCES `department` (`decode`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('2', 'CWB', '财务部', 'LS', '财务', NULL);
INSERT INTO `department` VALUES ('3', 'SCB', '市场部', 'ZS', '市场营销', 'CWB');
INSERT INTO `department` VALUES ('4', 'JSB', '技术部', 'WEG', '高科技部', 'JSB');

-- ----------------------------
-- Table structure for empgj
-- ----------------------------
DROP TABLE IF EXISTS `empgj`;
CREATE TABLE `empgj`  (
  `empno` decimal(4, 0) NOT NULL,
  `ename` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job` varchar(9) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mgr` decimal(4, 0) NULL DEFAULT NULL,
  `hiredate` date NULL DEFAULT NULL,
  `sal` decimal(7, 2) NULL DEFAULT NULL,
  `comm` decimal(7, 2) NULL DEFAULT NULL,
  `deptno` decimal(2, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`empno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empgj
-- ----------------------------
INSERT INTO `empgj` VALUES (7369, 'smith', 'clerk', 7902, '1980-12-17', 800.00, 100.00, 20);
INSERT INTO `empgj` VALUES (7499, 'allen', 'salesman', 7698, '1981-02-20', 1600.00, 300.00, 20);
INSERT INTO `empgj` VALUES (7521, 'ward', 'salesman', 7698, '1981-02-22', 1250.00, 500.00, 30);
INSERT INTO `empgj` VALUES (7566, 'jones', 'manager', 7839, '1981-04-02', 2975.00, 100.00, 20);
INSERT INTO `empgj` VALUES (7654, 'martin', 'salesman', 7698, '1981-09-28', 1250.00, 1400.00, 30);
INSERT INTO `empgj` VALUES (7698, 'blake', 'manager', 7839, '1981-05-01', 2850.00, 111.00, 30);
INSERT INTO `empgj` VALUES (7782, 'clark', 'manager', 7839, '1981-06-09', 2450.00, 111.00, 10);
INSERT INTO `empgj` VALUES (7788, 'scott', 'analyst', 7566, '1987-04-19', 3000.00, 111.00, 20);
INSERT INTO `empgj` VALUES (7839, 'king', 'president', NULL, '1981-11-17', 5000.00, 111.00, 10);
INSERT INTO `empgj` VALUES (7844, 'turner', 'salesman', 7698, '1981-09-08', 5000.00, 0.00, 30);
INSERT INTO `empgj` VALUES (7876, 'adams', 'clerk', 7788, '1987-05-23', 1100.00, 111.00, 20);
INSERT INTO `empgj` VALUES (7900, 'james', 'clerk', 7698, '1981-12-03', 950.00, 111.00, 30);
INSERT INTO `empgj` VALUES (7902, 'ford', 'analyst', 7566, '1981-12-03', 3000.00, 111.00, 20);
INSERT INTO `empgj` VALUES (7934, 'miller', 'clerk', 7782, '1982-01-23', 1300.00, 111.00, 10);

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees`  (
  `emp_id` int(10) NOT NULL AUTO_INCREMENT,
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(10) NULL DEFAULT NULL,
  `nation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cardID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `salary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sation_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`emp_id`, `id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `1`(`sation_ID`) USING BTREE,
  INDEX `emp_id`(`emp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employees
-- ----------------------------
INSERT INTO `employees` VALUES (96, 'HXX', '黄小小', '女', 23, '汉', '33423453453453433', '20000', '12434234434', '总经理', '黄小小');
INSERT INTO `employees` VALUES (97, 'ZS', '张三', '男', 32, '汉', '342354363464623532', '10000', '13344565446', '前台', '张三');
INSERT INTO `employees` VALUES (98, 'LS', '李四', '男', 33, '汉', '234554356643322344', '10000', '13355334566', '财务', '李四');
INSERT INTO `employees` VALUES (99, 'WEG', '王二狗', '男', 34, '汉', '345345654345653', '12000', '13236535466', '总经理', '王二狗');
INSERT INTO `employees` VALUES (100, 'WTT', '吴甜甜', '女', 18, '汉', '34762374847373838', '20000', '13837363948', '总经理', '超美');
INSERT INTO `employees` VALUES (101, 'XRT', '徐如婷', '女', 18, '汉', '35793847585048373', '20000', '15483746583', '副经理', '超美');
INSERT INTO `employees` VALUES (102, 'WYT', '吴焰婷', '女', 18, '汉', '3568372937593732', '20000', '13847563846', '财务', '超有钱');
INSERT INTO `employees` VALUES (103, 'ZGS', '张根硕', '男', 30, '汉', '35262837362863726', '10000', '163836278373', '前台', '超帅');
INSERT INTO `employees` VALUES (104, 'ZTR', '庄天任', '男', 20, '汉', '36283748472837262', '10000', '15383628273', '前台', '庄天任');
INSERT INTO `employees` VALUES (105, 'LBB', '李冰冰', '女', 20, '汉', '3628263547922638', '20000', '1638463873', '前台', '超美');

-- ----------------------------
-- Table structure for leaves
-- ----------------------------
DROP TABLE IF EXISTS `leaves`;
CREATE TABLE `leaves`  (
  `lId` int(10) NOT NULL AUTO_INCREMENT,
  `lname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lstime` datetime(6) NOT NULL,
  `letime` datetime(6) NOT NULL,
  `lnote` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`lId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of leaves
-- ----------------------------
INSERT INTO `leaves` VALUES (7, '张根硕', '2019-07-08 20:54:00.000000', '2019-07-08 21:24:00.000000', '2222');
INSERT INTO `leaves` VALUES (8, '李冰冰', '2019-07-08 20:54:00.000000', '2019-07-08 21:24:00.000000', '2222');
INSERT INTO `leaves` VALUES (9, '吴甜甜', '2019-07-08 20:54:00.000000', '2019-07-08 21:24:00.000000', '2');
INSERT INTO `leaves` VALUES (10, '张三', '2019-07-08 20:54:00.000000', '2019-07-08 21:24:00.000000', '2');
INSERT INTO `leaves` VALUES (11, '李四', '2019-07-08 20:54:00.000000', '2019-07-08 21:24:00.000000', '2');
INSERT INTO `leaves` VALUES (12, '王二狗', '2019-07-08 20:54:00.000000', '2019-07-08 21:24:00.000000', '2');
INSERT INTO `leaves` VALUES (15, '庄天任', '2019-07-09 11:08:00.000000', '2019-07-09 12:38:00.000000', '我问问');
INSERT INTO `leaves` VALUES (17, '王二狗', '2019-07-09 11:55:00.000000', '2019-07-09 12:25:00.000000', '问问');

-- ----------------------------
-- Table structure for paper
-- ----------------------------
DROP TABLE IF EXISTS `paper`;
CREATE TABLE `paper`  (
  `paper_id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'paperID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'paper����',
  `number` int(11) NOT NULL COMMENT 'paper����',
  `detail` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'paper����',
  PRIMARY KEY (`paper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'paper��' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper
-- ----------------------------
INSERT INTO `paper` VALUES (3, 'sdgf', 0, '');
INSERT INTO `paper` VALUES (5, 'tiantian', 0, 'dg');
INSERT INTO `paper` VALUES (11, 'tiantian', 55, 'wa');

-- ----------------------------
-- Table structure for paysalary
-- ----------------------------
DROP TABLE IF EXISTS `paysalary`;
CREATE TABLE `paysalary`  (
  `psid` int(20) NOT NULL AUTO_INCREMENT,
  `psempid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pssalary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `psstime` date NOT NULL,
  `psetime` date NOT NULL,
  PRIMARY KEY (`psid`, `psempid`) USING BTREE,
  INDEX `psempid`(`psempid`) USING BTREE,
  CONSTRAINT `psempid` FOREIGN KEY (`psempid`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paysalary
-- ----------------------------
INSERT INTO `paysalary` VALUES (63, 'WEG', '50.00', '2019-07-01', '2019-07-31');
INSERT INTO `paysalary` VALUES (64, 'WTT', '188.89', '2019-07-01', '2019-07-31');
INSERT INTO `paysalary` VALUES (65, 'WYT', '27.78', '2019-07-02', '2019-07-31');
INSERT INTO `paysalary` VALUES (66, 'XRT', '77.78', '2019-07-01', '2019-07-31');
INSERT INTO `paysalary` VALUES (67, 'ZTR', '0.00', '2019-07-01', '2019-07-31');
INSERT INTO `paysalary` VALUES (68, 'WTT', '188.89', '2019-07-01', '2019-07-09');
INSERT INTO `paysalary` VALUES (69, 'WTT', '188.89', '2019-07-01', '2019-07-09');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` double(10, 2) NULL DEFAULT NULL,
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', 'TT', 12.00, 'RR ');
INSERT INTO `product` VALUES ('2', 'ee', 22.00, 'ee');
INSERT INTO `product` VALUES ('3', 'QQ', 11.00, 'QQ');

-- ----------------------------
-- Table structure for punchcard
-- ----------------------------
DROP TABLE IF EXISTS `punchcard`;
CREATE TABLE `punchcard`  (
  `pId` int(10) NOT NULL AUTO_INCREMENT,
  `pclock` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pnote` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ptime` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`pId`) USING BTREE,
  INDEX `pclock`(`pclock`) USING BTREE,
  CONSTRAINT `pclock` FOREIGN KEY (`pclock`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of punchcard
-- ----------------------------
INSERT INTO `punchcard` VALUES (60, 'WTT', '吴甜甜', '2019-07-07 07:48:03.000000');
INSERT INTO `punchcard` VALUES (61, 'WTT', '吴甜甜', '2019-07-07 17:20:20.000000');
INSERT INTO `punchcard` VALUES (62, 'WTT', '吴甜甜', '2019-07-08 08:49:32.000000');
INSERT INTO `punchcard` VALUES (63, 'WTT', '吴甜甜', '2019-07-08 18:49:54.000000');
INSERT INTO `punchcard` VALUES (64, 'XRT', '徐如婷', '2019-07-09 08:51:01.000000');
INSERT INTO `punchcard` VALUES (65, 'XRT', '徐如婷', '2019-07-09 17:00:19.000000');
INSERT INTO `punchcard` VALUES (66, 'WYT', '吴焰婷', '2019-07-09 09:51:52.000000');
INSERT INTO `punchcard` VALUES (68, 'WYT', '吴焰婷', '2019-07-09 16:52:56.000000');
INSERT INTO `punchcard` VALUES (71, 'WTT', '吴甜甜', '2019-07-09 11:53:39.000000');

-- ----------------------------
-- Table structure for repaircard
-- ----------------------------
DROP TABLE IF EXISTS `repaircard`;
CREATE TABLE `repaircard`  (
  `rid` int(10) NOT NULL AUTO_INCREMENT,
  `rempid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rdate` datetime(6) NULL DEFAULT NULL,
  `rreson` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`rid`) USING BTREE,
  INDEX `rempid`(`rempid`) USING BTREE,
  CONSTRAINT `rempid` FOREIGN KEY (`rempid`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of repaircard
-- ----------------------------
INSERT INTO `repaircard` VALUES (35, 'ZS', '2019-07-08 20:10:27.000000', NULL);
INSERT INTO `repaircard` VALUES (59, 'ZTR', '2019-07-08 00:00:00.000000', 'WYT');
INSERT INTO `repaircard` VALUES (60, 'WTT', '2019-07-07 00:00:00.000000', 'WYT');
INSERT INTO `repaircard` VALUES (61, 'WTT', '2019-07-09 00:00:00.000000', 'WYT');

-- ----------------------------
-- Table structure for station
-- ----------------------------
DROP TABLE IF EXISTS `station`;
CREATE TABLE `station`  (
  `stID` int(10) NOT NULL AUTO_INCREMENT,
  `stcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `stname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `stdepartment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stup` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stclass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stnote` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`stID`, `stcode`) USING BTREE,
  INDEX `stcode`(`stcode`) USING BTREE,
  INDEX `stdepartment`(`stdepartment`) USING BTREE,
  INDEX `styp`(`stup`) USING BTREE,
  CONSTRAINT `stdepartment` FOREIGN KEY (`stdepartment`) REFERENCES `department` (`decode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `styp` FOREIGN KEY (`stup`) REFERENCES `station` (`stcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of station
-- ----------------------------
INSERT INTO `station` VALUES (3, 'ZCS', 'RTYUR', 'CWB', 'ZCS', '管理类', '567Y4');
INSERT INTO `station` VALUES (18, 'WE', 'WER', 'CWB', 'ZCS', '管理类', 'WERE');
INSERT INTO `station` VALUES (19, 'RY', 'E6Y', 'CWB', 'ZCS', '管理类', '6Y6');
INSERT INTO `station` VALUES (20, '56', '465', 'CWB', 'ZCS', '管理类', 'EWT');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(100) NOT NULL,
  `user` char(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `passwd` char(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'kelly', '123');
INSERT INTO `user` VALUES (2, 'ann', '122');

SET FOREIGN_KEY_CHECKS = 1;
