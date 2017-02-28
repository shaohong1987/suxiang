/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : suxiang

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2016-11-17 17:10:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cost_labor
-- ----------------------------
DROP TABLE IF EXISTS `cost_labor`;
CREATE TABLE `cost_labor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `projectname` varchar(50) NOT NULL,
  `buildingno` varchar(255) NOT NULL,
  `startdate` date NOT NULL,
  `endate` date NOT NULL,
  `worktype` varchar(500) NOT NULL,
  `teamleaderid` int(11) DEFAULT NULL,
  `teamleader` varchar(50) DEFAULT NULL,
  `workcontent` varchar(255) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `price` float NOT NULL,
  `worktime` float NOT NULL,
  `totalprice` float NOT NULL,
  `remarkbywork` varchar(255) DEFAULT NULL,
  `postid` int(11) NOT NULL,
  `poster` varchar(20) NOT NULL,
  `posttime` datetime NOT NULL,
  `comfirmid` int(11) DEFAULT NULL,
  `comfirmname` varchar(50) DEFAULT NULL,
  `comfirmtime` datetime DEFAULT NULL,
  `comfirmremark` varchar(255) DEFAULT NULL,
  `recomfirmid` int(11) DEFAULT NULL,
  `recomfirmname` varchar(50) DEFAULT NULL,
  `recomfirmremark` varchar(255) DEFAULT NULL,
  `recomfirmtime` datetime DEFAULT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  `currentUser` int(11) DEFAULT NULL,
  `currentPage` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_labor
-- ----------------------------
INSERT INTO `cost_labor` VALUES ('1', '2', '紫玉山庄', '1', '2016-11-01', '2016-11-15', '木工', '10', '班组长', '搭架子', '立方', '50', '100', '5000', 'test', '1', '财务', '2016-11-15 15:43:13', '10', '班组长', '2016-11-16 08:36:59', 'aaaddd', '9', '栋号长', '滴答滴答滴答滴答', '2016-11-16 08:49:25', '2', '总经理', '', '2016-11-16 08:59:41', '2', '总经理', 'dddd', '2016-11-16 09:01:38', '-1', '', '表单处理完成', '0');
INSERT INTO `cost_labor` VALUES ('2', '2', '紫玉山庄', '1', '2016-11-01', '2016-11-15', '架子工', '10', '班组长', '111', '平方', '50', '100', '5000', '1234', '5', '施工员', '2016-11-16 10:55:12', '10', '班组长', '2016-11-17 07:51:58', '4321', '9', '栋号长', '2134', '2016-11-17 07:52:25', '4', '生产经理', '3214', '2016-11-17 07:52:56', '2', '总经理', '1324', '2016-11-17 07:53:25', '-1', '', '表单处理完成', '0');

-- ----------------------------
-- Table structure for cost_management
-- ----------------------------
DROP TABLE IF EXISTS `cost_management`;
CREATE TABLE `cost_management` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `projectname` varchar(100) NOT NULL,
  `curdate` date NOT NULL,
  `type` varchar(20) NOT NULL,
  `content` varchar(50) NOT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `number` float NOT NULL,
  `price` float NOT NULL,
  `totalprice` float NOT NULL,
  `remarkbyaccount` varchar(255) DEFAULT NULL,
  `postid` int(11) NOT NULL,
  `poster` varchar(20) NOT NULL,
  `posttime` datetime NOT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  `currentUser` int(11) DEFAULT NULL,
  `currentPage` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_management
-- ----------------------------
INSERT INTO `cost_management` VALUES ('1', '2', '紫玉山庄', '2016-11-15', '福利', '军大衣', '件', '10', '500', '5000', '一人一件', '1', '财务', '2016-11-15 15:08:29', '4', '生产经理', '忑忑忐忐', '2016-11-15 15:09:19', '2', '总经理', '一人一件', '2016-11-15 15:10:20', '-1', '', '表单处理完成', '0');

-- ----------------------------
-- Table structure for cost_material
-- ----------------------------
DROP TABLE IF EXISTS `cost_material`;
CREATE TABLE `cost_material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `projectname` varchar(100) NOT NULL,
  `buildingno` varchar(50) NOT NULL,
  `curdate` date NOT NULL,
  `teamleaderid` int(11) DEFAULT NULL,
  `teamleader` varchar(50) DEFAULT NULL,
  `materialname` varchar(50) NOT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `number` float NOT NULL,
  `price` float NOT NULL,
  `totalprice` float NOT NULL,
  `remarkbyworker` varchar(255) DEFAULT NULL,
  `postid` int(11) NOT NULL,
  `poster` varchar(20) NOT NULL,
  `posttime` datetime NOT NULL,
  `comfirmid` int(11) DEFAULT NULL,
  `comfirmname` varchar(50) DEFAULT NULL,
  `comfirmtime` datetime DEFAULT NULL,
  `comfirmremark` varchar(255) DEFAULT NULL,
  `recomfirmid` int(11) DEFAULT NULL,
  `recomfirmname` varchar(50) DEFAULT NULL,
  `recomfirmtime` datetime DEFAULT NULL,
  `recomfirmremark` varchar(255) DEFAULT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  `currentUser` varchar(255) DEFAULT NULL,
  `currentPage` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `state` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_material
-- ----------------------------
INSERT INTO `cost_material` VALUES ('1', '2', '紫玉山庄', '1', '2016-11-16', '10', '班组长', '扫帚', '把', '20', '15', '300', '扫帚', '8', '保管员', '2016-11-16 10:15:57', '10', '班组长', '2016-11-16 10:30:01', 'ddd', '9', '栋号长', '2016-11-16 10:30:39', 'eee', '2', '总经理', '', '2016-11-16 10:34:17', '2', '总经理', 'dafasf', '2016-11-16 10:35:21', '-1', '', '表单处理完成', '0');
INSERT INTO `cost_material` VALUES ('2', '2', '紫玉山庄', '1', '2016-11-17', '10', '班组长', '钢材', '吨', '5', '1500', '7500', '钢材22', '8', '保管员', '2016-11-17 08:01:03', '10', '班组长', '2016-11-17 08:45:44', '123', '9', '栋号长', '2016-11-17 08:46:09', '456', '4', '生产经理', '789', '2016-11-17 08:46:39', '2', '总经理', '1357', '2016-11-17 08:47:29', '-1', '', '表单处理完成', '0');

-- ----------------------------
-- Table structure for cost_materialauxiliary
-- ----------------------------
DROP TABLE IF EXISTS `cost_materialauxiliary`;
CREATE TABLE `cost_materialauxiliary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `projectname` varchar(100) NOT NULL,
  `buildingno` varchar(50) NOT NULL,
  `curdate` date NOT NULL,
  `teamleaderid` int(11) DEFAULT NULL,
  `teamleader` varchar(50) DEFAULT NULL,
  `materialname` varchar(50) NOT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `number` float NOT NULL,
  `price` float NOT NULL,
  `totalprice` float NOT NULL,
  `remarkbyworker` varchar(255) DEFAULT NULL,
  `postid` int(11) NOT NULL,
  `poster` varchar(20) NOT NULL,
  `posttime` datetime NOT NULL,
  `comfirmid` int(11) DEFAULT NULL,
  `comfirmname` varchar(50) DEFAULT NULL,
  `comfirmremark` varchar(255) DEFAULT NULL,
  `comfirmtime` datetime DEFAULT NULL,
  `recomfirmid` int(11) DEFAULT NULL,
  `recomfirmname` varchar(50) DEFAULT NULL,
  `recomfirmtime` datetime DEFAULT NULL,
  `recomfirmremark` varchar(255) DEFAULT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  `currentUser` int(11) DEFAULT NULL,
  `currentPage` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_materialauxiliary
-- ----------------------------
INSERT INTO `cost_materialauxiliary` VALUES ('1', '2', '紫玉山庄', '1', '2016-11-16', '10', '班组长', '手套', '双', '100', '5', '500', '手套', '2', '总经理', '2016-11-16 10:46:09', '10', '班组长', 'dd', '2016-11-16 10:46:53', '9', '栋号长', '2016-11-16 10:47:28', 'ee', '4', '生产经理', 'ww', '2016-11-16 10:47:53', '2', '总经理', 'qq', '2016-11-16 10:48:10', '-1', '', '表单处理完成', '0');
INSERT INTO `cost_materialauxiliary` VALUES ('2', '2', '紫玉山庄', '1', '2016-11-17', '10', '班组长', '手套', '双', '100', '3', '300', '手套123', '8', '保管员', '2016-11-17 08:01:40', '10', '班组长', '456', '2016-11-17 08:45:50', '9', '栋号长', '2016-11-17 08:46:16', '123', '4', '生产经理', '789', '2016-11-17 08:46:47', '2', '总经理', '1357', '2016-11-17 08:47:36', '-1', '', '表单处理完成', '0');

-- ----------------------------
-- Table structure for problems
-- ----------------------------
DROP TABLE IF EXISTS `problems`;
CREATE TABLE `problems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `problemType` varchar(50) NOT NULL,
  `levelno` varchar(11) NOT NULL,
  `projectid` int(11) NOT NULL,
  `projectname` varchar(50) NOT NULL,
  `buildingno` varchar(11) NOT NULL,
  `location` varchar(100) NOT NULL,
  `checkdate` date NOT NULL,
  `finishdate` date NOT NULL,
  `problemdescription` varchar(500) NOT NULL,
  `causation` varchar(255) NOT NULL,
  `teamleaderid` int(11) NOT NULL,
  `teamleader` varchar(50) NOT NULL,
  `worker` varchar(20) NOT NULL,
  `responsibleperson1` varchar(20) DEFAULT NULL,
  `responsibleperson2` varchar(20) DEFAULT NULL,
  `rebuildsolution` varchar(255) NOT NULL,
  `rebuilder` varchar(20) NOT NULL,
  `treatmentmeasures` varchar(500) NOT NULL,
  `worktimecost_db` varchar(10) NOT NULL,
  `worktimecost_xb` varchar(10) NOT NULL,
  `materialcost` varchar(10) NOT NULL,
  `rechecker` varchar(20) NOT NULL,
  `posterid` int(11) NOT NULL,
  `postername` varchar(50) NOT NULL,
  `posttime` datetime NOT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of problems
-- ----------------------------

-- ----------------------------
-- Table structure for problem_quality
-- ----------------------------
DROP TABLE IF EXISTS `problem_quality`;
CREATE TABLE `problem_quality` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `levelno` varchar(11) NOT NULL,
  `projectid` int(11) NOT NULL,
  `projectname` varchar(50) NOT NULL,
  `buildingno` varchar(11) NOT NULL,
  `location` varchar(100) NOT NULL,
  `checkdate` date NOT NULL,
  `finishdate` date NOT NULL,
  `problemdescription` varchar(500) NOT NULL,
  `causation` varchar(255) NOT NULL,
  `teamleaderid` int(11) NOT NULL,
  `teamleader` varchar(50) NOT NULL,
  `worker` varchar(20) NOT NULL,
  `responsibleperson1` varchar(20) DEFAULT NULL,
  `responsibleperson2` varchar(20) DEFAULT NULL,
  `rebuildsolution` varchar(255) NOT NULL,
  `rebuilder` varchar(20) NOT NULL,
  `treatmentmeasures` varchar(500) NOT NULL,
  `worktimecost_db` varchar(10) NOT NULL,
  `worktimecost_xb` varchar(10) NOT NULL,
  `materialcost` varchar(10) NOT NULL,
  `rechecker` varchar(20) NOT NULL,
  `postid` int(11) NOT NULL,
  `postername` varchar(50) NOT NULL,
  `posttime` datetime NOT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  `currentUser` int(11) DEFAULT NULL,
  `currentPage` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of problem_quality
-- ----------------------------
INSERT INTO `problem_quality` VALUES ('1', '', '2', '紫玉山庄', '1', '111', '2016-11-15', '2016-11-18', 'test', 'teste', '10', '班组长', 'aa', 'aa', 'aa', 'aa', 'aa', '', '1', '21', '123', 'aa', '6', '质量员', '2016-11-15 08:33:32', '2', '总经理', '', '2016-11-15 14:45:50', '2', '总经理', 'd1d1', '2016-11-15 14:50:44', '-1', '', '表单处理完成', '0');

-- ----------------------------
-- Table structure for problem_sercurity
-- ----------------------------
DROP TABLE IF EXISTS `problem_sercurity`;
CREATE TABLE `problem_sercurity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `levelno` varchar(11) NOT NULL,
  `projectid` int(11) NOT NULL,
  `projectname` varchar(50) NOT NULL,
  `buildingno` varchar(11) NOT NULL,
  `location` varchar(100) NOT NULL,
  `checkdate` date NOT NULL,
  `finishdate` date NOT NULL,
  `problemdescription` varchar(500) NOT NULL,
  `causation` varchar(255) NOT NULL,
  `teamleaderid` int(11) NOT NULL,
  `teamleader` varchar(50) NOT NULL,
  `worker` varchar(20) NOT NULL,
  `responsibleperson1` varchar(20) DEFAULT NULL,
  `responsibleperson2` varchar(20) DEFAULT NULL,
  `rebuildsolution` varchar(255) NOT NULL,
  `rebuilder` varchar(20) NOT NULL,
  `treatmentmeasures` varchar(500) NOT NULL,
  `worktimecost_db` varchar(10) NOT NULL,
  `worktimecost_xb` varchar(10) NOT NULL,
  `materialcost` varchar(10) NOT NULL,
  `rechecker` varchar(20) NOT NULL,
  `postid` int(11) NOT NULL,
  `postername` varchar(50) NOT NULL,
  `posttime` datetime NOT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  `currentUser` int(11) DEFAULT NULL,
  `currentPage` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of problem_sercurity
-- ----------------------------
INSERT INTO `problem_sercurity` VALUES ('1', '', '2', '紫玉山庄', '1', '101', '2016-11-14', '2016-11-15', 'test', 'test', '10', '班组长', 'tt', '安全员', '栋号长', 'test', 'test', '', '1', '22', '1221', 'test', '1', '财务', '2016-11-15 08:27:11', '2', '总经理', '', '2016-11-15 14:46:02', '2', '总经理', 'd3d4', '2016-11-15 14:51:27', '-1', '', '表单处理完成', '0');
INSERT INTO `problem_sercurity` VALUES ('2', '', '2', '紫玉山庄', '1', '121', '2016-11-01', '2016-11-03', 'sss', 'ddd', '10', '班组长', 'ee', 'dd', 'ff', 'gg', 'aa', '', '1', '2', '123', 'bb', '1', '财务', '2016-11-17 16:24:08', '4', '生产经理', 'test', '2016-11-17 17:00:46', '2', '总经理', 'test', '2016-11-17 17:03:34', '-1', '', '表单处理完成', '0');

-- ----------------------------
-- Table structure for projectinfo
-- ----------------------------
DROP TABLE IF EXISTS `projectinfo`;
CREATE TABLE `projectinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `projectname` varchar(50) NOT NULL,
  `buildingid` varchar(5) NOT NULL,
  `state` bit(1) NOT NULL DEFAULT b'1',
  `buildingleaderid` int(11) DEFAULT NULL,
  `buildingleader` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of projectinfo
-- ----------------------------
INSERT INTO `projectinfo` VALUES ('1', '1', '都市枫林', '1', '', '3', '员工');
INSERT INTO `projectinfo` VALUES ('2', '2', '紫玉山庄', '1', '', '9', '栋号长');

-- ----------------------------
-- Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectname` varchar(50) NOT NULL,
  `projectleaderid` int(11) NOT NULL,
  `projectleader` varchar(50) NOT NULL,
  `productleaderid` int(11) DEFAULT NULL,
  `productleader` varchar(50) DEFAULT NULL,
  `accountantid` int(11) DEFAULT NULL,
  `accountant` varchar(50) DEFAULT NULL,
  `constructionleaderid` int(11) DEFAULT NULL,
  `constructionleader` varchar(50) DEFAULT NULL,
  `safetyleaderid` int(11) DEFAULT NULL,
  `safetyleader` varchar(50) DEFAULT NULL,
  `qualityleaderid` int(11) DEFAULT NULL,
  `qualityleader` varchar(50) DEFAULT NULL,
  `storekeeperid` int(11) DEFAULT NULL,
  `storekeeper` varchar(50) DEFAULT NULL,
  `buildingTotal` int(11) NOT NULL,
  `state` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of projects
-- ----------------------------
INSERT INTO `projects` VALUES ('1', '都市枫林', '3', '员工', '3', '员工', '3', '员工', '3', '员工', '3', '员工', '3', '员工', '3', '员工', '1', '');
INSERT INTO `projects` VALUES ('2', '紫玉山庄', '4', '生产经理', '4', '生产经理', '3', '员工', '5', '施工员', '7', '安全员', '6', '质量员', '8', '保管员', '1', '');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `realname` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `state` bit(1) NOT NULL DEFAULT b'1',
  `group` int(11) DEFAULT '100',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'adm', 'C4CA4238A0B923820DCC509A6F75849B', '财务', 'admin@njsuxiang.com', '', '1');
INSERT INTO `users` VALUES ('2', '10001', 'C4CA4238A0B923820DCC509A6F75849B', '总经理', 'gm2@suxiang.com', '', '0');
INSERT INTO `users` VALUES ('3', '90001', 'C4CA4238A0B923820DCC509A6F75849B', '员工', 'woker@suxiang.com', '', '100');
INSERT INTO `users` VALUES ('4', '90002', 'C4CA4238A0B923820DCC509A6F75849B', '生产经理', 'product@njsuxiang.com', '', '100');
INSERT INTO `users` VALUES ('5', '90003', 'C4CA4238A0B923820DCC509A6F75849B', '施工员', 'shigongyuan@njsuxiang.com', '', '100');
INSERT INTO `users` VALUES ('6', '90004', 'C4CA4238A0B923820DCC509A6F75849B', '质量员', 'quality@njsuxiang.com', '', '100');
INSERT INTO `users` VALUES ('7', '90005', 'C4CA4238A0B923820DCC509A6F75849B', '安全员', 'safety@njsuxiang.com', '', '100');
INSERT INTO `users` VALUES ('8', '90006', 'C4CA4238A0B923820DCC509A6F75849B', '保管员', 'storekeeper@njsuxiang.com', '', '100');
INSERT INTO `users` VALUES ('9', '90007', 'C4CA4238A0B923820DCC509A6F75849B', '栋号长', 'buildingleader@njsuxiang.com', '', '100');
INSERT INTO `users` VALUES ('10', '90008', 'C4CA4238A0B923820DCC509A6F75849B', '班组长', 'teamleader@njsuxiang.com', '', '100');
