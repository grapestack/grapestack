# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: Localhost (MySQL 5.5.15)
# Database: contentbox
# Generation Time: 2012-03-08 02:37:22 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cb_author
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_author`;

CREATE TABLE `cb_author` (
  `authorID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'0',
  `lastLogin` datetime DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `FK_roleID` int(11) NOT NULL,
  PRIMARY KEY (`authorID`),
  UNIQUE KEY `username` (`username`),
  KEY `FK6847396B9724FA40` (`FK_roleID`),
  KEY `idx_active` (`isActive`),
  KEY `idx_email` (`email`),
  KEY `idx_login` (`username`,`password`,`isActive`),
  CONSTRAINT `FK6847396B9724FA40` FOREIGN KEY (`FK_roleID`) REFERENCES `cb_role` (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_author` WRITE;
/*!40000 ALTER TABLE `cb_author` DISABLE KEYS */;

INSERT INTO `cb_author` (`authorID`, `firstName`, `lastName`, `email`, `username`, `password`, `isActive`, `lastLogin`, `createdDate`, `FK_roleID`)
VALUES ('1', 'GRAPE', 'Stack', 'webmaster@grapestack.com', 'admin', '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', '1', '2012-02-08 16:14:51', '2012-02-03 14:13:38', '2');

/*!40000 ALTER TABLE `cb_author` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_authorPermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_authorPermissions`;

CREATE TABLE `cb_authorPermissions` (
  `FK_authorID` int(11) NOT NULL,
  `FK_permissionID` int(11) NOT NULL,
  KEY `FKE167E219AA6AC0EA` (`FK_authorID`),
  KEY `FKE167E21937C1A3F2` (`FK_permissionID`),
  CONSTRAINT `FKE167E21937C1A3F2` FOREIGN KEY (`FK_permissionID`) REFERENCES `cb_permission` (`permissionID`),
  CONSTRAINT `FKE167E219AA6AC0EA` FOREIGN KEY (`FK_authorID`) REFERENCES `cb_author` (`authorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cb_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_category`;

CREATE TABLE `cb_category` (
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_category` WRITE;
/*!40000 ALTER TABLE `cb_category` DISABLE KEYS */;

INSERT INTO `cb_category` (`categoryID`, `category`, `slug`)
VALUES
	(1,'News','news'),
	(2,'ColdFusion','coldfusion'),
	(3,'ColdBox','coldbox'),
	(4,'ContentBox','contentbox');

/*!40000 ALTER TABLE `cb_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_comment`;

CREATE TABLE `cb_comment` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `author` varchar(100) NOT NULL,
  `authorIP` varchar(100) NOT NULL,
  `authorEmail` varchar(255) NOT NULL,
  `authorURL` varchar(255) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `isApproved` bit(1) NOT NULL DEFAULT b'0',
  `FK_contentID` int(11) NOT NULL,
  PRIMARY KEY (`commentID`),
  KEY `FKFFCED27F91F58374` (`FK_contentID`),
  KEY `idx_approved` (`isApproved`),
  KEY `idx_contentComment` (`isApproved`,`FK_contentID`),
  KEY `idx_createdDate` (`createdDate`),
  CONSTRAINT `FKFFCED27F91F58374` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_comment` WRITE;
/*!40000 ALTER TABLE `cb_comment` DISABLE KEYS */;

INSERT INTO `cb_comment` (`commentID`, `content`, `author`, `authorIP`, `authorEmail`, `authorURL`, `createdDate`, `isApproved`, `FK_contentID`)
VALUES
	(1,'What an amazing blog entry, congratulations!','Awesome Joe','127.0.0.1','awesomejoe@gocontentbox.com','www.gocontentbox.com','2012-02-24 14:30:32',b'1',1),
	(2,'I am some bad words and bad comment not approved','Bad Joe','127.0.0.1','badjoe@gocontentbox.com','www.gocontentbox.com','2012-02-24 14:30:32',b'1',1),
	(3,'pageOverridepageOverridepageOverridepageOverride\r\n\r\npageOverridepageOverridepageOverridepageOverride\r\npageOverridepageOverridepageOverridepageOverride\r\npageOverridepageOverridepageOverridepageOverridepageOverridepageO\r\nverridepageOverridepageOverride','Luis majano','127.0.0.1','lmajano@ortussolutions.com','http://www.ortussolutions.com','2012-03-02 17:32:38',b'1',3),
	(4,'Test','Luis majano','127.0.0.1','lmajano@ortussolutions.com','http://www.ortussolutions.com','2012-03-05 21:44:08',b'1',3);

/*!40000 ALTER TABLE `cb_comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_content`;

CREATE TABLE `cb_content` (
  `contentID` int(11) NOT NULL AUTO_INCREMENT,
  `contentType` varchar(255) NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `createdDate` datetime NOT NULL,
  `publishedDate` datetime DEFAULT NULL,
  `isPublished` bit(1) NOT NULL DEFAULT b'1',
  `allowComments` bit(1) NOT NULL DEFAULT b'1',
  `passwordProtection` varchar(100) DEFAULT NULL,
  `HTMLKeywords` varchar(160) DEFAULT NULL,
  `HTMLDescription` varchar(160) DEFAULT NULL,
  `hits` bigint(20) DEFAULT '0',
  `FK_parentID` int(11) DEFAULT NULL,
  `FK_authorID` int(11) DEFAULT NULL,
  `cache` bit(1) NOT NULL DEFAULT b'1',
  `cacheTimeout` int(11) DEFAULT '0',
  `cacheLastAccessTimeout` int(11) DEFAULT '0',
  `expireDate` datetime DEFAULT NULL,
  PRIMARY KEY (`contentID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `FKFFE01899AA6AC0EA` (`FK_authorID`),
  KEY `FKFFE018996FDC2C99` (`FK_parentID`),
  KEY `idx_slug` (`slug`),
  KEY `idx_discriminator` (`contentType`),
  KEY `idx_publishedSlug` (`slug`,`isPublished`),
  KEY `idx_published` (`contentType`,`isPublished`,`passwordProtection`),
  KEY `idx_createdDate` (`createdDate`),
  KEY `idx_search` (`title`,`isPublished`),
  KEY `idx_cachetimeout` (`cacheTimeout`),
  KEY `idx_cache` (`cache`),
  KEY `idx_cachelastaccesstimeout` (`cacheLastAccessTimeout`),
  KEY `idx_expireDate` (`expireDate`),
  CONSTRAINT `FKFFE018996FDC2C99` FOREIGN KEY (`FK_parentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKFFE01899AA6AC0EA` FOREIGN KEY (`FK_authorID`) REFERENCES `cb_author` (`authorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_content` WRITE;
/*!40000 ALTER TABLE `cb_content` DISABLE KEYS */;

INSERT INTO `cb_content` (`contentID`, `contentType`, `title`, `slug`, `createdDate`, `publishedDate`, `isPublished`, `allowComments`, `passwordProtection`, `HTMLKeywords`, `HTMLDescription`, `hits`, `FK_parentID`, `FK_authorID`, `cache`, `cacheTimeout`, `cacheLastAccessTimeout`, `expireDate`)
VALUES
	(1,'Entry','My first entry','my-first-entry','2012-02-24 14:30:32','2012-02-23 14:30:00',b'1',b'1','','cool,first entry, contentbox','The most amazing ContentBox blog entry in the world',28,NULL,NULL,b'1',0,0,NULL),
	(2,'Page','About','about','2012-02-24 14:30:32','2012-02-17 14:30:00',b'1',b'0','','about, contentbox,coldfusion,coldbox','The most amazing ContentBox page in the world',38,NULL,NULL,b'0',30,10,NULL),
	(3,'Page','Products','products','2012-02-24 14:34:32','2012-02-24 14:33:00',b'1',b'1','','','',140,NULL,NULL,b'1',0,0,NULL),
	(4,'Page','ColdBox','coldbox','2012-02-24 14:39:17','2012-02-24 14:34:00',b'1',b'0','','','',89,3,NULL,b'1',0,0,NULL),
	(5,'Entry','Wow new release is out','wow-new-release-is-out','2012-03-02 16:35:28','2012-03-02 16:35:00',b'1',b'1','','','',20,NULL,NULL,b'1',0,0,NULL),
	(6,'Page','Test Page','test-page','2012-03-06 23:47:08','2012-03-06 23:46:00',b'1',b'0','','','',1,NULL,NULL,b'1',0,0,NULL);

/*!40000 ALTER TABLE `cb_content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_contentCategories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_contentCategories`;

CREATE TABLE `cb_contentCategories` (
  `FK_contentID` int(11) NOT NULL,
  `FK_categoryID` int(11) NOT NULL,
  KEY `FKD96A0F95F10ECD0` (`FK_categoryID`),
  KEY `FKD96A0F9591F58374` (`FK_contentID`),
  CONSTRAINT `FKD96A0F9591F58374` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKD96A0F95F10ECD0` FOREIGN KEY (`FK_categoryID`) REFERENCES `cb_category` (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_contentCategories` WRITE;
/*!40000 ALTER TABLE `cb_contentCategories` DISABLE KEYS */;

INSERT INTO `cb_contentCategories` (`FK_contentID`, `FK_categoryID`)
VALUES
	(1,2),
	(1,4),
	(5,1);

/*!40000 ALTER TABLE `cb_contentCategories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_contentversion
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_contentversion`;

CREATE TABLE `cb_contentversion` (
  `contentVersionID` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `changelog` longtext,
  `version` int(11) NOT NULL,
  `createdDate` datetime NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'0',
  `FK_authorID` int(11) NOT NULL,
  `FK_contentID` int(11) NOT NULL,
  PRIMARY KEY (`contentVersionID`),
  KEY `FKE166DFFAA6AC0EA` (`FK_authorID`),
  KEY `FKE166DFF91F58374` (`FK_contentID`),
  KEY `idx_active` (`isActive`),
  KEY `idx_contentVersions` (`isActive`,`FK_contentID`),
  KEY `idx_version` (`version`),
  KEY `idx_createdDate` (`createdDate`),
  CONSTRAINT `FKE166DFF91F58374` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`),
  CONSTRAINT `FKE166DFFAA6AC0EA` FOREIGN KEY (`FK_authorID`) REFERENCES `cb_author` (`authorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_contentversion` WRITE;
/*!40000 ALTER TABLE `cb_contentversion` DISABLE KEYS */;

INSERT INTO `cb_contentversion` (`contentVersionID`, `content`, `changelog`, `version`, `createdDate`, `isActive`, `FK_authorID`, `FK_contentID`)
VALUES
	(1,'Hey everybody, this is my first blog entry made from ContentBox.  Isn\'t this amazing!\'','Initial creation',1,'2012-02-24 14:30:32',b'0',1,1),
	(2,'<p>Hey welcome to my about page for ContentBox, isn\'t this great!</p><p>{{{CustomHTML slug=\'contentbox\'}}}</p>','First creation',1,'2012-02-24 14:30:32',b'0',1,2),
	(3,'<p>\n	This is &nbsp;Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\n<p>\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\n<p>\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\n','Quick save',1,'2012-02-24 14:34:32',b'0',1,3),
	(4,'<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',2,'2012-02-24 14:34:45',b'0',1,3),
	(5,'<p>\r\n	{{{MessageBox type=&#39;error&#39; message=&#39;Hello You have an error&#39;}}}</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	<img alt=\"\" src=\"modules/contentbox/content/ContentBox_125.gif\" style=\"width: 124px; height: 118px; \" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',1,'2012-02-24 14:39:17',b'0',1,4),
	(6,'<p>\r\n	{{{MessageBox type=&#39;error&#39; message=&#39;Hello You have an error&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	<img alt=\"\" src=\"modules/contentbox/content/ContentBox_125.gif\" style=\"width: 124px; height: 118px; \" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',2,'2012-02-24 14:39:35',b'0',1,4),
	(7,'<p>\r\n	{{{MessageBox type=&#39;error&#39; message=&#39;Hello You have an error&#39;}}}</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	<img alt=\"\" src=\"modules/contentbox/content/ContentBox_125.gif\" style=\"width: 124px; height: 118px; \" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','Reverting to version 1',3,'2012-02-24 14:40:07',b'0',1,4),
	(8,'<p>\r\n	Hey welcome to my about page for ContentBox, isn&#39;t this great!</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n','',2,'2012-02-27 18:06:35',b'0',1,2),
	(9,'<p>\n	Hey welcome to my about page for ContentBox, isn&#39;t this great!</p>\n<p>\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\n','Quick save',3,'2012-02-27 20:41:51',b'0',1,2),
	(10,'<p>\r\n	Hey welcome to my about page for ContentBox, isn&#39;t this great!</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n','',4,'2012-02-27 20:44:23',b'0',1,2),
	(11,'<p>\r\n	Hey welcome to my about page for ContentBox, isn&#39;t this great!</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n','',5,'2012-02-27 21:07:10',b'0',1,2),
	(12,'<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn&#39;t this amazing!&#39;</p>\r\n','',2,'2012-02-27 21:38:33',b'0',1,1),
	(13,'<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn&#39;t this amazing!&#39;</p>\r\n','',3,'2012-02-27 21:39:34',b'0',1,1),
	(14,'<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn&#39;t this amazing!&#39;</p>\r\n','',4,'2012-02-27 21:40:44',b'0',1,1),
	(15,'<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn&#39;t this amazing!&#39;</p>\r\n','',5,'2012-02-27 21:52:45',b'0',1,1),
	(16,'<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn&#39;t this amazing!&#39;</p>\r\n','',6,'2012-02-27 21:52:53',b'0',1,1),
	(17,'<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn&#39;t this amazing!&#39;</p>\r\n','',7,'2012-02-27 21:53:04',b'0',1,1),
	(18,'<p>\r\n	Hey welcome to my about page for ContentBox, isn&#39;t this great!</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n','',6,'2012-02-27 21:53:26',b'0',1,2),
	(19,'<p>\r\n	Hey welcome to my about page for ContentBox, isn&#39;t this great!</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n','',7,'2012-02-27 21:53:35',b'0',1,2),
	(20,'<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn&#39;t this amazing!&#39;</p>\r\n','',8,'2012-02-29 21:16:32',b'0',1,1),
	(21,'<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',1,'2012-03-02 16:35:28',b'0',1,5),
	(22,'<p>\r\n	Hey everybody, this is my first blog entry made from ContentBox. Isn&#39;t this amazing!&#39;</p>\r\n','',9,'2012-03-02 16:35:49',b'1',1,1),
	(23,'<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',2,'2012-03-02 16:35:57',b'0',1,5),
	(24,'<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',3,'2012-03-02 16:46:00',b'1',1,5),
	(25,'<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',3,'2012-03-02 17:15:10',b'0',1,3),
	(26,'<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<h2>\r\n	Hello Man</h2>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<h3>\r\n	Hello</h3>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',4,'2012-03-05 20:43:40',b'1',1,3),
	(27,'<p>\r\n	Hey welcome to my about page for ContentBox, isn&#39;t this great!</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n','',8,'2012-03-05 21:39:53',b'1',1,2),
	(28,'<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',4,'2012-03-05 21:55:09',b'0',1,4),
	(29,'<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',5,'2012-03-05 22:03:05',b'0',1,4),
	(30,'<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',6,'2012-03-05 22:03:40',b'0',1,4),
	(31,'<p>\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\n<p>\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\n<p>\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\n<p>\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\n<p>\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\n<p>\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\n<p>\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\n<p>\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\n','Quick save',7,'2012-03-05 22:04:48',b'0',1,4),
	(32,'<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',8,'2012-03-05 22:05:00',b'0',1,4),
	(33,'<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',9,'2012-03-05 22:05:07',b'0',1,4),
	(34,'<p>\r\n	{{{CustomHTML slug=&#39;contentbox&#39;}}}</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">Nam</a> sed est. Nam a risus et est iaculis <a href=\"entry:[/my-first-entry]\" title=\"My first entry\">adipiscing</a>. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>\r\n','',10,'2012-03-05 22:08:06',b'1',1,4),
	(35,'<p>\r\n	Markdown Plugin For ColdBox<br />\r\n	===========================<br />\r\n	<br />\r\n	**ColdBox Version: 3.0.0**<br />\r\n	<br />\r\n	This plugin uses the markdownJ library found here:<br />\r\n	<br />\r\n	* [MarkdownJ](http://code.google.com/p/markdownj/) is the pure Java port of Markdown (a text-to-html conversion tool written by John Gruber.)<br />\r\n	<br />\r\n	## What is Markdown? ##<br />\r\n	<br />\r\n	Markdown is a text-to-HTML conversion tool for web writers. Markdown allows you to write using an easy-to-read, easy-to-write plain text format, then&nbsp; convert it to structurally valid XHTML (or HTML).</p>\r\n','',1,'2012-03-06 23:47:08',b'1',1,6);

/*!40000 ALTER TABLE `cb_contentversion` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_customfield
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_customfield`;

CREATE TABLE `cb_customfield` (
  `customFieldID` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `FK_contentID` int(11) DEFAULT NULL,
  PRIMARY KEY (`customFieldID`),
  KEY `FK1844684991F58374` (`FK_contentID`),
  KEY `idx_contentCustomFields` (`FK_contentID`),
  CONSTRAINT `FK1844684991F58374` FOREIGN KEY (`FK_contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cb_customhtml
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_customhtml`;

CREATE TABLE `cb_customhtml` (
  `contentID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` longtext,
  `content` longtext NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`contentID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_customHTML_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_customhtml` WRITE;
/*!40000 ALTER TABLE `cb_customhtml` DISABLE KEYS */;

INSERT INTO `cb_customhtml` (`contentID`, `title`, `slug`, `description`, `content`, `createdDate`)
VALUES
	(1,'ContactInfo','contentbox','Our contact information','<p style=\"text-align: center;\">\n	<a href=\"http://gocontentbox.org\"><img alt=\"\" src=\"/modules/contentbox/content/ContentBox_125.gif\" style=\"width: 124px; height: 118px;\" /></a></p>\n<p style=\"text-align: center;\">\n	Created by <a href=\"http://www.ortussolutions.com\">Ortus Solutions, Corp</a> and powered by <a href=\"http://coldbox.org\">ColdBox Platform</a>.</p>','2012-02-24 14:30:32');

/*!40000 ALTER TABLE `cb_customhtml` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_entry
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_entry`;

CREATE TABLE `cb_entry` (
  `contentID` int(11) NOT NULL,
  `excerpt` longtext,
  PRIMARY KEY (`contentID`),
  KEY `FK141674927FFF6A7` (`contentID`),
  CONSTRAINT `FK141674927FFF6A7` FOREIGN KEY (`contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_entry` WRITE;
/*!40000 ALTER TABLE `cb_entry` DISABLE KEYS */;

INSERT INTO `cb_entry` (`contentID`, `excerpt`)
VALUES
	(1,''),
	(5,'<p>\r\n	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n<p>\r\n	Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut odio. Nam sed est. Nam a risus et est iaculis adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer ut justo. In tincidunt viverra nisl. Donec dictum malesuada magna. Curabitur id nibh auctor tellus adipiscing pharetra. Fusce vel justo non orci semper feugiat. Cras eu leo at purus ultrices tristique.</p>\r\n');

/*!40000 ALTER TABLE `cb_entry` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_module
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_module`;

CREATE TABLE `cb_module` (
  `moduleID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `entryPoint` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `webURL` longtext,
  `forgeBoxSlug` varchar(255) DEFAULT NULL,
  `description` longtext,
  `isActive` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`moduleID`),
  KEY `idx_active` (`isActive`),
  KEY `idx_entryPoint` (`entryPoint`),
  KEY `idx_moduleName` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_module` WRITE;
/*!40000 ALTER TABLE `cb_module` DISABLE KEYS */;

INSERT INTO `cb_module` (`moduleID`, `name`, `title`, `version`, `entryPoint`, `author`, `webURL`, `forgeBoxSlug`, `description`, `isActive`)
VALUES
	(1,'CommentMarkdown','CommentMarkdown','1.0','CommentMarkdown','Ortus Solutions','http://www.ortussolutions.com','','Translates comments from markdown text',b'0'),
	(3,'Hello','Hello','1.0','Hello','Luis Majano','http://','','hello',b'1');

/*!40000 ALTER TABLE `cb_module` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_page`;

CREATE TABLE `cb_page` (
  `contentID` int(11) NOT NULL,
  `layout` varchar(200) DEFAULT NULL,
  `order` int(11) DEFAULT '0',
  `showInMenu` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`contentID`),
  KEY `FK21B2F26F9636A2E2` (`contentID`),
  KEY `idx_showInMenu` (`showInMenu`),
  CONSTRAINT `FK21B2F26F9636A2E2` FOREIGN KEY (`contentID`) REFERENCES `cb_content` (`contentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_page` WRITE;
/*!40000 ALTER TABLE `cb_page` DISABLE KEYS */;

INSERT INTO `cb_page` (`contentID`, `layout`, `order`, `showInMenu`)
VALUES
	(2,'pages',1,b'1'),
	(3,'pages',2,b'1'),
	(4,'pages',1,b'1'),
	(6,'pages',0,b'1');

/*!40000 ALTER TABLE `cb_page` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_permission`;

CREATE TABLE `cb_permission` (
  `permissionID` int(11) NOT NULL AUTO_INCREMENT,
  `permission` varchar(255) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`permissionID`),
  UNIQUE KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_permission` WRITE;
/*!40000 ALTER TABLE `cb_permission` DISABLE KEYS */;

INSERT INTO `cb_permission` (`permissionID`, `permission`, `description`)
VALUES
	(1,'PAGES_ADMIN','Ability to manage content pages, default is view only'),
	(2,'LAYOUT_ADMIN','Ability to manage layouts, default is view only'),
	(3,'WIDGET_ADMIN','Ability to manage widgets, default is view only'),
	(4,'GLOBALHTML_ADMIN','Ability to manage the system\'s global HTML content used on layouts'),
	(5,'TOOLS_IMPORT','Ability to import data into ContentBox'),
	(6,'SYSTEM_TAB','Access to the ContentBox System tools'),
	(7,'PAGES_EDITOR','Ability to manage content pages but not publish pages'),
	(8,'SYSTEM_UPDATES','Ability to view and apply ContentBox updates'),
	(9,'ENTRIES_ADMIN','Ability to manage blog entries, default is view only'),
	(10,'CUSTOMHTML_ADMIN','Ability to manage custom HTML, default is view only'),
	(11,'VERSIONS_ROLLBACK','Ability to rollback content versions'),
	(12,'RELOAD_MODULES','Ability to reload modules'),
	(13,'COMMENTS_ADMIN','Ability to manage comments, default is view only'),
	(14,'PERMISSIONS_ADMIN','Ability to manage permissions, default is view only'),
	(15,'AUTHOR_ADMIN','Ability to manage authors, default is view only'),
	(16,'MEDIAMANAGER_ADMIN','Ability to manage the system\'s media manager'),
	(17,'ROLES_ADMIN','Ability to manage roles, default is view only'),
	(18,'SYSTEM_RAW_SETTINGS','Access to the ContentBox raw geek settings panel'),
	(19,'CATEGORIES_ADMIN','Ability to manage categories, default is view only'),
	(20,'ENTRIES_EDITOR','Ability to manage blog entries but not publish entries'),
	(21,'SYSTEM_SAVE_CONFIGURATION','Ability to update global configuration data'),
	(22,'VERSIONS_DELETE','Ability to delete past content versions'),
	(23,'EMAIL_TEMPLATE_ADMIN','Ability to manage the system\'s email templates'),
	(24,'SECURITYRULES_ADMIN','Ability to manage the system\'s security rules, default is view only');

/*!40000 ALTER TABLE `cb_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_role`;

CREATE TABLE `cb_role` (
  `roleID` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`roleID`),
  UNIQUE KEY `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_role` WRITE;
/*!40000 ALTER TABLE `cb_role` DISABLE KEYS */;

INSERT INTO `cb_role` (`roleID`, `role`, `description`)
VALUES
	(1,'Editor','A ContentBox editor'),
	(2,'Administrator','A ContentBox Administrator'),
	(3,'Customer','');

/*!40000 ALTER TABLE `cb_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_rolePermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_rolePermissions`;

CREATE TABLE `cb_rolePermissions` (
  `FK_roleID` int(11) NOT NULL,
  `FK_permissionID` int(11) NOT NULL,
  KEY `FKDCCC1A4E9724FA40` (`FK_roleID`),
  KEY `FKDCCC1A4E37C1A3F2` (`FK_permissionID`),
  CONSTRAINT `FKDCCC1A4E37C1A3F2` FOREIGN KEY (`FK_permissionID`) REFERENCES `cb_permission` (`permissionID`),
  CONSTRAINT `FKDCCC1A4E9724FA40` FOREIGN KEY (`FK_roleID`) REFERENCES `cb_role` (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_rolePermissions` WRITE;
/*!40000 ALTER TABLE `cb_rolePermissions` DISABLE KEYS */;

INSERT INTO `cb_rolePermissions` (`FK_roleID`, `FK_permissionID`)
VALUES
	(1,13),
	(1,10),
	(1,7),
	(1,19),
	(1,20),
	(1,2),
	(1,4),
	(1,16),
	(1,11),
	(2,1),
	(2,2),
	(2,3),
	(2,4),
	(2,5),
	(2,6),
	(2,7),
	(2,8),
	(2,9),
	(2,10),
	(2,11),
	(2,12),
	(2,13),
	(2,15),
	(2,14),
	(2,16),
	(2,17),
	(2,18),
	(2,19),
	(2,21),
	(2,20),
	(2,23),
	(2,22),
	(2,24);

/*!40000 ALTER TABLE `cb_rolePermissions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_securityRule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_securityRule`;

CREATE TABLE `cb_securityRule` (
  `ruleID` int(11) NOT NULL AUTO_INCREMENT,
  `whitelist` varchar(255) DEFAULT NULL,
  `securelist` varchar(255) NOT NULL,
  `roles` varchar(255) DEFAULT NULL,
  `permissions` longtext,
  `redirect` longtext NOT NULL,
  `useSSL` bit(1) DEFAULT b'0',
  `order` int(11) NOT NULL DEFAULT '0',
  `match` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ruleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_securityRule` WRITE;
/*!40000 ALTER TABLE `cb_securityRule` DISABLE KEYS */;

INSERT INTO `cb_securityRule` (`ruleID`, `whitelist`, `securelist`, `roles`, `permissions`, `redirect`, `useSSL`, `order`, `match`)
VALUES
	(1,'','^contentbox-admin:mediamanager\\..*','','MEDIAMANAGER_ADMIN','cbadmin/security/login',b'0',1,'event'),
	(2,'','^contentbox-admin:versions\\.(remove)','','VERSIONS_DELETE','cbadmin/security/login',b'0',2,'event'),
	(3,'','^contentbox-admin:versions\\.(rollback)','','VERSIONS_ROLLBACK','cbadmin/security/login',b'0',3,'event'),
	(4,'','^contentbox-admin:emailtemplates\\..*','','EMAIL_TEMPLATE_ADMIN','cbadmin/security/login',b'0',4,'event'),
	(5,'','^contentbox-admin:widgets\\.(remove|upload|edit|save|create|doCreate)','','WIDGET_ADMIN','cbadmin/security/login',b'0',5,'event'),
	(6,'','^contentbox-admin:tools\\.(importer|doImport)','','TOOLS_IMPORT','cbadmin/security/login',b'0',6,'event'),
	(7,'','^contentbox-admin:(settings|permissions|roles|securityRules)\\..*','','SYSTEM_TAB','cbadmin/security/login',b'0',7,'event'),
	(8,'','^contentbox-admin:settings\\.save','','SYSTEM_SAVE_CONFIGURATION','cbadmin/security/login',b'0',8,'event'),
	(9,'','^contentbox-admin:settings\\.(raw|saveRaw|flushCache|flushSingletons|mappingDump|viewCached|remove)','','SYSTEM_RAW_SETTINGS','cbadmin/security/login',b'0',9,'event'),
	(10,'','^contentbox-admin:securityRules\\.(remove|save|changeOrder|apply)','','SECURITYRULES_ADMIN','cbadmin/security/login',b'0',10,'event'),
	(11,'','^contentbox-admin:roles\\.(remove|removePermission|save|savePermission)','','ROLES_ADMIN','cbadmin/security/login',b'0',11,'event'),
	(12,'','^contentbox-admin:permissions\\.(remove|save)','','PERMISSIONS_ADMIN','cbadmin/security/login',b'0',12,'event'),
	(13,'','^contentbox-admin:dashboard\\.reload','','RELOAD_MODULES','cbadmin/security/login',b'0',13,'event'),
	(14,'','^contentbox-admin:pages\\.(changeOrder|remove)','','PAGES_ADMIN','cbadmin/security/login',b'0',14,'event'),
	(15,'','^contentbox-admin:layouts\\.(remove|upload|rebuildRegistry|activate)','','LAYOUT_ADMIN','cbadmin/security/login',b'0',15,'event'),
	(16,'','^contentbox-admin:entries\\.(quickPost|remove)','','ENTRIES_ADMIN','cbadmin/security/login',b'0',16,'event'),
	(17,'','^contentbox-admin:customHTML\\.(editor|remove|save)','','CUSTOMHTML_ADMIN','cbadmin/security/login',b'0',17,'event'),
	(18,'','^contentbox-admin:comments\\.(doStatusUpdate|editor|moderate|remove|save|saveSettings)','','COMMENTS_ADMIN','cbadmin/security/login',b'0',18,'event'),
	(19,'','^contentbox-admin:categories\\.(remove|save)','','CATEGORIES_ADMIN','cbadmin/security/login',b'0',19,'event'),
	(20,'','^contentbox-admin:authors\\.(remove|removePermission|savePermission)','','AUTHOR_ADMIN','cbadmin/security/login',b'0',20,'event'),
	(21,'^contentbox-admin:security\\.','^contentbox-admin:.*','','','cbadmin/security/login',b'0',21,'event'),
	(22,'','^contentbox-filebrowser:.*','','MEDIAMANAGER_ADMIN','cbadmin/security/login',b'0',22,'event');

/*!40000 ALTER TABLE `cb_securityRule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_setting
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_setting`;

CREATE TABLE `cb_setting` (
  `settingID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`settingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_setting` WRITE;
/*!40000 ALTER TABLE `cb_setting` DISABLE KEYS */;

INSERT INTO `cb_setting` (`settingID`, `name`, `value`)
VALUES
	(1,'cb_html_preCommentForm',''),
	(2,'cb_comments_moderation_blockedlist',''),
	(3,'cb_media_createFolders','true'),
	(4,'cb_site_mail_tls','false'),
	(5,'cb_paging_maxrows','20'),
	(6,'cb_site_name','ContentBox Express'),
	(7,'cb_comments_captcha','true'),
	(8,'cb_comments_urltranslations','true'),
	(9,'cb_comments_moderation_notify','true'),
	(10,'cb_site_tagline','A very cool site'),
	(11,'cb_comments_notify','true'),
	(12,'cb_site_mail_username',''),
	(13,'cb_site_mail_smtp','25'),
	(14,'cb_rss_cachingTimeoutIdle','15'),
	(15,'cb_content_caching','true'),
	(16,'cb_media_uploadify_customOptions',''),
	(17,'cb_site_mail_server',''),
	(18,'cb_search_adapter','contentbox.model.search.DBSearch'),
	(19,'cb_site_maintenance','false'),
	(20,'cb_dashboard_recentPages','5'),
	(21,'cb_html_preEntryDisplay',''),
	(22,'cb_html_afterSideBar',''),
	(23,'cb_comments_enabled','true'),
	(24,'cb_html_postCommentForm',''),
	(25,'cb_rss_caching','true'),
	(26,'cb_paging_maxRSSComments','10'),
	(27,'cb_site_mail_password',''),
	(28,'cb_media_uplodify_fileDesc','All Files'),
	(29,'cb_html_postEntryDisplay',''),
	(30,'cb_site_description','My awesome site'),
	(31,'cb_paging_maxentries','10'),
	(32,'cb_media_uploadify_allowMulti','true'),
	(33,'cb_html_afterFooter',''),
	(34,'cb_html_afterBodyStart',''),
	(35,'cb_site_layout','corporattica'),
	(36,'cb_html_postIndexDisplay',''),
	(37,'cb_site_mail_ssl','false'),
	(38,'cb_html_beforeContent',''),
	(39,'cb_dashboard_recentComments','5'),
	(40,'cb_gravatar_display','true'),
	(41,'cb_html_prePageDisplay',''),
	(42,'cb_html_preArchivesDisplay',''),
	(43,'cb_site_disable_blog','false'),
	(44,'cb_site_keywords',''),
	(45,'cb_site_homepage','cbBlog'),
	(46,'cb_rss_maxEntries','10'),
	(47,'cb_comments_maxDisplayChars','500'),
	(48,'cb_rss_cachingTimeout','60'),
	(49,'cb_html_beforeSideBar',''),
	(50,'cb_content_cacheName','TEMPLATE'),
	(51,'cb_html_preIndexDisplay',''),
	(52,'cb_content_cachingTimeout','60'),
	(53,'cb_comments_moderation','true'),
	(54,'cb_media_uploadify_sizeLimit','0'),
	(55,'cb_html_beforeHeadEnd',''),
	(56,'cb_html_afterContent',''),
	(57,'cb_notify_entry','true'),
	(58,'cb_site_email','blog@grapestack.com'),
	(59,'cb_media_directoryRoot','/grape/sites/blog/ROOT/modules/contentbox/content'),
	(60,'cb_rss_maxComments','10'),
	(61,'cb_site_maintenance_message','<h1>This site is down for maintenance.<br /> Please check back again soon.</h1>'),
	(62,'cb_media_acceptMimeTypes',''),
	(63,'cb_comments_notifyemails',''),
	(64,'cb_media_allowDownloads','true'),
	(65,'cb_media_allowDelete','true'),
	(66,'cb_html_postArchivesDisplay',''),
	(67,'cb_dashboard_recentEntries','5'),
	(68,'cb_rss_cacheName','TEMPLATE'),
	(69,'cb_html_beforeBodyEnd',''),
	(70,'cb_comments_moderation_blacklist',''),
	(71,'cb_site_outgoingEmail','blog@grapestack.com'),
	(72,'cb_media_uplodify_fileExt','*.*;'),
	(73,'cb_gravatar_rating','PG'),
	(74,'cb_paging_bandgap','5'),
	(75,'cb_html_postPageDisplay',''),
	(76,'cb_comments_moderation_whitelist','true'),
	(77,'cb_notify_page','true'),
	(78,'cb_customHTML_caching','true'),
	(79,'cb_media_quickViewWidth','400'),
	(80,'cb_content_cachingTimeoutIdle','15'),
	(81,'cb_comments_whoisURL','http://whois.arin.net/ui/query.do?q'),
	(82,'cb_entry_caching','true'),
	(83,'cb_search_maxResults','20'),
	(84,'cb_notify_author','true'),
	(85,'cb_media_allowUploads','true'),
	(86,'cb_active','true');

/*!40000 ALTER TABLE `cb_setting` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
