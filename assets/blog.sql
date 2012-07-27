/*
Navicat MySQL Data Transfer

Source Server         : blog.linkdrop.com_3306
Source Server Version : 50161
Source Host           : blog.linkdrop.com:3306
Source Database       : contentbox

Target Server Type    : MYSQL
Target Server Version : 50161
File Encoding         : 65001

Date: 2012-07-25 15:02:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cb_author`
-- ----------------------------
DROP TABLE IF EXISTS `cb_author`;
CREATE TABLE `cb_author` (
  `authorID` int(11) NOT NULL AUTO_INCREMENT,
  `lastLogin` datetime DEFAULT NULL,
  `lastName` varchar(100) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `createdDate` datetime NOT NULL,
  `password` varchar(100) NOT NULL,
  `biography` longtext,
  `username` varchar(100) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'0',
  `email` varchar(255) NOT NULL,
  `FK_roleID` int(11) NOT NULL,
  PRIMARY KEY (`authorID`),
  UNIQUE KEY `username` (`username`),
  KEY `FK6847396B9724FA40` (`FK_roleID`),
  KEY `idx_active` (`isActive`),
  KEY `idx_email` (`email`),
  KEY `idx_login` (`password`,`username`,`isActive`),
  CONSTRAINT `FK6847396B9724FA40` FOREIGN KEY (`FK_roleID`) REFERENCES `cb_role` (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_author
-- ----------------------------
INSERT INTO `cb_author` VALUES ('1', '2012-07-25 17:01:12', 'GRAPE', 'Stack', '2012-07-25 00:11:35', '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', '', 'admin', '', 'webmaster@grapestack.com', '2');

-- ----------------------------
-- Table structure for `cb_authorPermissions`
-- ----------------------------
DROP TABLE IF EXISTS `cb_authorPermissions`;
CREATE TABLE `cb_authorPermissions` (
  `FK_authorID` int(11) NOT NULL,
  `FK_permissionID` int(11) NOT NULL,
  KEY `FKE167E219AA6AC0EA` (`FK_authorID`),
  KEY `FKE167E21937C1A3F2` (`FK_permissionID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_authorPermissions
-- ----------------------------

-- ----------------------------
-- Table structure for `cb_category`
-- ----------------------------
DROP TABLE IF EXISTS `cb_category`;
CREATE TABLE `cb_category` (
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_category
-- ----------------------------
INSERT INTO `cb_category` VALUES ('1', 'News', 'news');
INSERT INTO `cb_category` VALUES ('2', 'ColdFusion', 'coldfusion');
INSERT INTO `cb_category` VALUES ('3', 'ColdBox', 'coldbox');
INSERT INTO `cb_category` VALUES ('4', 'ContentBox', 'contentbox');

-- ----------------------------
-- Table structure for `cb_comment`
-- ----------------------------
DROP TABLE IF EXISTS `cb_comment`;
CREATE TABLE `cb_comment` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `author` varchar(100) NOT NULL,
  `authorEmail` varchar(255) NOT NULL,
  `authorIP` varchar(100) NOT NULL,
  `authorURL` varchar(255) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `isApproved` bit(1) NOT NULL DEFAULT b'0',
  `FK_contentID` int(11) NOT NULL,
  PRIMARY KEY (`commentID`),
  KEY `FKFFCED27FFB9F8BAD` (`FK_contentID`),
  KEY `FKFFCED27F89D637E8` (`FK_contentID`),
  KEY `FKFFCED27F91F58374` (`FK_contentID`),
  KEY `idx_approved` (`isApproved`),
  KEY `idx_contentComment` (`isApproved`,`FK_contentID`),
  KEY `idx_createdDate` (`createdDate`),
  CONSTRAINT `FKFFCED27F89D637E8` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKFFCED27F91F58374` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKFFCED27FFB9F8BAD` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_comment
-- ----------------------------
INSERT INTO `cb_comment` VALUES ('1', 'What an amazing blog entry, congratulations!', 'Awesome Joe', 'awesomejoe@gocontentbox.com', '127.0.0.1', 'www.gocontentbox.com', '2012-07-25 00:11:36', '', '1');
INSERT INTO `cb_comment` VALUES ('2', 'I am some bad words and bad comment not approved', 'Bad Joe', 'badjoe@gocontentbox.com', '127.0.0.1', 'www.gocontentbox.com', '2012-07-25 00:11:36', '', '1');

-- ----------------------------
-- Table structure for `cb_content`
-- ----------------------------
DROP TABLE IF EXISTS `cb_content`;
CREATE TABLE `cb_content` (
  `contentID` int(11) NOT NULL AUTO_INCREMENT,
  `contentType` varchar(255) NOT NULL,
  `isPublished` bit(1) NOT NULL DEFAULT b'1',
  `cacheLayout` bit(1) NOT NULL DEFAULT b'1',
  `cacheTimeout` int(11) DEFAULT '0',
  `expireDate` datetime DEFAULT NULL,
  `publishedDate` datetime DEFAULT NULL,
  `allowComments` bit(1) NOT NULL DEFAULT b'1',
  `title` varchar(200) NOT NULL,
  `passwordProtection` varchar(100) DEFAULT NULL,
  `cache` bit(1) NOT NULL DEFAULT b'1',
  `HTMLKeywords` varchar(160) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `hits` bigint(20) DEFAULT '0',
  `cacheLastAccessTimeout` int(11) DEFAULT '0',
  `HTMLDescription` varchar(160) DEFAULT NULL,
  `slug` varchar(200) NOT NULL,
  `FK_parentID` int(11) DEFAULT NULL,
  `FK_authorID` int(11) DEFAULT NULL,
  PRIMARY KEY (`contentID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `FKFFE01899AA6AC0EA` (`FK_authorID`),
  KEY `FKFFE01899D98634D2` (`FK_parentID`),
  KEY `FKFFE0189967BCE10D` (`FK_parentID`),
  KEY `FKFFE018996FDC2C99` (`FK_parentID`),
  KEY `idx_slug` (`slug`),
  KEY `idx_discriminator` (`contentType`),
  KEY `idx_cachelayout` (`cacheLayout`),
  KEY `idx_cachetimeout` (`cacheTimeout`),
  KEY `idx_cache` (`cache`),
  KEY `idx_publishedSlug` (`isPublished`,`slug`),
  KEY `idx_published` (`isPublished`,`contentType`,`passwordProtection`),
  KEY `idx_cachelastaccesstimeout` (`cacheLastAccessTimeout`),
  KEY `idx_createdDate` (`createdDate`),
  KEY `idx_search` (`isPublished`,`title`),
  CONSTRAINT `FKFFE0189967BCE10D` FOREIGN KEY (`FK_parentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKFFE018996FDC2C99` FOREIGN KEY (`FK_parentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKFFE01899AA6AC0EA` FOREIGN KEY (`FK_authorID`) REFERENCES `cb_author` (`authorID`),
  CONSTRAINT `FKFFE01899D98634D2` FOREIGN KEY (`FK_parentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_content
-- ----------------------------
INSERT INTO `cb_content` VALUES ('1', 'Entry', '', '', '0', null, '2012-07-25 00:11:36', '', 'My first entry', '', '', 'cool,first entry, contentbox', '2012-07-25 00:11:36', '0', '0', 'The most amazing ContentBox blog entry in the world', 'my-first-entry', null, null);
INSERT INTO `cb_content` VALUES ('2', 'Page', '', '', '0', null, '2012-07-25 00:11:36', '', 'About', '', '', 'about, contentbox,coldfusion,coldbox', '2012-07-25 00:11:36', '0', '0', 'The most amazing ContentBox page in the world', 'about', null, null);

-- ----------------------------
-- Table structure for `cb_contentCategories`
-- ----------------------------
DROP TABLE IF EXISTS `cb_contentCategories`;
CREATE TABLE `cb_contentCategories` (
  `FK_contentID` int(11) NOT NULL,
  `FK_categoryID` int(11) NOT NULL,
  KEY `FKD96A0F95F10ECD0` (`FK_categoryID`),
  KEY `FKD96A0F95FB9F8BAD` (`FK_contentID`),
  KEY `FKD96A0F9589D637E8` (`FK_contentID`),
  KEY `FKD96A0F9591F58374` (`FK_contentID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_contentCategories
-- ----------------------------

-- ----------------------------
-- Table structure for `cb_contentVersion`
-- ----------------------------
DROP TABLE IF EXISTS `cb_contentVersion`;
CREATE TABLE `cb_contentVersion` (
  `contentVersionID` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'0',
  `changelog` longtext,
  `createdDate` datetime NOT NULL,
  `version` int(11) NOT NULL,
  `FK_authorID` int(11) NOT NULL,
  `FK_contentID` int(11) NOT NULL,
  PRIMARY KEY (`contentVersionID`),
  KEY `FKE166DFFAA6AC0EA` (`FK_authorID`),
  KEY `FKE166DFFFB9F8BAD` (`FK_contentID`),
  KEY `FKE166DFF89D637E8` (`FK_contentID`),
  KEY `FKE166DFF91F58374` (`FK_contentID`),
  KEY `idx_active` (`isActive`),
  KEY `idx_contentVersions` (`isActive`,`FK_contentID`),
  KEY `idx_version` (`version`),
  KEY `idx_createdDate` (`createdDate`),
  CONSTRAINT `FKE166DFF89D637E8` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKE166DFF91F58374` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKE166DFFAA6AC0EA` FOREIGN KEY (`FK_authorID`) REFERENCES `cb_author` (`authorID`),
  CONSTRAINT `FKE166DFFFB9F8BAD` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_contentVersion
-- ----------------------------
INSERT INTO `cb_contentVersion` VALUES ('1', 'Hey everybody, this is my first blog entry made from ContentBox.  Isn\'t this amazing!\'', '', 'Initial creation', '2012-07-25 00:11:36', '1', '1', '1');
INSERT INTO `cb_contentVersion` VALUES ('2', '<p>Hey welcome to my about page for ContentBox, isn\'t this great!</p><p>{{{CustomHTML slug=\'contentbox\'}}}</p>', '', 'First creation', '2012-07-25 00:11:36', '1', '1', '2');
INSERT INTO `cb_contentVersion` VALUES ('3', '<p>\n	Hey everybody, this is my first blog entry made from ContentBox. Isn\'t this amazing!\'</p>\n', '', 'Quick save', '2012-07-25 17:01:38', '2', '1', '1');
INSERT INTO `cb_contentVersion` VALUES ('4', '<p>\n	Hey everybody, this is my first blog entry made from ContentBox. Isn\'t this amazing!</p>\n', '', 'Quick save', '2012-07-25 17:01:42', '2', '1', '1');
INSERT INTO `cb_contentVersion` VALUES ('5', '<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn\'t this amazing!</p>\r\n', '', '', '2012-07-25 17:01:49', '2', '1', '1');
INSERT INTO `cb_contentVersion` VALUES ('6', '<p>\n	Hey everybody, this is my first blog entry made from ContentBox. Isn\'t this amazing!</p>\n', '', 'Quick save', '2012-07-25 17:02:10', '2', '1', '1');
INSERT INTO `cb_contentVersion` VALUES ('7', '<p>\n	Hey everybody, this is my first blog entry made from ContentBox. Isn\'t this amazing!</p>\n', '', 'Quick save', '2012-07-25 17:02:16', '2', '1', '1');
INSERT INTO `cb_contentVersion` VALUES ('8', '<p>\n	Hey everybody, this is my first blog entry made from ContentBox. Isn\'t this amazing!</p>\n', '', 'Quick save', '2012-07-25 17:02:19', '2', '1', '1');
INSERT INTO `cb_contentVersion` VALUES ('9', '<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn\'t this amazing!</p>\r\n', '', '', '2012-07-25 17:02:35', '2', '1', '1');

-- ----------------------------
-- Table structure for `cb_customfield`
-- ----------------------------
DROP TABLE IF EXISTS `cb_customfield`;
CREATE TABLE `cb_customfield` (
  `customFieldID` int(11) NOT NULL AUTO_INCREMENT,
  `value` longtext NOT NULL,
  `key` varchar(255) NOT NULL,
  `FK_contentID` int(11) DEFAULT NULL,
  PRIMARY KEY (`customFieldID`),
  KEY `FK18446849FB9F8BAD` (`FK_contentID`),
  KEY `FK1844684989D637E8` (`FK_contentID`),
  KEY `FK1844684991F58374` (`FK_contentID`),
  KEY `idx_contentCustomFields` (`FK_contentID`),
  CONSTRAINT `FK1844684989D637E8` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FK1844684991F58374` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FK18446849FB9F8BAD` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_customfield
-- ----------------------------

-- ----------------------------
-- Table structure for `cb_customHTML`
-- ----------------------------
DROP TABLE IF EXISTS `cb_customHTML`;
CREATE TABLE `cb_customHTML` (
  `contentID` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `title` varchar(200) NOT NULL,
  `cache` bit(1) NOT NULL DEFAULT b'1',
  `description` longtext,
  `cacheLastAccessTimeout` int(11) DEFAULT '0',
  `cacheTimeout` int(11) DEFAULT '0',
  `slug` varchar(200) NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`contentID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_cachetimeout` (`cacheTimeout`),
  KEY `idx_cache` (`cache`),
  KEY `idx_customHTML_slug` (`slug`),
  KEY `idx_cachelastaccesstimeout` (`cacheLastAccessTimeout`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_customHTML
-- ----------------------------
INSERT INTO `cb_customHTML` VALUES ('1', '<p style=\"text-align: center;\">\r\n	<a href=\"http://gocontentbox.org\"><img alt=\"\" src=\"/modules/contentbox/content/ContentBox_125.gif\" style=\"width: 124px; height: 118px;\" /></a></p>\r\n<p style=\"text-align: center;\">\r\n	Created by <a href=\"http://www.ortussolutions.com\">Ortus Solutions, Corp</a> and powered by <a href=\"http://coldbox.org\">ColdBox Platform</a>.</p>', 'ContactInfo', '', 'Our contact information', '0', '0', 'contentbox', '2012-07-25 00:11:36');

-- ----------------------------
-- Table structure for `cb_entry`
-- ----------------------------
DROP TABLE IF EXISTS `cb_entry`;
CREATE TABLE `cb_entry` (
  `contentID` int(11) NOT NULL,
  `isPublished` bit(1) NOT NULL DEFAULT b'1',
  `cacheLayout` bit(1) NOT NULL DEFAULT b'1',
  `cacheTimeout` int(11) DEFAULT '0',
  `expireDate` datetime DEFAULT NULL,
  `publishedDate` datetime DEFAULT NULL,
  `contentType` varchar(255) DEFAULT NULL,
  `allowComments` bit(1) NOT NULL DEFAULT b'1',
  `title` varchar(200) NOT NULL,
  `passwordProtection` varchar(100) DEFAULT NULL,
  `cache` bit(1) NOT NULL DEFAULT b'1',
  `excerpt` longtext,
  `HTMLKeywords` varchar(160) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `hits` bigint(20) DEFAULT '0',
  `cacheLastAccessTimeout` int(11) DEFAULT '0',
  `HTMLDescription` varchar(160) DEFAULT NULL,
  `slug` varchar(200) NOT NULL,
  `FK_parentID` int(11) DEFAULT NULL,
  PRIMARY KEY (`contentID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `FK141674927FFF6A7` (`contentID`),
  KEY `FK141674926FDC2C99` (`FK_parentID`),
  KEY `idx_slug` (`slug`),
  KEY `idx_discriminator` (`contentType`),
  KEY `idx_cachelayout` (`cacheLayout`),
  KEY `idx_cachetimeout` (`cacheTimeout`),
  KEY `idx_cache` (`cache`),
  KEY `idx_publishedSlug` (`isPublished`,`slug`),
  KEY `idx_published` (`isPublished`,`contentType`,`passwordProtection`),
  KEY `idx_cachelastaccesstimeout` (`cacheLastAccessTimeout`),
  KEY `idx_createdDate` (`createdDate`),
  KEY `idx_search` (`isPublished`,`title`),
  CONSTRAINT `FK141674926FDC2C99` FOREIGN KEY (`FK_parentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FK141674927FFF6A7` FOREIGN KEY (`contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_entry
-- ----------------------------
INSERT INTO `cb_entry` VALUES ('1', '', '', '0', null, '2012-07-25 00:11:36', null, '', 'My first entry', '', '', '', 'cool,first entry, contentbox', '2012-07-25 00:11:36', '0', '0', 'The most amazing ContentBox blog entry in the world', 'my-first-entry', null);

-- ----------------------------
-- Table structure for `cb_module`
-- ----------------------------
DROP TABLE IF EXISTS `cb_module`;
CREATE TABLE `cb_module` (
  `moduleID` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'0',
  `webURL` longtext,
  `description` longtext,
  `name` varchar(255) NOT NULL,
  `entryPoint` varchar(255) DEFAULT NULL,
  `forgeBoxSlug` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`moduleID`),
  KEY `idx_active` (`isActive`),
  KEY `idx_entryPoint` (`entryPoint`),
  KEY `idx_moduleName` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_module
-- ----------------------------
INSERT INTO `cb_module` VALUES ('1', 'Ortus Solutions, Corp', 'HelloContentBox', '', 'http://www.ortussolutions.com', 'This is an awesome hello world module', 'Hello', 'HelloContentBox', '', '1.0');

-- ----------------------------
-- Table structure for `cb_page`
-- ----------------------------
DROP TABLE IF EXISTS `cb_page`;
CREATE TABLE `cb_page` (
  `contentID` int(11) NOT NULL,
  `isPublished` bit(1) NOT NULL DEFAULT b'1',
  `showInMenu` bit(1) NOT NULL DEFAULT b'1',
  `cacheLayout` bit(1) NOT NULL DEFAULT b'1',
  `cacheTimeout` int(11) DEFAULT '0',
  `expireDate` datetime DEFAULT NULL,
  `publishedDate` datetime DEFAULT NULL,
  `contentType` varchar(255) DEFAULT NULL,
  `allowComments` bit(1) NOT NULL DEFAULT b'1',
  `title` varchar(200) NOT NULL,
  `order` int(11) DEFAULT '0',
  `layout` varchar(200) DEFAULT NULL,
  `passwordProtection` varchar(100) DEFAULT NULL,
  `cache` bit(1) NOT NULL DEFAULT b'1',
  `HTMLKeywords` varchar(160) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `hits` bigint(20) DEFAULT '0',
  `cacheLastAccessTimeout` int(11) DEFAULT '0',
  `HTMLDescription` varchar(160) DEFAULT NULL,
  `slug` varchar(200) NOT NULL,
  `FK_parentID` int(11) DEFAULT NULL,
  PRIMARY KEY (`contentID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `FK21B2F26F9636A2E2` (`contentID`),
  KEY `FK21B2F26F6FDC2C99` (`FK_parentID`),
  KEY `idx_slug` (`slug`),
  KEY `idx_discriminator` (`contentType`),
  KEY `idx_cachelayout` (`cacheLayout`),
  KEY `idx_cachetimeout` (`cacheTimeout`),
  KEY `idx_cache` (`cache`),
  KEY `idx_showInMenu` (`showInMenu`),
  KEY `idx_publishedSlug` (`isPublished`,`slug`),
  KEY `idx_published` (`isPublished`,`contentType`,`passwordProtection`),
  KEY `idx_cachelastaccesstimeout` (`cacheLastAccessTimeout`),
  KEY `idx_createdDate` (`createdDate`),
  KEY `idx_search` (`isPublished`,`title`),
  CONSTRAINT `FK21B2F26F6FDC2C99` FOREIGN KEY (`FK_parentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FK21B2F26F9636A2E2` FOREIGN KEY (`contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_page
-- ----------------------------
INSERT INTO `cb_page` VALUES ('2', '', '', '', '0', null, '2012-07-25 00:11:36', null, '', 'About', '0', 'pages', '', '', 'about, contentbox,coldfusion,coldbox', '2012-07-25 00:11:36', '0', '0', 'The most amazing ContentBox page in the world', 'about', null);

-- ----------------------------
-- Table structure for `cb_permission`
-- ----------------------------
DROP TABLE IF EXISTS `cb_permission`;
CREATE TABLE `cb_permission` (
  `permissionID` int(11) NOT NULL AUTO_INCREMENT,
  `description` longtext,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`permissionID`),
  UNIQUE KEY `permission` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_permission
-- ----------------------------
INSERT INTO `cb_permission` VALUES ('1', 'Ability to manage authors, default is view only', 'AUTHOR_ADMIN');
INSERT INTO `cb_permission` VALUES ('2', 'Ability to manage blog entries, default is view only', 'ENTRIES_ADMIN');
INSERT INTO `cb_permission` VALUES ('3', 'Access to the ContentBox System tools', 'SYSTEM_TAB');
INSERT INTO `cb_permission` VALUES ('4', 'Ability to rollback content versions', 'VERSIONS_ROLLBACK');
INSERT INTO `cb_permission` VALUES ('5', 'Ability to view and apply ContentBox updates', 'SYSTEM_UPDATES');
INSERT INTO `cb_permission` VALUES ('6', 'Ability to reload modules', 'RELOAD_MODULES');
INSERT INTO `cb_permission` VALUES ('7', 'Access to the enter the ContentBox administrator console', 'CONTENTBOX_ADMIN');
INSERT INTO `cb_permission` VALUES ('8', 'Ability to manage the system\'s media manager', 'MEDIAMANAGER_ADMIN');
INSERT INTO `cb_permission` VALUES ('9', 'Access to the ContentBox raw geek settings panel', 'SYSTEM_RAW_SETTINGS');
INSERT INTO `cb_permission` VALUES ('10', 'Ability to manage the system\'s email templates', 'EMAIL_TEMPLATE_ADMIN');
INSERT INTO `cb_permission` VALUES ('11', 'Ability to manage custom HTML, default is view only', 'CUSTOMHTML_ADMIN');
INSERT INTO `cb_permission` VALUES ('12', 'Ability to manage blog entries but not publish entries', 'ENTRIES_EDITOR');
INSERT INTO `cb_permission` VALUES ('13', 'Ability to manage ContentBox Modules', 'MODULES_ADMIN');
INSERT INTO `cb_permission` VALUES ('14', 'Ability to manage content pages, default is view only', 'PAGES_ADMIN');
INSERT INTO `cb_permission` VALUES ('15', 'Ability to delete past content versions', 'VERSIONS_DELETE');
INSERT INTO `cb_permission` VALUES ('16', 'Ability to manage comments, default is view only', 'COMMENTS_ADMIN');
INSERT INTO `cb_permission` VALUES ('17', 'Ability to manage the system\'s global HTML content used on layouts', 'GLOBALHTML_ADMIN');
INSERT INTO `cb_permission` VALUES ('18', 'Ability to manage widgets, default is view only', 'WIDGET_ADMIN');
INSERT INTO `cb_permission` VALUES ('19', 'Ability to manage content pages but not publish pages', 'PAGES_EDITOR');
INSERT INTO `cb_permission` VALUES ('20', 'Ability to manage layouts, default is view only', 'LAYOUT_ADMIN');
INSERT INTO `cb_permission` VALUES ('21', 'Ability to manage the system\'s security rules, default is view only', 'SECURITYRULES_ADMIN');
INSERT INTO `cb_permission` VALUES ('22', 'Ability to manage permissions, default is view only', 'PERMISSIONS_ADMIN');
INSERT INTO `cb_permission` VALUES ('23', 'Ability to manage roles, default is view only', 'ROLES_ADMIN');
INSERT INTO `cb_permission` VALUES ('24', 'Ability to manage categories, default is view only', 'CATEGORIES_ADMIN');
INSERT INTO `cb_permission` VALUES ('25', 'Ability to import data into ContentBox', 'TOOLS_IMPORT');
INSERT INTO `cb_permission` VALUES ('26', 'Ability to update global configuration data', 'SYSTEM_SAVE_CONFIGURATION');

-- ----------------------------
-- Table structure for `cb_role`
-- ----------------------------
DROP TABLE IF EXISTS `cb_role`;
CREATE TABLE `cb_role` (
  `roleID` int(11) NOT NULL AUTO_INCREMENT,
  `description` longtext,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`roleID`),
  UNIQUE KEY `role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_role
-- ----------------------------
INSERT INTO `cb_role` VALUES ('1', 'A ContentBox editor', 'Editor');
INSERT INTO `cb_role` VALUES ('2', 'A ContentBox Administrator', 'Administrator');

-- ----------------------------
-- Table structure for `cb_rolePermissions`
-- ----------------------------
DROP TABLE IF EXISTS `cb_rolePermissions`;
CREATE TABLE `cb_rolePermissions` (
  `FK_roleID` int(11) NOT NULL,
  `FK_permissionID` int(11) NOT NULL,
  KEY `FKDCCC1A4E9724FA40` (`FK_roleID`),
  KEY `FKDCCC1A4E37C1A3F2` (`FK_permissionID`),
  CONSTRAINT `FKDCCC1A4E37C1A3F2` FOREIGN KEY (`FK_permissionID`) REFERENCES `cb_permission` (`permissionID`),
  CONSTRAINT `FKDCCC1A4E9724FA40` FOREIGN KEY (`FK_roleID`) REFERENCES `cb_role` (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_rolePermissions
-- ----------------------------
INSERT INTO `cb_rolePermissions` VALUES ('1', '16');
INSERT INTO `cb_rolePermissions` VALUES ('1', '11');
INSERT INTO `cb_rolePermissions` VALUES ('1', '19');
INSERT INTO `cb_rolePermissions` VALUES ('1', '24');
INSERT INTO `cb_rolePermissions` VALUES ('1', '12');
INSERT INTO `cb_rolePermissions` VALUES ('1', '20');
INSERT INTO `cb_rolePermissions` VALUES ('1', '17');
INSERT INTO `cb_rolePermissions` VALUES ('1', '8');
INSERT INTO `cb_rolePermissions` VALUES ('1', '4');
INSERT INTO `cb_rolePermissions` VALUES ('1', '7');
INSERT INTO `cb_rolePermissions` VALUES ('2', '1');
INSERT INTO `cb_rolePermissions` VALUES ('2', '2');
INSERT INTO `cb_rolePermissions` VALUES ('2', '3');
INSERT INTO `cb_rolePermissions` VALUES ('2', '4');
INSERT INTO `cb_rolePermissions` VALUES ('2', '5');
INSERT INTO `cb_rolePermissions` VALUES ('2', '6');
INSERT INTO `cb_rolePermissions` VALUES ('2', '7');
INSERT INTO `cb_rolePermissions` VALUES ('2', '8');
INSERT INTO `cb_rolePermissions` VALUES ('2', '9');
INSERT INTO `cb_rolePermissions` VALUES ('2', '10');
INSERT INTO `cb_rolePermissions` VALUES ('2', '13');
INSERT INTO `cb_rolePermissions` VALUES ('2', '12');
INSERT INTO `cb_rolePermissions` VALUES ('2', '11');
INSERT INTO `cb_rolePermissions` VALUES ('2', '14');
INSERT INTO `cb_rolePermissions` VALUES ('2', '15');
INSERT INTO `cb_rolePermissions` VALUES ('2', '16');
INSERT INTO `cb_rolePermissions` VALUES ('2', '17');
INSERT INTO `cb_rolePermissions` VALUES ('2', '18');
INSERT INTO `cb_rolePermissions` VALUES ('2', '19');
INSERT INTO `cb_rolePermissions` VALUES ('2', '20');
INSERT INTO `cb_rolePermissions` VALUES ('2', '21');
INSERT INTO `cb_rolePermissions` VALUES ('2', '22');
INSERT INTO `cb_rolePermissions` VALUES ('2', '23');
INSERT INTO `cb_rolePermissions` VALUES ('2', '24');
INSERT INTO `cb_rolePermissions` VALUES ('2', '25');
INSERT INTO `cb_rolePermissions` VALUES ('2', '26');

-- ----------------------------
-- Table structure for `cb_securityRule`
-- ----------------------------
DROP TABLE IF EXISTS `cb_securityRule`;
CREATE TABLE `cb_securityRule` (
  `ruleID` int(11) NOT NULL AUTO_INCREMENT,
  `useSSL` bit(1) DEFAULT b'0',
  `securelist` varchar(255) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `roles` varchar(255) DEFAULT NULL,
  `permissions` longtext,
  `redirect` longtext NOT NULL,
  `match` varchar(50) DEFAULT NULL,
  `whitelist` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ruleID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_securityRule
-- ----------------------------
INSERT INTO `cb_securityRule` VALUES ('1', '', '^contentbox-admin:modules\\..*', '1', '', 'MODULES_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('2', '', '^contentbox-admin:mediamanager\\..*', '1', '', 'MEDIAMANAGER_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('3', '', '^contentbox-admin:versions\\.(remove)', '1', '', 'VERSIONS_DELETE', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('4', '', '^contentbox-admin:versions\\.(rollback)', '1', '', 'VERSIONS_ROLLBACK', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('5', '', '^contentbox-admin:emailtemplates\\..*', '2', '', 'EMAIL_TEMPLATE_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('6', '', '^contentbox-admin:widgets\\.(remove|upload|edit|save|create|doCreate)', '2', '', 'WIDGET_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('7', '', '^contentbox-admin:tools\\.(importer|doImport)', '3', '', 'TOOLS_IMPORT', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('8', '', '^contentbox-admin:(settings|permissions|roles|securityRules)\\..*', '4', '', 'SYSTEM_TAB', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('9', '', '^contentbox-admin:settings\\.save', '5', '', 'SYSTEM_SAVE_CONFIGURATION', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('10', '', '^contentbox-admin:settings\\.(raw|saveRaw|flushCache|flushSingletons|mappingDump|viewCached|remove)', '6', '', 'SYSTEM_RAW_SETTINGS', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('11', '', '^contentbox-admin:securityRules\\.(remove|save|changeOrder|apply)', '7', '', 'SECURITYRULES_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('12', '', '^contentbox-admin:roles\\.(remove|removePermission|save|savePermission)', '8', '', 'ROLES_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('13', '', '^contentbox-admin:permissions\\.(remove|save)', '9', '', 'PERMISSIONS_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('14', '', '^contentbox-admin:dashboard\\.reload', '10', '', 'RELOAD_MODULES', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('15', '', '^contentbox-admin:pages\\.(changeOrder|remove)', '11', '', 'PAGES_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('16', '', '^contentbox-admin:layouts\\.(remove|upload|rebuildRegistry|activate)', '12', '', 'LAYOUT_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('17', '', '^contentbox-admin:entries\\.(quickPost|remove)', '13', '', 'ENTRIES_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('18', '', '^contentbox-admin:customHTML\\.(editor|remove|save)', '14', '', 'CUSTOMHTML_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('19', '', '^contentbox-admin:comments\\.(doStatusUpdate|editor|moderate|remove|save|saveSettings)', '15', '', 'COMMENTS_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('20', '', '^contentbox-admin:categories\\.(remove|save)', '16', '', 'CATEGORIES_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('21', '', '^contentbox-admin:authors\\.(remove|removePermission|savePermission)', '17', '', 'AUTHOR_ADMIN', 'cbadmin/security/login', 'event', '');
INSERT INTO `cb_securityRule` VALUES ('22', '', '^contentbox-admin:.*', '18', '', 'CONTENTBOX_ADMIN', 'cbadmin/security/login', 'event', '^contentbox-admin:security\\.');
INSERT INTO `cb_securityRule` VALUES ('23', '', '^contentbox-filebrowser:.*', '19', '', 'MEDIAMANAGER_ADMIN', 'cbadmin/security/login', 'event', '');

-- ----------------------------
-- Table structure for `cb_setting`
-- ----------------------------
DROP TABLE IF EXISTS `cb_setting`;
CREATE TABLE `cb_setting` (
  `settingID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`settingID`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cb_setting
-- ----------------------------
INSERT INTO `cb_setting` VALUES ('1', 'cb_paging_maxRSSComments', '10');
INSERT INTO `cb_setting` VALUES ('2', 'cb_site_mail_username', '');
INSERT INTO `cb_setting` VALUES ('3', 'cb_paging_maxrows', '20');
INSERT INTO `cb_setting` VALUES ('4', 'cb_gravatar_display', 'true');
INSERT INTO `cb_setting` VALUES ('5', 'cb_media_createFolders', 'true');
INSERT INTO `cb_setting` VALUES ('6', 'cb_site_maintenance_message', '<h1>This site is down for maintenance.<br /> Please check back again soon.</h1>');
INSERT INTO `cb_setting` VALUES ('7', 'cb_html_afterContent', '');
INSERT INTO `cb_setting` VALUES ('8', 'cb_dashboard_recentComments', '5');
INSERT INTO `cb_setting` VALUES ('9', 'cb_customHTML_caching', 'true');
INSERT INTO `cb_setting` VALUES ('10', 'cb_rss_cachingTimeoutIdle', '15');
INSERT INTO `cb_setting` VALUES ('11', 'cb_html_afterSideBar', '');
INSERT INTO `cb_setting` VALUES ('12', 'cb_comments_moderation', 'true');
INSERT INTO `cb_setting` VALUES ('13', 'cb_entry_caching', 'true');
INSERT INTO `cb_setting` VALUES ('14', 'cb_html_postIndexDisplay', '');
INSERT INTO `cb_setting` VALUES ('15', 'cb_site_disable_blog', 'false');
INSERT INTO `cb_setting` VALUES ('16', 'cb_site_mail_ssl', 'false');
INSERT INTO `cb_setting` VALUES ('17', 'cb_notify_page', 'true');
INSERT INTO `cb_setting` VALUES ('18', 'cb_html_afterBodyStart', '');
INSERT INTO `cb_setting` VALUES ('19', 'cb_site_outgoingEmail', 'webmaster@grapestack.com');
INSERT INTO `cb_setting` VALUES ('20', 'cb_comments_whoisURL', 'http://whois.arin.net/ui/query.do?q');
INSERT INTO `cb_setting` VALUES ('21', 'cb_html_beforeBodyEnd', '');
INSERT INTO `cb_setting` VALUES ('22', 'cb_html_postCommentForm', '');
INSERT INTO `cb_setting` VALUES ('23', 'cb_rss_cacheName', 'Template');
INSERT INTO `cb_setting` VALUES ('24', 'cb_media_allowDownloads', 'true');
INSERT INTO `cb_setting` VALUES ('25', 'cb_search_maxResults', '20');
INSERT INTO `cb_setting` VALUES ('26', 'cb_html_preCommentForm', '');
INSERT INTO `cb_setting` VALUES ('27', 'cb_site_homepage', 'cbBlog');
INSERT INTO `cb_setting` VALUES ('28', 'cb_site_maintenance', 'false');
INSERT INTO `cb_setting` VALUES ('29', 'cb_notify_author', 'true');
INSERT INTO `cb_setting` VALUES ('30', 'cb_rss_caching', 'true');
INSERT INTO `cb_setting` VALUES ('31', 'cb_media_uploadify_sizeLimit', '0');
INSERT INTO `cb_setting` VALUES ('32', 'cb_media_quickViewWidth', '400');
INSERT INTO `cb_setting` VALUES ('33', 'cb_site_mail_tls', 'false');
INSERT INTO `cb_setting` VALUES ('34', 'cb_versions_max_history', '');
INSERT INTO `cb_setting` VALUES ('35', 'cb_html_beforeHeadEnd', '');
INSERT INTO `cb_setting` VALUES ('36', 'cb_site_layout', 'default');
INSERT INTO `cb_setting` VALUES ('37', 'cb_media_allowUploads', 'true');
INSERT INTO `cb_setting` VALUES ('38', 'cb_content_cachingTimeoutIdle', '15');
INSERT INTO `cb_setting` VALUES ('39', 'cb_comments_moderation_notify', 'true');
INSERT INTO `cb_setting` VALUES ('40', 'cb_comments_urltranslations', 'true');
INSERT INTO `cb_setting` VALUES ('41', 'cb_html_preArchivesDisplay', '');
INSERT INTO `cb_setting` VALUES ('42', 'cb_html_prePageDisplay', '');
INSERT INTO `cb_setting` VALUES ('43', 'cb_comments_moderation_whitelist', 'true');
INSERT INTO `cb_setting` VALUES ('44', 'cb_comments_moderation_blockedlist', '');
INSERT INTO `cb_setting` VALUES ('45', 'cb_notify_entry', 'true');
INSERT INTO `cb_setting` VALUES ('46', 'cb_site_email', 'webmaster@grapestack.com');
INSERT INTO `cb_setting` VALUES ('47', 'cb_content_caching', 'true');
INSERT INTO `cb_setting` VALUES ('48', 'cb_html_postEntryDisplay', '');
INSERT INTO `cb_setting` VALUES ('49', 'cb_comments_notify', 'true');
INSERT INTO `cb_setting` VALUES ('50', 'cb_paging_bandgap', '5');
INSERT INTO `cb_setting` VALUES ('51', 'cb_rss_maxEntries', '10');
INSERT INTO `cb_setting` VALUES ('52', 'cb_search_adapter', 'contentbox.model.search.DBSearch');
INSERT INTO `cb_setting` VALUES ('53', 'cb_html_postArchivesDisplay', '');
INSERT INTO `cb_setting` VALUES ('54', 'cb_site_keywords', '');
INSERT INTO `cb_setting` VALUES ('55', 'cb_html_beforeSideBar', '');
INSERT INTO `cb_setting` VALUES ('56', 'cb_media_uploadify_customOptions', '');
INSERT INTO `cb_setting` VALUES ('57', 'cb_comments_maxDisplayChars', '500');
INSERT INTO `cb_setting` VALUES ('58', 'cb_comments_notifyemails', '');
INSERT INTO `cb_setting` VALUES ('59', 'cb_site_mail_password', '');
INSERT INTO `cb_setting` VALUES ('60', 'cb_html_preEntryDisplay', '');
INSERT INTO `cb_setting` VALUES ('61', 'cb_html_postPageDisplay', '');
INSERT INTO `cb_setting` VALUES ('62', 'cb_dashboard_recentPages', '5');
INSERT INTO `cb_setting` VALUES ('63', 'cb_site_name', 'ContentBox');
INSERT INTO `cb_setting` VALUES ('64', 'cb_content_cacheName', 'Template');
INSERT INTO `cb_setting` VALUES ('65', 'cb_media_uplodify_fileDesc', 'All Files');
INSERT INTO `cb_setting` VALUES ('66', 'cb_html_preIndexDisplay', '');
INSERT INTO `cb_setting` VALUES ('67', 'cb_gravatar_rating', 'PG');
INSERT INTO `cb_setting` VALUES ('68', 'cb_comments_enabled', 'true');
INSERT INTO `cb_setting` VALUES ('69', 'cb_site_description', '');
INSERT INTO `cb_setting` VALUES ('70', 'cb_content_cachingTimeout', '60');
INSERT INTO `cb_setting` VALUES ('71', 'cb_media_directoryRoot', '/grape/sites/blog/ROOT/modules/contentbox/content');
INSERT INTO `cb_setting` VALUES ('72', 'cb_site_mail_server', '');
INSERT INTO `cb_setting` VALUES ('73', 'cb_media_allowDelete', 'true');
INSERT INTO `cb_setting` VALUES ('74', 'cb_paging_maxentries', '10');
INSERT INTO `cb_setting` VALUES ('75', 'cb_media_uplodify_fileExt', '*.*;');
INSERT INTO `cb_setting` VALUES ('76', 'cb_comments_moderation_blacklist', '');
INSERT INTO `cb_setting` VALUES ('77', 'cb_dashboard_recentEntries', '5');
INSERT INTO `cb_setting` VALUES ('78', 'cb_site_tagline', 'asdfas');
INSERT INTO `cb_setting` VALUES ('79', 'cb_media_acceptMimeTypes', '');
INSERT INTO `cb_setting` VALUES ('80', 'cb_html_beforeContent', '');
INSERT INTO `cb_setting` VALUES ('81', 'cb_rss_cachingTimeout', '60');
INSERT INTO `cb_setting` VALUES ('82', 'cb_rss_maxComments', '10');
INSERT INTO `cb_setting` VALUES ('83', 'cb_html_afterFooter', '');
INSERT INTO `cb_setting` VALUES ('84', 'cb_comments_captcha', 'true');
INSERT INTO `cb_setting` VALUES ('85', 'cb_media_uploadify_allowMulti', 'true');
INSERT INTO `cb_setting` VALUES ('86', 'cb_site_mail_smtp', '25');
INSERT INTO `cb_setting` VALUES ('87', 'cb_active', 'true');
