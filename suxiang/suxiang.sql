/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50715
Source Host           : localhost:3306
Source Database       : suxiang

Target Server Type    : MYSQL
Target Server Version : 50715 
File Encoding         : 65001

Date: 2016-10-02 10:49:26
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
  `postid` int(11) NOT NULL,
  `poster` varchar(20) NOT NULL,
  `posttime` datetime NOT NULL,
  `comfirmid` int(11) DEFAULT NULL,
  `comfirmname` varchar(50) DEFAULT NULL,
  `comfirmtime` datetime DEFAULT NULL,
  `recomfirmid` int(11) DEFAULT NULL,
  `recomfirmname` varchar(50) DEFAULT NULL,
  `recomfirmcontent` varchar(255) DEFAULT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  `state` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_labor
-- ----------------------------

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
  `remark` varchar(500) DEFAULT NULL,
  `poster` varchar(20) NOT NULL,
  `posttime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_management
-- ----------------------------

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
  `postid` int(11) NOT NULL,
  `poster` varchar(20) NOT NULL,
  `posttime` datetime NOT NULL,
  `comfirmid` int(11) DEFAULT NULL,
  `comfirmname` varchar(50) DEFAULT NULL,
  `comfirmtime` datetime DEFAULT NULL,
  `remarkid` int(11) DEFAULT NULL,
  `remarkname` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `remarktime` datetime DEFAULT NULL,
  `summaryid` int(11) DEFAULT NULL,
  `summaryname` varchar(50) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `summarytime` datetime DEFAULT NULL,
  `state` bit(1) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_material
-- ----------------------------

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
  `workteam` varchar(255) DEFAULT NULL,
  `materialname` varchar(50) NOT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `number` float NOT NULL,
  `price` float NOT NULL,
  `totalprice` float NOT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `poster` varchar(20) NOT NULL,
  `posttime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_materialauxiliary
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of projectinfo
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of projects
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'adm', 'C4CA4238A0B923820DCC509A6F75849B', '财务', 'admin@njsuxiang.com', '', '1');
INSERT INTO `users` VALUES ('2', '10001', 'C81E728D9D4C2F636F067F89CC14862C', '总经理', 'gm2@suxiang.com', '', '0');
INSERT INTO `users` VALUES ('3', '90001', 'C4CA4238A0B923820DCC509A6F75849B', '员工', 'woker@suxiang.com', '', '100');
