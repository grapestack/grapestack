/*
Navicat MySQL Data Transfer

Source Server         : 108.166.107.115
Source Server Version : 50152
Source Host           : 108.166.107.115:3306
Source Database       : mail

Target Server Type    : MYSQL
Target Server Version : 50152
File Encoding         : 65001

Date: 2012-02-10 02:26:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `domains`
-- ----------------------------
DROP TABLE IF EXISTS `domains`;
CREATE TABLE `domains` (
  `domain` varchar(50) NOT NULL,
  PRIMARY KEY (`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of domains
-- ----------------------------
INSERT INTO `domains` VALUES ('grapestack-local-domain.com');
INSERT INTO `domains` VALUES ('grapestack.com');

-- ----------------------------
-- Table structure for `forwards`
-- ----------------------------
DROP TABLE IF EXISTS `forwards`;
CREATE TABLE `forwards` (
  `source` varchar(80) NOT NULL,
  `destination` text NOT NULL,
  PRIMARY KEY (`source`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of forwards
-- ----------------------------

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `email` varchar(80) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('webmaster@grapestack.com', ENCRYPT('stackpass'));
INSERT INTO `users` VALUES ('root@grapestack.com', ENCRYPT('stackpass'));
