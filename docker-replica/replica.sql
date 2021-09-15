
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mywiki_p` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `mywiki_p`;

DROP DATABASE IF EXISTS repl;
GRANT SELECT ON mywiki_p.* TO 'repl'@'%';

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor` (
  `actor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `actor_user` int(10) unsigned DEFAULT NULL,
  `actor_name` varbinary(255) NOT NULL,
  PRIMARY KEY (`actor_id`),
  UNIQUE KEY `actor_name` (`actor_name`),
  UNIQUE KEY `actor_user` (`actor_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` VALUES (1,1,'Flip'),(2,2,'MediaWiki default'),(3,3,'Bloop');
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive` (
  `ar_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar_namespace` int(11) NOT NULL DEFAULT 0,
  `ar_title` varbinary(255) NOT NULL DEFAULT '',
  `ar_comment_id` bigint(20) unsigned NOT NULL,
  `ar_actor` bigint(20) unsigned NOT NULL,
  `ar_timestamp` binary(14) NOT NULL,
  `ar_minor_edit` tinyint(4) NOT NULL DEFAULT 0,
  `ar_rev_id` int(10) unsigned NOT NULL,
  `ar_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ar_len` int(10) unsigned DEFAULT NULL,
  `ar_page_id` int(10) unsigned DEFAULT NULL,
  `ar_parent_id` int(10) unsigned DEFAULT NULL,
  `ar_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`ar_id`),
  UNIQUE KEY `ar_revid_uniq` (`ar_rev_id`),
  KEY `ar_name_title_timestamp` (`ar_namespace`,`ar_title`,`ar_timestamp`),
  KEY `ar_actor_timestamp` (`ar_actor`,`ar_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `archive` WRITE;
/*!40000 ALTER TABLE `archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `archive` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `bot_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bot_passwords` (
  `bp_user` int(10) unsigned NOT NULL,
  `bp_app_id` varbinary(32) NOT NULL,
  `bp_password` tinyblob NOT NULL,
  `bp_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `bp_restrictions` blob NOT NULL,
  `bp_grants` blob NOT NULL,
  PRIMARY KEY (`bp_user`,`bp_app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `bot_passwords` WRITE;
/*!40000 ALTER TABLE `bot_passwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `bot_passwords` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_title` varbinary(255) NOT NULL,
  `cat_pages` int(11) NOT NULL DEFAULT 0,
  `cat_subcats` int(11) NOT NULL DEFAULT 0,
  `cat_files` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_title` (`cat_title`),
  KEY `cat_pages` (`cat_pages`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `categorylinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorylinks` (
  `cl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `cl_to` varbinary(255) NOT NULL DEFAULT '',
  `cl_sortkey` varbinary(230) NOT NULL DEFAULT '',
  `cl_sortkey_prefix` varbinary(255) NOT NULL DEFAULT '',
  `cl_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cl_collation` varbinary(32) NOT NULL DEFAULT '',
  `cl_type` enum('page','subcat','file') NOT NULL DEFAULT 'page',
  PRIMARY KEY (`cl_from`,`cl_to`),
  KEY `cl_sortkey` (`cl_to`,`cl_type`,`cl_sortkey`,`cl_from`),
  KEY `cl_timestamp` (`cl_to`,`cl_timestamp`),
  KEY `cl_collation_ext` (`cl_collation`,`cl_to`,`cl_type`,`cl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `categorylinks` WRITE;
/*!40000 ALTER TABLE `categorylinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorylinks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `change_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_tag` (
  `ct_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ct_rc_id` int(10) unsigned DEFAULT NULL,
  `ct_log_id` int(10) unsigned DEFAULT NULL,
  `ct_rev_id` int(10) unsigned DEFAULT NULL,
  `ct_params` blob DEFAULT NULL,
  `ct_tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ct_id`),
  UNIQUE KEY `change_tag_rc_tag_id` (`ct_rc_id`,`ct_tag_id`),
  UNIQUE KEY `change_tag_log_tag_id` (`ct_log_id`,`ct_tag_id`),
  UNIQUE KEY `change_tag_rev_tag_id` (`ct_rev_id`,`ct_tag_id`),
  KEY `change_tag_tag_id_id` (`ct_tag_id`,`ct_rc_id`,`ct_rev_id`,`ct_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `change_tag` WRITE;
/*!40000 ALTER TABLE `change_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_tag` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `change_tag_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_tag_def` (
  `ctd_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctd_name` varbinary(255) NOT NULL,
  `ctd_user_defined` tinyint(1) NOT NULL,
  `ctd_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ctd_id`),
  UNIQUE KEY `ctd_name` (`ctd_name`),
  KEY `ctd_count` (`ctd_count`),
  KEY `ctd_user_defined` (`ctd_user_defined`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `change_tag_def` WRITE;
/*!40000 ALTER TABLE `change_tag_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_tag_def` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_hash` int(11) NOT NULL,
  `comment_text` blob NOT NULL,
  `comment_data` blob DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_hash` (`comment_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,0,'',NULL),(2,-1536008841,'Adding some things',NULL),(3,2002487602,'add a link to pagey',NULL),(4,1394884182,'Created this page',NULL),(5,1348957654,'Create my user page',NULL),(6,-1865030760,'Created page with \"I don\'t like you, Bloop! ~~~~\"',NULL),(7,-585807646,'More pages',NULL),(8,-2112157139,'created this',NULL),(9,718571575,'Adding a little story',NULL),(10,426856175,'/* The Dream-Quest of Unknown Kadath */',NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `content_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content_size` int(10) unsigned NOT NULL,
  `content_sha1` varbinary(32) NOT NULL,
  `content_model` smallint(5) unsigned NOT NULL,
  `content_address` varbinary(255) NOT NULL,
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,735,'a5wehuldd0go2uniagwvx66n6c80irq',1,'tt:1'),(2,787,'bok5cuuh2h8wsp0affimzzf2gngb4fa',1,'tt:2'),(3,813,'8t7lujzsm3xvuydax2eo7k9353rz4rx',1,'tt:3'),(4,3562,'pdqyyeritxtudwtt0b8lt9dxuoo7ugt',1,'tt:4'),(5,104,'qjsqmz5zezgmwshr8ac6fxxu2zl5023',1,'tt:5'),(6,100,'eu29ykb52423mkxzokewv5q4h5afdlx',1,'tt:6'),(7,902,'qo2uals4a3efxo3psxhqvj9hxivuw9w',1,'tt:7'),(8,3562,'e0bslqbimp8p4ik0rbnpgnh9dqnkgzp',1,'tt:8'),(9,3565,'30k8yoyy4fdd9nzur6vhpwwzh4wk950',1,'tt:9'),(10,243664,'lzwb9l8eyo5m4p2o1zyacwa3uhnzwmj',1,'tt:10'),(11,243670,'87f65c84275ilbhx5ig3neu6yrh7g2u',1,'tt:11');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `content_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_models` (
  `model_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_name` varbinary(64) NOT NULL,
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `model_name` (`model_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `content_models` WRITE;
/*!40000 ALTER TABLE `content_models` DISABLE KEYS */;
INSERT INTO `content_models` VALUES (1,'wikitext');
/*!40000 ALTER TABLE `content_models` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `externallinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externallinks` (
  `el_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `el_from` int(10) unsigned NOT NULL DEFAULT 0,
  `el_to` blob NOT NULL,
  `el_index` blob NOT NULL,
  `el_index_60` varbinary(60) NOT NULL,
  PRIMARY KEY (`el_id`),
  KEY `el_from` (`el_from`,`el_to`(40)),
  KEY `el_to` (`el_to`(60),`el_from`),
  KEY `el_index` (`el_index`(60)),
  KEY `el_index_60` (`el_index_60`,`el_id`),
  KEY `el_from_index_60` (`el_from`,`el_index_60`,`el_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `externallinks` WRITE;
/*!40000 ALTER TABLE `externallinks` DISABLE KEYS */;
INSERT INTO `externallinks` VALUES (1,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents','https://org.mediawiki.www./wiki/Special:MyLanguage/Help:Contents','https://org.mediawiki.www./wiki/Special:MyLanguage/Help:Cont'),(2,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Configuration_settings','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:Configuration_settings','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:Co'),(3,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:FAQ','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:FAQ','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:FA'),(4,1,'https://lists.wikimedia.org/mailman/listinfo/mediawiki-announce','https://org.wikimedia.lists./mailman/listinfo/mediawiki-announce','https://org.wikimedia.lists./mailman/listinfo/mediawiki-anno'),(5,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Localisation#Translation_resources','https://org.mediawiki.www./wiki/Special:MyLanguage/Localisation#Translation_resources','https://org.mediawiki.www./wiki/Special:MyLanguage/Localisat'),(6,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Combating_spam','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:Combating_spam','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:Co');
/*!40000 ALTER TABLE `externallinks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `filearchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filearchive` (
  `fa_id` int(11) NOT NULL AUTO_INCREMENT,
  `fa_name` varbinary(255) NOT NULL DEFAULT '',
  `fa_archive_name` varbinary(255) DEFAULT '',
  `fa_storage_group` varbinary(16) DEFAULT NULL,
  `fa_storage_key` varbinary(64) DEFAULT '',
  `fa_deleted_user` int(11) DEFAULT NULL,
  `fa_deleted_timestamp` binary(14) DEFAULT NULL,
  `fa_deleted_reason_id` bigint(20) unsigned NOT NULL,
  `fa_size` int(10) unsigned DEFAULT 0,
  `fa_width` int(11) DEFAULT 0,
  `fa_height` int(11) DEFAULT 0,
  `fa_metadata` mediumblob DEFAULT NULL,
  `fa_bits` int(11) DEFAULT 0,
  `fa_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `fa_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') DEFAULT 'unknown',
  `fa_minor_mime` varbinary(100) DEFAULT 'unknown',
  `fa_description_id` bigint(20) unsigned NOT NULL,
  `fa_actor` bigint(20) unsigned NOT NULL,
  `fa_timestamp` binary(14) DEFAULT NULL,
  `fa_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `fa_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`fa_id`),
  KEY `fa_name` (`fa_name`,`fa_timestamp`),
  KEY `fa_storage_group` (`fa_storage_group`,`fa_storage_key`),
  KEY `fa_deleted_timestamp` (`fa_deleted_timestamp`),
  KEY `fa_actor_timestamp` (`fa_actor`,`fa_timestamp`),
  KEY `fa_sha1` (`fa_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `filearchive` WRITE;
/*!40000 ALTER TABLE `filearchive` DISABLE KEYS */;
/*!40000 ALTER TABLE `filearchive` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `img_name` varbinary(255) NOT NULL DEFAULT '',
  `img_size` int(10) unsigned NOT NULL DEFAULT 0,
  `img_width` int(11) NOT NULL DEFAULT 0,
  `img_height` int(11) NOT NULL DEFAULT 0,
  `img_metadata` mediumblob NOT NULL,
  `img_bits` int(11) NOT NULL DEFAULT 0,
  `img_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `img_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') NOT NULL DEFAULT 'unknown',
  `img_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `img_description_id` bigint(20) unsigned NOT NULL,
  `img_actor` bigint(20) unsigned NOT NULL,
  `img_timestamp` binary(14) NOT NULL,
  `img_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`img_name`),
  KEY `img_actor_timestamp` (`img_actor`,`img_timestamp`),
  KEY `img_size` (`img_size`),
  KEY `img_timestamp` (`img_timestamp`),
  KEY `img_sha1` (`img_sha1`(10)),
  KEY `img_media_mime` (`img_media_type`,`img_major_mime`,`img_minor_mime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `imagelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagelinks` (
  `il_from` int(10) unsigned NOT NULL DEFAULT 0,
  `il_to` varbinary(255) NOT NULL DEFAULT '',
  `il_from_namespace` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`il_from`,`il_to`),
  KEY `il_to` (`il_to`,`il_from`),
  KEY `il_backlinks_namespace` (`il_from_namespace`,`il_to`,`il_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `imagelinks` WRITE;
/*!40000 ALTER TABLE `imagelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagelinks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `interwiki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interwiki` (
  `iw_prefix` varbinary(32) NOT NULL,
  `iw_url` blob NOT NULL,
  `iw_api` blob NOT NULL,
  `iw_wikiid` varbinary(64) NOT NULL,
  `iw_local` tinyint(1) NOT NULL,
  `iw_trans` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`iw_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `interwiki` WRITE;
/*!40000 ALTER TABLE `interwiki` DISABLE KEYS */;
INSERT INTO `interwiki` VALUES ('acronym','https://www.acronymfinder.com/~/search/af.aspx?string=exact&Acronym=$1','','',0,0),('advogato','http://www.advogato.org/$1','','',0,0),('arxiv','https://www.arxiv.org/abs/$1','','',0,0),('c2find','http://c2.com/cgi/wiki?FindPage&value=$1','','',0,0),('cache','https://www.google.com/search?q=cache:$1','','',0,0),('commons','https://commons.wikimedia.org/wiki/$1','https://commons.wikimedia.org/w/api.php','',0,0),('dictionary','http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=$1','','',0,0),('doi','https://dx.doi.org/$1','','',0,0),('drumcorpswiki','http://www.drumcorpswiki.com/$1','http://drumcorpswiki.com/api.php','',0,0),('dwjwiki','http://www.suberic.net/cgi-bin/dwj/wiki.cgi?$1','','',0,0),('elibre','http://enciclopedia.us.es/index.php/$1','http://enciclopedia.us.es/api.php','',0,0),('emacswiki','https://www.emacswiki.org/emacs/$1','','',0,0),('foldoc','https://foldoc.org/?$1','','',0,0),('foxwiki','https://fox.wikis.com/wc.dll?Wiki~$1','','',0,0),('freebsdman','https://www.FreeBSD.org/cgi/man.cgi?apropos=1&query=$1','','',0,0),('gentoo-wiki','http://gentoo-wiki.com/$1','','',0,0),('google','https://www.google.com/search?q=$1','','',0,0),('googlegroups','https://groups.google.com/groups?q=$1','','',0,0),('hammondwiki','http://www.dairiki.org/HammondWiki/$1','','',0,0),('hrwiki','http://www.hrwiki.org/wiki/$1','http://www.hrwiki.org/w/api.php','',0,0),('imdb','http://www.imdb.com/find?q=$1&tt=on','','',0,0),('kmwiki','https://kmwiki.wikispaces.com/$1','','',0,0),('linuxwiki','http://linuxwiki.de/$1','','',0,0),('lojban','https://mw.lojban.org/papri/$1','','',0,0),('lqwiki','http://wiki.linuxquestions.org/wiki/$1','','',0,0),('meatball','http://meatballwiki.org/wiki/$1','','',0,0),('mediawikiwiki','https://www.mediawiki.org/wiki/$1','https://www.mediawiki.org/w/api.php','',0,0),('memoryalpha','http://en.memory-alpha.org/wiki/$1','http://en.memory-alpha.org/api.php','',0,0),('metawiki','http://sunir.org/apps/meta.pl?$1','','',0,0),('metawikimedia','https://meta.wikimedia.org/wiki/$1','https://meta.wikimedia.org/w/api.php','',0,0),('mozillawiki','https://wiki.mozilla.org/$1','https://wiki.mozilla.org/api.php','',0,0),('mw','https://www.mediawiki.org/wiki/$1','https://www.mediawiki.org/w/api.php','',0,0),('oeis','https://oeis.org/$1','','',0,0),('openwiki','http://openwiki.com/ow.asp?$1','','',0,0),('pmid','https://www.ncbi.nlm.nih.gov/pubmed/$1?dopt=Abstract','','',0,0),('pythoninfo','https://wiki.python.org/moin/$1','','',0,0),('rfc','https://tools.ietf.org/html/rfc$1','','',0,0),('s23wiki','http://s23.org/wiki/$1','http://s23.org/w/api.php','',0,0),('seattlewireless','http://seattlewireless.net/$1','','',0,0),('senseislibrary','https://senseis.xmp.net/?$1','','',0,0),('shoutwiki','http://www.shoutwiki.com/wiki/$1','http://www.shoutwiki.com/w/api.php','',0,0),('squeak','http://wiki.squeak.org/squeak/$1','','',0,0),('theopedia','https://www.theopedia.com/$1','','',0,0),('tmbw','http://www.tmbw.net/wiki/$1','http://tmbw.net/wiki/api.php','',0,0),('tmnet','http://www.technomanifestos.net/?$1','','',0,0),('twiki','http://twiki.org/cgi-bin/view/$1','','',0,0),('uncyclopedia','https://en.uncyclopedia.co/wiki/$1','https://en.uncyclopedia.co/w/api.php','',0,0),('unreal','https://wiki.beyondunreal.com/$1','https://wiki.beyondunreal.com/w/api.php','',0,0),('usemod','http://www.usemod.com/cgi-bin/wiki.pl?$1','','',0,0),('wiki','http://c2.com/cgi/wiki?$1','','',0,0),('wikia','http://www.wikia.com/wiki/$1','','',0,0),('wikibooks','https://en.wikibooks.org/wiki/$1','https://en.wikibooks.org/w/api.php','',0,0),('wikidata','https://www.wikidata.org/wiki/$1','https://www.wikidata.org/w/api.php','',0,0),('wikif1','http://www.wikif1.org/$1','','',0,0),('wikihow','https://www.wikihow.com/$1','https://www.wikihow.com/api.php','',0,0),('wikimedia','https://foundation.wikimedia.org/wiki/$1','https://foundation.wikimedia.org/w/api.php','',0,0),('wikinews','https://en.wikinews.org/wiki/$1','https://en.wikinews.org/w/api.php','',0,0),('wikinfo','http://wikinfo.co/English/index.php/$1','','',0,0),('wikipedia','https://en.wikipedia.org/wiki/$1','https://en.wikipedia.org/w/api.php','',0,0),('wikiquote','https://en.wikiquote.org/wiki/$1','https://en.wikiquote.org/w/api.php','',0,0),('wikisource','https://wikisource.org/wiki/$1','https://wikisource.org/w/api.php','',0,0),('wikispecies','https://species.wikimedia.org/wiki/$1','https://species.wikimedia.org/w/api.php','',0,0),('wikiversity','https://en.wikiversity.org/wiki/$1','https://en.wikiversity.org/w/api.php','',0,0),('wikivoyage','https://en.wikivoyage.org/wiki/$1','https://en.wikivoyage.org/w/api.php','',0,0),('wikt','https://en.wiktionary.org/wiki/$1','https://en.wiktionary.org/w/api.php','',0,0),('wiktionary','https://en.wiktionary.org/wiki/$1','https://en.wiktionary.org/w/api.php','',0,0);
/*!40000 ALTER TABLE `interwiki` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ip_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_changes` (
  `ipc_rev_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ipc_rev_timestamp` binary(14) NOT NULL,
  `ipc_hex` varbinary(35) NOT NULL DEFAULT '',
  PRIMARY KEY (`ipc_rev_id`),
  KEY `ipc_rev_timestamp` (`ipc_rev_timestamp`),
  KEY `ipc_hex_time` (`ipc_hex`,`ipc_rev_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ip_changes` WRITE;
/*!40000 ALTER TABLE `ip_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_changes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ipblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipblocks` (
  `ipb_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipb_address` tinyblob NOT NULL,
  `ipb_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ipb_by_actor` bigint(20) unsigned NOT NULL,
  `ipb_reason_id` bigint(20) unsigned NOT NULL,
  `ipb_timestamp` binary(14) NOT NULL,
  `ipb_auto` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_anon_only` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_create_account` tinyint(1) NOT NULL DEFAULT 1,
  `ipb_enable_autoblock` tinyint(1) NOT NULL DEFAULT 1,
  `ipb_expiry` varbinary(14) NOT NULL,
  `ipb_range_start` tinyblob NOT NULL,
  `ipb_range_end` tinyblob NOT NULL,
  `ipb_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_block_email` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_allow_usertalk` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_parent_block_id` int(11) DEFAULT NULL,
  `ipb_sitewide` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ipb_id`),
  UNIQUE KEY `ipb_address_unique` (`ipb_address`(255),`ipb_user`,`ipb_auto`),
  KEY `ipb_user` (`ipb_user`),
  KEY `ipb_range` (`ipb_range_start`(8),`ipb_range_end`(8)),
  KEY `ipb_timestamp` (`ipb_timestamp`),
  KEY `ipb_expiry` (`ipb_expiry`),
  KEY `ipb_parent_block_id` (`ipb_parent_block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ipblocks` WRITE;
/*!40000 ALTER TABLE `ipblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipblocks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ipblocks_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipblocks_restrictions` (
  `ir_ipb_id` int(11) NOT NULL,
  `ir_type` tinyint(4) NOT NULL,
  `ir_value` int(11) NOT NULL,
  PRIMARY KEY (`ir_ipb_id`,`ir_type`,`ir_value`),
  KEY `ir_type_value` (`ir_type`,`ir_value`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ipblocks_restrictions` WRITE;
/*!40000 ALTER TABLE `ipblocks_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipblocks_restrictions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `iwlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iwlinks` (
  `iwl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `iwl_prefix` varbinary(32) NOT NULL DEFAULT '',
  `iwl_title` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`iwl_from`,`iwl_prefix`,`iwl_title`),
  KEY `iwl_prefix_title_from` (`iwl_prefix`,`iwl_title`,`iwl_from`),
  KEY `iwl_prefix_from_title` (`iwl_prefix`,`iwl_from`,`iwl_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `iwlinks` WRITE;
/*!40000 ALTER TABLE `iwlinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `iwlinks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `job_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_cmd` varbinary(60) NOT NULL DEFAULT '',
  `job_namespace` int(11) NOT NULL,
  `job_title` varbinary(255) NOT NULL,
  `job_timestamp` binary(14) DEFAULT NULL,
  `job_params` mediumblob NOT NULL,
  `job_random` int(10) unsigned NOT NULL DEFAULT 0,
  `job_attempts` int(10) unsigned NOT NULL DEFAULT 0,
  `job_token` varbinary(32) NOT NULL DEFAULT '',
  `job_token_timestamp` binary(14) DEFAULT NULL,
  `job_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`job_id`),
  KEY `job_sha1` (`job_sha1`),
  KEY `job_cmd_token` (`job_cmd`,`job_token`,`job_random`),
  KEY `job_cmd_token_id` (`job_cmd`,`job_token`,`job_id`),
  KEY `job_cmd` (`job_cmd`,`job_namespace`,`job_title`,`job_params`(128)),
  KEY `job_timestamp` (`job_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `l10n_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l10n_cache` (
  `lc_lang` varbinary(35) NOT NULL,
  `lc_key` varbinary(255) NOT NULL,
  `lc_value` mediumblob NOT NULL,
  PRIMARY KEY (`lc_lang`,`lc_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `l10n_cache` WRITE;
/*!40000 ALTER TABLE `l10n_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `l10n_cache` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `langlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `langlinks` (
  `ll_from` int(10) unsigned NOT NULL DEFAULT 0,
  `ll_lang` varbinary(35) NOT NULL DEFAULT '',
  `ll_title` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ll_from`,`ll_lang`),
  KEY `ll_lang` (`ll_lang`,`ll_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `langlinks` WRITE;
/*!40000 ALTER TABLE `langlinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `langlinks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `log_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_search` (
  `ls_field` varbinary(32) NOT NULL,
  `ls_value` varbinary(255) NOT NULL,
  `ls_log_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ls_field`,`ls_value`,`ls_log_id`),
  KEY `ls_log_id` (`ls_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `log_search` WRITE;
/*!40000 ALTER TABLE `log_search` DISABLE KEYS */;
INSERT INTO `log_search` VALUES ('associated_rev_id','1',1),('associated_rev_id','10',8),('associated_rev_id','4',3),('associated_rev_id','5',4),('associated_rev_id','6',5),('associated_rev_id','8',6),('associated_rev_id','9',7);
/*!40000 ALTER TABLE `log_search` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `logging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logging` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` varbinary(32) NOT NULL DEFAULT '',
  `log_action` varbinary(32) NOT NULL DEFAULT '',
  `log_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  `log_actor` bigint(20) unsigned NOT NULL,
  `log_namespace` int(11) NOT NULL DEFAULT 0,
  `log_title` varbinary(255) NOT NULL DEFAULT '',
  `log_page` int(10) unsigned DEFAULT NULL,
  `log_comment_id` bigint(20) unsigned NOT NULL,
  `log_params` blob NOT NULL,
  `log_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`log_id`),
  KEY `log_type_time` (`log_type`,`log_timestamp`),
  KEY `log_actor_time` (`log_actor`,`log_timestamp`),
  KEY `log_page_time` (`log_namespace`,`log_title`,`log_timestamp`),
  KEY `log_times` (`log_timestamp`),
  KEY `log_actor_type_time` (`log_actor`,`log_type`,`log_timestamp`),
  KEY `log_page_id_time` (`log_page`,`log_timestamp`),
  KEY `log_type_action` (`log_type`,`log_action`,`log_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `logging` WRITE;
/*!40000 ALTER TABLE `logging` DISABLE KEYS */;
INSERT INTO `logging` VALUES (1,'create','create','20210824004502',2,0,'Main_Page',1,1,'a:1:{s:17:\"associated_rev_id\";i:1;}',0),(2,'newusers','create','20210831213244',3,2,'Bloop',0,1,'a:1:{s:9:\"4::userid\";i:3;}',0),(3,'create','create','20210831213446',3,0,'Pagey',2,4,'a:1:{s:17:\"associated_rev_id\";i:4;}',0),(4,'create','create','20210831213523',3,2,'Bloop',3,5,'a:1:{s:17:\"associated_rev_id\";i:5;}',0),(5,'create','create','20210831213548',3,3,'Bloop',4,6,'a:1:{s:17:\"associated_rev_id\";i:6;}',0),(6,'create','create','20210831213721',3,0,'This',5,8,'a:1:{s:17:\"associated_rev_id\";i:8;}',0),(7,'create','create','20210831213811',3,0,'That',6,8,'a:1:{s:17:\"associated_rev_id\";i:9;}',0),(8,'create','create','20210831214106',3,0,'Dream',7,9,'a:1:{s:17:\"associated_rev_id\";i:10;}',0);
/*!40000 ALTER TABLE `logging` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `module_deps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_deps` (
  `md_module` varbinary(255) NOT NULL,
  `md_skin` varbinary(32) NOT NULL,
  `md_deps` mediumblob NOT NULL,
  PRIMARY KEY (`md_module`,`md_skin`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `module_deps` WRITE;
/*!40000 ALTER TABLE `module_deps` DISABLE KEYS */;
INSERT INTO `module_deps` VALUES ('mediawiki.action.view.postEdit','vector|en','[\"resources/src/mediawiki.action/images/check-success.svg\",\"resources/src/mediawiki.action/images/close.svg\",\"resources/src/mediawiki.less/mediawiki.mixins.less\"]'),('mediawiki.htmlform.styles','vector|en','[\"resources/src/mediawiki.htmlform.styles/images/question.png\",\"resources/src/mediawiki.htmlform.styles/images/question.svg\",\"resources/src/mediawiki.less/mediawiki.mixins.less\"]'),('mediawiki.icon','vector|en','[\"resources/src/mediawiki.icon/images/arrow-collapsed-ltr.svg\",\"resources/src/mediawiki.icon/images/arrow-expanded.svg\"]'),('mediawiki.notification','vector|en','[\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\",\"skins/Vector/variables.less\"]'),('mediawiki.special.userlogin.common.styles','vector|en','[\"resources/src/mediawiki.special.userlogin.common.styles/images/icon-lock.png\"]'),('mediawiki.special.userlogin.login.styles','vector|en','[\"resources/src/mediawiki.special.userlogin.login.styles/images/glyph-people-large.png\"]'),('mediawiki.special.userlogin.signup.styles','vector|en','[\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.special.userlogin.signup.styles/images/icon-contributors.png\",\"resources/src/mediawiki.special.userlogin.signup.styles/images/icon-edits.png\",\"resources/src/mediawiki.special.userlogin.signup.styles/images/icon-pages.png\"]'),('mediawiki.ui','vector|en','[\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"resources/src/mediawiki.ui/components/forms.less\",\"resources/src/mediawiki.ui/components/utilities.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\"]'),('mediawiki.ui.button','vector|en','[\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/mixins.buttons.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\"]'),('mediawiki.ui.checkbox','vector|en','[\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"resources/src/mediawiki.ui/components/images/checkbox-checked.svg\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\"]'),('mediawiki.ui.input','vector|en','[\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\"]'),('mediawiki.ui.radio','vector|en','[\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\"]'),('oojs-ui-core.styles','vector|en','[\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\",\"skins/Vector/variables.less\"]'),('skins.vector.styles.legacy','vector|en','[\"resources/src/mediawiki.action/styles.less\",\"resources/src/mediawiki.less/mediawiki.mixins.animation.less\",\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.less/mediawiki.mixins.rotation.less\",\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"resources/src/mediawiki.pager.tablePager/DataTable.less\",\"resources/src/mediawiki.skinning/content.tables-print.less\",\"resources/src/mediawiki.skinning/content.tables.less\",\"resources/src/mediawiki.skinning/content.thumbnails-layout.less\",\"resources/src/mediawiki.skinning/content.thumbnails.less\",\"resources/src/mediawiki.skinning/deprecated/mw-infobox.less\",\"resources/src/mediawiki.skinning/i18n-all-lists-margins.less\",\"resources/src/mediawiki.skinning/i18n-headings.less\",\"resources/src/mediawiki.skinning/i18n-ordered-lists.less\",\"resources/src/mediawiki.skinning/images/ajax-loader.gif\",\"resources/src/mediawiki.skinning/images/magnify-clip-ltr.png\",\"resources/src/mediawiki.skinning/images/magnify-clip-ltr.svg\",\"resources/src/mediawiki.skinning/images/magnify-clip-rtl.png\",\"resources/src/mediawiki.skinning/images/magnify-clip-rtl.svg\",\"resources/src/mediawiki.skinning/images/spinner.gif\",\"resources/src/mediawiki.skinning/interface-edit-section-links.less\",\"resources/src/mediawiki.skinning/interface.category.less\",\"resources/src/mediawiki.skinning/toc/i18n.less\",\"resources/src/mediawiki.skinning/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\",\"skins/Vector/resources/skins.vector.styles/Footer.less\",\"skins/Vector/resources/skins.vector.styles/Indicators.less\",\"skins/Vector/resources/skins.vector.styles/Menu.less\",\"skins/Vector/resources/skins.vector.styles/MenuDropdown.less\",\"skins/Vector/resources/skins.vector.styles/MenuPortal.less\",\"skins/Vector/resources/skins.vector.styles/MenuTabs.less\",\"skins/Vector/resources/skins.vector.styles/SearchBox.less\",\"skins/Vector/resources/skins.vector.styles/SidebarLogo.less\",\"skins/Vector/resources/skins.vector.styles/SiteNotice.less\",\"skins/Vector/resources/skins.vector.styles/TabWatchstarLink.less\",\"skins/Vector/resources/skins.vector.styles/common/normalize.less\",\"skins/Vector/resources/skins.vector.styles/common/print.less\",\"skins/Vector/resources/skins.vector.styles/common/typography.less\",\"skins/Vector/resources/skins.vector.styles/images/arrow-down.svg\",\"skins/Vector/resources/skins.vector.styles/images/bullet-icon.svg\",\"skins/Vector/resources/skins.vector.styles/images/external-link-ltr-icon.svg\",\"skins/Vector/resources/skins.vector.styles/images/portal-separator.png\",\"skins/Vector/resources/skins.vector.styles/images/search.svg\",\"skins/Vector/resources/skins.vector.styles/images/tab-normal-fade.png\",\"skins/Vector/resources/skins.vector.styles/images/tab-separator.png\",\"skins/Vector/resources/skins.vector.styles/images/unwatch-icon-hl.svg\",\"skins/Vector/resources/skins.vector.styles/images/unwatch-icon.svg\",\"skins/Vector/resources/skins.vector.styles/images/unwatch-temp-icon-hl.svg\",\"skins/Vector/resources/skins.vector.styles/images/unwatch-temp-icon.svg\",\"skins/Vector/resources/skins.vector.styles/images/user-avatar.svg\",\"skins/Vector/resources/skins.vector.styles/images/watch-icon-hl.svg\",\"skins/Vector/resources/skins.vector.styles/images/watch-icon.svg\",\"skins/Vector/resources/skins.vector.styles/legacy/MenuDropdown.less\",\"skins/Vector/resources/skins.vector.styles/legacy/Sidebar.less\",\"skins/Vector/resources/skins.vector.styles/legacy/layout.less\",\"skins/Vector/variables.less\"]');
/*!40000 ALTER TABLE `module_deps` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `objectcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objectcache` (
  `keyname` varbinary(255) NOT NULL DEFAULT '',
  `value` mediumblob DEFAULT NULL,
  `exptime` binary(14) NOT NULL,
  PRIMARY KEY (`keyname`),
  KEY `exptime` (`exptime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `objectcache` WRITE;
/*!40000 ALTER TABLE `objectcache` DISABLE KEYS */;
INSERT INTO `objectcache` VALUES ('global:watchlist-recent-updates:my_wiki:3','m�A\n\�0D\�\� �\'�m�\�\�R\� h���\�t��\�\�(.\�>f\�\�\�!,c8_\��x\"HߣX��\�\�#\�L>@~\�b{�\�|�(ȰvV�\�N�\�0�\�4ż�i�\�\r0(	\�/mѲj7�\�\��\�X� -�(�~l4�\�\�\�.��/�2�Z\�','20210831223548'),('my_wiki:MWSession:ejbj57ee821b0becrqmt3s8npsnp7vug','��\�R\�0E�%_\�ww\�cA-̴6r�O�:c��ÿc���`\�R\�Օt�鏨��,$���S������?n���EԜ銷\��\�\Zx/�\�w-�\�7�՝��\�\�\�\���=[&�r��ӔB�0^�\�\�\n��àS����xQ�+�n��`\';ŉR*�;�2�1bX\�\�&uIm��\�\�T��\�u#��� �^6h���dvZÀ%�Ϻ>x?NUq1=��-\�\�8�=�hT\�R\�\�\Z\�0P���\�8��R�a�\�\�~~N��`�D��1%\�\�_�\�0�e+��\�\�=#~�\�~\�p�KN\�O�\�\�Ε\\8H\�\�9\�׭\��\�o�\�2\���)\�M��\�>tx�\�>l\�l&�\�\�\�\�\�y\��\�vh\�O�\�97b�.&�łf|_','20210831223244'),('my_wiki:messages:en','��\n�0�e�`���}9\� 襊��\�4d�\�\�o�\��0	Ί\0:\�m��\�$V(hz\�5\�d>�\�\�\�2X\�l��/EMߝ�\�u\�>��6\�v\�\�\�','20380119031407'),('my_wiki:pcache:idhash:1-0!canonical','\��O:8:\"stdClass\":2:{s:14:\"__svc_schema__\";s:11:\"DAAIDgoKAQw\";s:8:\"__data__\";s:1945:\"�W{o\�\��*���޲l�\�\n��;�c]$_��cM�D\�\�.�]ZV\r����$\��\�zXN\�K\�\�&gfgfg~\�\��^\�\����x4�\�e\�#mr%\�\�+\��S|��kv\'�d�Ԇ\'�\�L\�l�n�\�\�r�\�\�\�M\�QZ�\�G�Cf\"0u�]k6W�<�TE��)ъ�\�*;\�,\�\�\�oS�\�P<��(k��\\,�3�IX\�}�\�ߣ6:u�]$ã$^*u\��+\�&Q�״��C8�I.P\�m5\�l��W�\�f[\�$�`�ˈP\���ڭ�\�Mה�\�aHEH���6�ڸ4e\�c%u� -� �Aµ\�adW\�\'H\�#y\�\�E\�d\�o��E+�|/�\�\�\�mzh�3\�<񯖗\\\���}.�̇#���\�h��Y�wE\n\�e7���r+\�\�и�\���2�ff�H�2\����\�\�\�tь��$�\�\�!H\�!�\���!L;\ns\0*�G\�\�\�M���O\0�\�+KF��>\���Kͦ\�\�`\�{\��\��uϋ\�\�V�~Q�7�b�$\�gk0��;�\�g��\�\nxi<	lH5SI���_zCW\�-\���d�Iy��\\Z!�]�\�\�R�Bb\�!\�\\F\�(�Px.U�a\�\�\�O��K��	̅VEʠl\�k�9K��?.�\�*�\�e5e��\\\n�K�3\�ĖˈE\�k}$��U�y\�l��� ���\�)\�Tn�򘣝��#�>\�uz\�\�a�\�\�\�u}\�d\�1�\�\�\�\�:��<YJ�\��\�\�\�O���J�$lD�\�>itc5��\�N>\�:�=*j%C=�;\��`\��\�\\!-\Z	x�u��Gld��\�\�\�\�*m�\�\�W.C�� ) �\��\�v�\�\��;豻%�\�TN\\冺��Hq�\�\�\�y��ɬZM%�\�D�T{FO32FC\�s�W6\�m\�;;\�\�T\�`\Z\�q��E����\�\�\�*�\�+��M�P\\� ��Z�+mD\�����\�Hu�Ntø[�u*\�B�\�=t��鲦QX���1FE��c`A��M\�\�Œ�\�[���Y��\�A\"�\�\�	�T�H]��B\�N�-�Yf.(�\�=\�A��E�r��\�\�\��\�\�\� f\�\�\Z^U%���מ��K\�;\�\�\�*��{��!aQ\�\�}B�٭N\��!UN\�S���\���<\�#�3�x�s\�\�\�w\�U��\��7_/\�ʧ&\�\�Y��1j9��3[1%�\�\�\�\�\�\�\�}\�\�6�\�c\��tbm(��\�\�7:\�\�\�[\�\�\�\�LPDN\�\�\Z\\ъ\�\�\�\���6�s\�e;\�\�;Z\�\�\�J�\��٩�Ra�����Y֔\��\�\�/�*�\�\�d�9Ƕ\��0R\�\�қs�,\n��D<�\�F\�=\�\n���[+�H\�DV/vGvϳ\\�vCvx\�*����̀.\�\�`�\� R�Jy�Hڪ\�*��\�|r}|>���4\�j\�c\�ɺ\�\�:\�\�\�w������#yA\��ֲT@\�g�\�	7�4pI\�\�\��%\�ɳ�l�\�\0��U�\�\�Ff\�] uk\��;\�\�T��F:h��\�eK��n�\�p�|�\�֖|\�\��\�\r\�zvر�^co\�Qͺj\�\�g�v_�[��Y\�#ï�Ԯ\rv\�\��\�bB\�g\�\�\�\�q;�V\�w �掷%h�l�\�lѩG\��[wv�7�\�~�\Z\��;���\'\�\'$\\(P|el`\�$\�g:\��j�ٍ��\�FD-ܫ�\�:�\�NT\�P޵�o!c�kb��:�#\�?#\�y#ä��(YG\�kh�\�mGc\�T�\�\'�j\\{�\�\�\�\�\�v��A\�p\�v\� T\�*�\�Ã��}:�\�ʎч\����{\\�nQ\�H9��\��jK\����\�\"٦\�ֿ��%�\�\�ZM�\�Q<\\��/�$٠SG�o���\�bVw\�]L��#\��;�\���\�S\�3�\��\�>�Jd��f�F6��B�o\�BT\�#E\�:\�\�	۱\�ꬔnx)�(\�?�����\�\�\�q��5ꩭ��s%��S\�\�\ZӬ�\�@\\\�c�\�\�#�Z\�\�=\�\�\�+\�U^\�\�>E�r\�ij\�ڶ7��Tm�;��G�$��!\�r��<�5�ŷ�\�Kn]�6\���+\�˲�J�rf?e\�\�O�S�X%֒J���ˬ�A C�5\�L\�B��\\\�޳\�\�\";}','20210901214153'),('my_wiki:pcache:idhash:2-0!canonical',';\�\�O:8:\"stdClass\":2:{s:14:\"__svc_schema__\";s:11:\"DAAIDgoKAQw\";s:8:\"__data__\";s:2790:\"�X\�n9�v\r\�\0��\�Kk<�mg\���=��~����$vjk�%\��O�o�/�sI��\�r?$���{\�\��`op0�>G7\�\�D\�\�h18>\�%\�Y�r��ye;��T\�\�.b2�\�{��\�eV\�\�\�ܗ|.\�e>+\�c\�ba�\����]z|�=�E\"���En\�!\�\Z�=A�_\�J��U)\�G���.?*�/\n%2&K]e,)\�B1-\r\�0v4=���\�S��\�\�1\�,��e>g\"�8�E�{L\�JgE \�P\Z\�D&��K�Z�0N�`�\�\�T�Y\�.�MNE�@?�\Z%���=-\�B�ٟ�\�\�\�.�i*ci�D\�,�\�E��\�E\n�Wi\�ٌ\�2�Z��[���+lԂ`�ȥժ��\\\n��UN�\�kU@\�\\\�L8[�N%�J���dm}��JX bV�\�%�%�d��R\�V&\�$+Ij�\�B���-��K���R\r����\�<�D\�\�\"F� H\�*E̲BM%��<GzY\\)��\"g�]vjs\�N\��Wq\�\�\�\�.��\�3\�\�\�u\��*-+Í`E\"���X�mY��)�&\�\"92V\�#\�\�.{k57\�\�\"w!$����\�T\�\'����~ͧ\�B9��\�\0�ny�7~ �!\�� ��M�\�\��\�K��MG*\nJ\�\�	�\�@M\��\�\�=󠕹A��\�y\r*\�Rq�\�`\n��W\�\0J�I�O�r\�1\�A7Y���\� \rX\0z��E�\�\�LR[\�T�.\�N��\�`D����\0qr�;(�\�\�9k�<ϥ18M��\0qT\0\�u�\�A�\��\�e���\r�\�/��\'pN\�\�%4��C%����v�\�\� \�W!�\�\�Z\�\�i�A��E�\�8\�8\�!�\�\�@�A*��Z7���\�l\�.��K�\�ظ�\�\n8i{\�-�\�%�T�Rg\�\��`�l\�iw<أ2�2\�\�b�r\�,\�=(��{�[M\�\�/\�2�\�\��\��H�$\�\�.6t]\�U�caSi�Cx\�EJjIV\r��%0)���\�\r�frD}\�]�\\�\�J\�1�b\�\�x������\0�l��&I\�ʙ\n2�}_��>P�+\�\�~�Dsr\�c�\�.6�\�&\�A�a�m(<{ \�\�\�38Rp��:\�BW�b�\�e\'P	l\�4jw\�v�y����b𑨠\�e,\�P�Ò��-%\�eW*�\r���\�sl�j\�\�\�E\����\�<i�W\�\�\�\0�Q,�t)A�\�\�\�\�vD�+\�M�}\n�x\�]\�\�Uk��R��9\�׼0�\�\��Cq�\��� �$<;I��\�\0�i\�\�\ru\n\�-֡�2=\�\\:�τ\�UUc\��<q��l?Ry&�\�p0y�\�!�\0l\r\Z\�\�!�q\�&_�\�V���\�Ռ�*m�O�\�\�!%6\�**�\�͵�zlhո\�G\�&��D7m���6]\�\�\rSՒ(�0�GY��\�\�j�@f��8]i?(�\������#��\\\�!�T\�ip��\�\�D\�ଙ\�\�\�m�\n\Z���V�\��ݼ@Fݣ]y�8�<i2�\�6D߸\�a\� \�7\Zُ�Oܣ\���=,3\��/\r\�~\\�\\t?2$-~\"u��{�x�\�\���\\i�\�Y\�\�\�P�W\�mjr�u�]ˀX]]�Þs]	��\�U�Am\�UԊ#\��oM�4\�\�\�B�q\�z�\�F�\�m\�\�\�9ιia�Ż?\�찻�R<\\_�\�3R�\n\�.?\�\�Dfb\��A�w8\��\�\�h\�o2\�XJ\�4f���^\�.?}\�y&cb\Z�=ƀO�Y�\n\�D�z\�>|\�\�\���\�*\�\�\���ސ��\�}��<ݶ\r#U�*\�e�\�ҼHh��H\�\�n�g�p�\�\���/lţ�\�\�i���Ebw�_�{6}\�\�\�pBJO)�\�湃�\�|Aذb5\��D�f�H펠\�\�\rT\0h?J#\�3�޶#o`��\�os\r0�:\�HK)l�\�j�\����I;;>�pC�(8j%6&ڈ�����\�\�t\'Y\�\�^��.�U\�\�\��\�\�_�\�\�\�\�+\�𥠈\�>\�\�,\�\'\�Ĳ���I�K�>�	�n�\�`�\�S\�j\0\"e\�Y��\�\�5�\�M%(��D6\"\�V}\�/\�z\�L�.ff͊:\�\�\�s!\�O:\Z�؉N\�ؼP�w\���\r�X(��F�T���\�@b�\�\�\�1\��>Zz\�\�yR+\0}ԛ�d*&��*-�\�\�\�#(9\�iK\�x�\�P�7�Dc[K�\�LĆ\�\�\�_ȤPO\�AO\�H�\��H�T�|����\�F�s\�\��=�\�r�\�뢨�����\�y\�\�\�\�q*\�]�q��O\�\0q�\�\r��\�\'\�*\�(�3}|�y\"�\�*2C�i���^\�fZ W�N\�\�xQ(/\��їN۸Acܰ1n˛lžn\�\��7X\�\�\�뷌\�\�\�\\�ssWGնi��a\�o0l0���:VG_�\�kU�A�P37W\'�o\�^\�pD\�\�T�T,6\�r>M\�\�\�\�y@\�9�v]�<9�~KH�\�\�\�\�z\�Yfr��#ۍY\�Ā\"�\�m6(\�\���e�,}��Av|s��v,\�(\�w	\"Z�\�u<����i�\�/<l)�Ѻ	�\�u��\�\�\n\�eo\�\�N-�?s$���\�sD�GK�IB͇h{�pݒzs�yD�4\0��\�֩_I�Џ;_V�\�f�\Z\�\�ktl@\�:\n>G�+�8\��@ݹ\�@\�3Hwz\�O5\�lF\�\�+\��\�\�\�\�mD\�\�}k�\Z26\Z\�:\���{!\"ߍ�/+&\�[Q\�F\�sh�\�k�4&�+sc\��٦\Zn\�{�\�\��\�~\���h�\�!T��\�\�\�`�?腿I�T�\'��O\��<lrR|#,f�\�_+~*f�˵U\�E��W)-CCD o\�\�\�<�\�\�RZY\'v>On1\�כ\���Hv\�&�M��\�b�_\���x	\�>�\��\rŁ<{\�q\�\�Naz46�u$IPL>Gw�\�\�\�N�\�\�sW��z}}�r:qpl��\�\�9u\�s\�H\Z\�H\��V�\�\�)\�\�-��ֺkn\���9\�j\"5Yx\�pA�]a�\�};\�}�\�\���^�b�pXwgD�T�}\�ٗNi�\�\0�5�\�f�)\���ݛ�R\�\�vL�\�l}��\�\";}','20210901213446'),('my_wiki:pcache:idhash:3-0!canonical','R��O:8:\"stdClass\":2:{s:14:\"__svc_schema__\";s:11:\"DAAIDgoKAQw\";s:8:\"__data__\";s:1277:\"�V\�n\�6~��Z@N$ٍ�X�\�dIlDN\�\�:�\�\�f-SI�h��\�g\�txH>b��$\�p8�\�o(�Vpފ�go+\�Eާ\�\�dbMƌ)%R\�	��\� =\�O�\�gTN����_\�fٚP���)+�<%<WD\�s 3<O\�1�\�P�\�HQ(g��k4Ȉ\��r0 ��E.Ԉwi2��(6��4�f|l�Ͱ\�i�\�&�U�\�:\"\�\�A0\�kN\�,!I\�p�1\�$�r>/2�P\�r.#\��E�c}\�8#�AH$\�\�T��=\�\��:)\��\�Y0\�\�S��K}sx\Z懺�T��\�7��S\�x���\'ٟ\�\�i38�v�\�\�Z\Z�J*&\��8�x\�&S���#)j�on㥗�P�\0��\�e�<\�\�W\��\�R	V`ғRl�\�n���*�:6\�ʥF\�\�\�j,n\\4�\�%?�\�\�\�O@\�W.\�G�\�T�\'�\�1��4\�\�%71]�\�hcb@�djJf�&\�\�Ӓ\�XTy\�\�)�Ө\�\�%�\���j���\�befS�./�\�R\�9!1F3�?�\�\\\��;31ny�wC��D\�\�0>�^\��\�\��\�$ܺ\�S�\�\\�\���\\#>`ї,\�mkc\�|\�$x�;\�R&w����e�^�\�,��H��\�\�_�N��{z\�8B\'mK�������\�+�\�\�]��id�4\�au��\�<-3\�Y\�j]K�e7\�c6��V�闪(\�U�W\�|��3>q+\�[\rD^�Pu���\�\�\�\�\�\�\�,�\"\�r�̸y\�\����^\�9V	V�icm\r\�l_PE�� _\�8[\�g(\�\"���\�x+7\�6�w���7��\�ъfP\�;Fy\�S\�ִ}\�Ew\'\��c�=��\�*��\��y\r/?\��.@E6\��1F\�W���R\Z�=}\��ڵ\��\�1{\�\�1\�\����\�\�\�	6Ǐ#bGQaϙ�\'\�$\�0�n\�8\�\�\0\�:>\0\r�|���\�G����Y�\Z�K~\�\�\�G�P�	\�3�\�x\�0\Z\�<���>��w��\��=dtbK����:#�!/;\�\�\�D\�62��M\�x�jh\��lJ�a���v�\�\�:\�-�\�5*0��f\�������\Z\�\"\���	��&5E!#	\Z\'��dC\�^���پ\�P\�F\�5�5�\�d)X�{X\�R/\�e�\�\�8Nz)Χz\�\�MƚYmjY<�\�*�uV\�~_�\�-��\�\"{�l\�9\�\�\r\�{�%T\�ӆ\�\�\�\�a\�>�ھ7���El\�QK�;졮\�\��\�\�t̅Ŝ�c�&��Q^I���c��->��\�)�ڗ�-;�Ç�4cqgߌ�׻u��(\�W\�+7\�Vg�\�Jt�ꔘ\�\�y�V95\"��\�@5�UMt};�\��\�<���َZ\�\��\�_\";}','20210901213523'),('my_wiki:pcache:idhash:4-0!canonical','�`�O:8:\"stdClass\":2:{s:14:\"__svc_schema__\";s:11:\"DAAIDgoKAQw\";s:8:\"__data__\";s:1354:\"�Vmo\�6�+,�b- \'�_�T\��N��H#r\�uQ�ms�I���xA����\���_�؎�a�`K\�\�\�\�\�\�N;9J\�\�{�S|\\�P!\�Oq6�h%�}\�R�o\�1A3E\'��\�>�\�+g\����*u\nc�3�\���\�\��\�\�,\�h\r*����|����\r\�s�����ӋP\'A�V\�JԎ\�	zw;\��\��\�~ߴZh,�\�\�pp\� EK�\�X\�I>�\0Z\�\�팏:I;\�\��Ga\����U���q<�+A,G��\n��	ᚂ�\\��\�\�0)t��~\�\�\�YF�&S�\�\�q^�\�B�\�\r%��\�!�T2�ZK��L3H�,(�]ٓ��$v\�Jm��\�o�JD��\�yz��i\�\�\��I��~�\�#\nP����i�\0\'^R�`\���:�\ZC-\�̞܅C\�\�K\n\�%E%Q�J4�Dn��\�\�X\�\nm+!\�y�\�\�\���\�\rjH=\�b\r�\�\n	7�G�\�\'�.�>�\�\�\�h���p�#�Z\0*\�[�}��{\�2�	�\�Ȓڈ\�>\�w\�\�М�\�b\���\�YZ:yʊѳ�ۊ\�\�DH�\�ȺcQiC\�\�ܢ�6���\�`eT1\���\�)��\�\�`\�_1��1�P\Z�_�E��M�b4|Da�(U�ي�k�\�\�g\rzC�m�4\���ֲ�\�\0)\�\n�ԛ���>{\�\��9\�4�D\�\�\�U��\��\�k���\r\�*6��Q8ue\�V\�\�+�$��Փ\"%\�\0rL}�E\�\�\�GfV�\�\�K1a\�\�I�\�ʔ����\�(�\�4|\0\�k�dI�i\�?�\�_�>_B��}H=|n&\���\�\�\�\��A>�Ms(����-\�\�Sb�?\�\�v�Gr/|���y޷r��\�v\�S�\��\��\�\�\�\�\�\Z\�P�>\�mK\n\�Wkh8�fA?�B\�ү+�n;��ޔ�\�Gw�[P\�z\\\�qF�gx+\�hZ�={\�*\r�\�N\�!z@\�\�\�7\�\�\�;\n�\��?<m��j\�\r�-�m}B�P\�\�\�1>e;�a?��c#�Y\����W���P���\r���=q�\'�\Z\�\�fë[��S7\�z;Y�\�x\�\�o1c\'�5��\����o�<nd\�Z�%\�\�x�\r`rh�Vf�2#�\��jp��w��\�\�\�\�A\�><�YV�+{`2\�}hk\��\�CG��A\�98\�4+\�M�d9D\�d*j\�	���\�5\�\'\�9\'SG�\n�\�u*��\05��t����@.o\�rP\�TT�oȇ0m�f\�&�Ӧ\�\�Z��lF��D\�\�A��E�:�)[\�\�\�\�~���\n\r:]k�n����V�^;\�r?\�ő9�4\�\�\�\nJ�\�)�&=su\�)\�\�\�)5\����̎\�	\�\�g�+�ɵ�~��\�\�E-,��\0��*\�\�N��\�.\�W�\�r��\�P_���^\�b\�\�M�\�E�\�ݣ\�@;�\�\�sr�\�:Q6\��nV%�\��d?�\�#��_\";}','20210901213548'),('my_wiki:pcache:idhash:5-0!canonical','4\�\�O:8:\"stdClass\":2:{s:14:\"__svc_schema__\";s:11:\"DAAIDgoKAQw\";s:8:\"__data__\";s:2783:\"�X\�n9�N\��,ɗ8Z���\�L���=\�\�MI�\�mx�\�	\�\'\�7\�\�)�\�n)����,\�r\�TQz�jg\�z�|I�ăI\�\��|t��k^�4\�Z�\�&)\�7\�g�,\�M\�d���J�[Yԕ2�4�5�\�k9�n�\�bq�\����MRz�_܏E&���U\�\��\�j.5��U,�U��\�`Fߔ�\��)�L\�\�,�\�J1-\r\�0=�w�V%�ƪ�ͻ\�3YK�\�r\�D.!�E�sLH��*cF\�\��4��\�,���\���\�\� X�g%g<�Z\�g�\�;Qf��FIm�\�\�Lh\�5�\�J\�M\�I�\�2�\�f�d���G{YZ0�b�\�sΦ<��\�\�-\�B\�ej�\�(�ᢔ\�V�,\�B(�\�>�T\�)��gsة�9�b5�\�炬mN�a��\"e6�/�\�,��i^KQ:����&�}v�[��mхR\�\�VA5�-\�W\�g\'4\�->b\��tgsĬ�ԝdw9/�^�Z�qA$\�L4�ώ\\n�t	q�\� \�»\�J�\�PO��\�~�ym\r7�U��(R.b\�m�*��\�5�(���҈��\�\�\�ܦW�҇��\�C�s�-\�({Y��\�I\�\�G�\��\�@\���\�\�`\�B_�>��\�=>��OH\0�KG.*J\�\�	�\�@M\��\�\�=���A��\�y*\�Zq��`�qs���D����J�\�c��m�D%\'rQ@�\0\�H�@�<�\��\�̩X}νf	\�ш>�\�\�8\�P\�Իw\�Ax�Ic M��\0qT\0/u�)\�A��\n�\�\�����\�/��\'pN\��%4��c%-�@8v�\�\� \�gO\�sD-b\�4ҠRԼ*S\�zN\���q\�d�\�j�֍#>�=:���`\�S<6>?�N�Cwǅ\�\�Q�:�sl\0A0`���{�\�aM���o�ܻ\�+sJ0\�\�N\��\�\�2}\�=?\��F/i���m�&\�\�\�T�L�\�\�p�\�R��%w@�$�\�@re�¦?4D��/��\�zC�2\�6%�!�Ǳ\�\Z�i\�	��M�$	}\09s\�\�JA�*7\��\�\��O�gNn�\�\�\��L�<{\�\�~\��	\�\�	\�0\�\�z\nG�	��g]i+@++}v���V\�r�t\']\\G�\�gZ\Z\�\������\��CX\�0\�LE\�مJeK?�+�ע\�tvﰽ�\�7\�\'m\�\�z\Z\�.��\��\�l\�\�F4�ҭ\�ԧ���\�E@!_\�-0�S��ǔ���\�\\�[3G\�QNa���\�ǭ5\n��#\�y`\�tR\�G�&\�\�AO��\n;�\�S�BQ5�t\�T�\�\�\�B�\�L6	\�ॴe\Z\��6�\�\\qc�6`\�	\�X=6X�ܟځ!�\��Y;{[\r�ĚRES��\�\�\r�\�\�\�a\�HEp\�\�1\��Y\�G�^3SP)�q\"��\�xT�\�\'�.	dF,���\�\������\�\�+<(\�\r\�8MvFc�����f\�t�/�\�L\�҅;�\�3`�H\�\�.\�\�o\�\�\�\�9�q\0\��\��\��\0s�\0q��\�}$|\�E7�\�q���\�xg\�\�\�\�\����	h	\�\��;%`�f\�X|\�JF�\�\�wO��;\�NS��\�l%a\\\�u\�\���=/Mm��l\�Mԉ#�\�̱4�6�B�v\�z�\�D�\�]\�@f��\�t0ѡݟ66\�My.\�//A\�)AyS\�tNU\"1f��h8\�\�\Z��[�Fð\�\�C-\�\�\�\�n7\�\�c\��\�\�\�1|r- \\5*��\�1��	K�\�N3��\�\��qsUf��� x�\��%�T�\\W�q�K\�*��\�\�\�{�Á��l�\���؊\'�\�s���Ej7G�ׯ�;#v\��ݔW\���R\\\�,\�)�wr6\'l8��\�L&j3G�6�q\�\���\0\�}�F����\�F��xS^�\Z`�t���\Z��ݮ�|hL\�\�.6&ml��\�\r�\�\�ؚ\�\"\�\�\��\�s�нd�{&x�\��V!\�?3�чsC�a*\�\�pI�̈́/E�\�1u���f\�>�GV<\�\�\�\�r\\�\��\�\�p��w6?�� rF\�U(��^A�\�T�\�\�Ad{\�\�J�o��{\�=\�\'\�\03sf%�䔗3Ĝ\�\�N\�?\��C86�\�\�?�\\,V*|��&\�.�HK{\�}�\�\"ŵA>K/=\�\Z�`�f\�\�\�D��\��C�_>~\0#�<\�\�C\��(\\�5T\�\�\"\�ؕR/y\'3�f����\�\�\�t��UgUfs�\�eb\�\�{�\�1��\�x�p�5着1\�w�Jpr��o_S��@sI\�\�^>%#đf7||\�g;H��� 	�!�\�2\�\�TU��̴Y!�Wө\�Ԡ�\�2�W*�_\�\�c\�׵m\�ڶ\�\�\�̃lɼ~\��\�\�wv��yc���>�\�sjײQǮ��\�\Zm���[����H���МL����\�wWg�N�XB�\�\�KՊ\�\�\�\�\�\�\��$\�\��,�����^Aߑ\�7�)1�����\�\�u\"OT)p�[q\�5�v\��f��Cw�\�@\�\�Bc��\"�\�\�\Z:�,\��@�+\�\re6}\�\�\���\�!8\�m�� ��\�\�\n\�*�\�\�7\�Z\�6\Z}t\�\"Ѵ���#z\�=\�\�Th>&Ϸ�\���ǟFĒ��ݤ��N�J\"�al\����\��5Р�ߢc\r\"VQ\�%��l!�B��\���O !�\�3!\�8�\r\�YEDE\�큗[��5ʇ\��d�5�#\���;1\"ߍ��K&\�Ϣ����\�\0��4eLW\�ʥ\��K5\�\�\�\Zlo\�\�m��v�v�{�\n�\��������b���C\�\�\�?x�\�D�#)>I3Qiۡ?S�\�\�ʪ\�\�\�ۜǦ�1�H\��8ɒ1=��\�/ќN�k��\�\�0\�Df]�Ik�9�µ\�\�mvW�U\�\�!�f\�]\�o�ql�r-<eE>RG�/�p�ݩ3/\�K\n�p\�\�?q�����稡C��\�걫�#�9��L\�Q\�Ldͪ{�\�,\�0�w\�}C�_|��\�W3�\�\�Cz\�\n7&�\�\�\�\�X;\�w\�6TЩ���G\�ON1P\�ms\�6M�ݒGݷ\�u�M�(\�`�[\�X�[H���4�|M�\�?\";}','20210901213721'),('my_wiki:pcache:idhash:6-0!canonical','[�\�O:8:\"stdClass\":2:{s:14:\"__svc_schema__\";s:11:\"DAAIDgoKAQw\";s:8:\"__data__\";s:2822:\"�X\�n9�N�\�dY;v�^3�3q�\�\�Ȟy��\�$N�6�\�\�\�\�\�K\�\�f�ٞ\��,\�rNUQzr�0�$��+\�\�$�\�h9:>\�5/Y�s��u�w;K��\\�\�&a2\�\�\�\�\�\�,��ſ�0F��[%ja��+HC��\0ÿ �Z��]�\������L\Z-R#��\�|!��j\�\r.\n�X��몎�v\�\�MyT���(���-XV\�bZ\Z\�az\�hv�V%�ƪ�\�\�1㙬�NI�\�%d�\�p�	iuQë��Y�2��-\r��\�|�[�0��\n�(9\��\�\�>�Y\�D�\�~�\Z%�����\r\�\�K���}6�\�\\�\�\�L����e���U*V\�<\�l\�S�K-�ׂ�\�R��\".J\�n\��\nqR*X\�/7}v�*ܳP|%3Ζ�S	�s\�j\�\�\n��9��\���\���B�\�J�y-E\�t�B���\�\�5n1�EJ�sV[ո� _u��g\�H����/\�\�\�YQ��d���H/K�\�8� �q&\Z\�g�.�^���Jm�s\�]q%\�g��\\\�g�ڼ����LV)�\�U�[S㚂�T�\�T\\iD�\�}\�\�\�ܦW�҇��\�C�s�-\�({Y��Ϥ\�@Q\�=\�\�\�� o�@\�c�n���M�]E\��Q\�\'$���#%h\�7�	\�\Z�g��4H�\�9o@\�\0[+.`\�\�B nɕ0��h\�\�_�{�\�w\��,\�D.\nh�\�h�簸�\�ќ\�\�s\�5K��F\�ٿ	P\'\����B�\�\�Y]\�y!Qd�,���� \��\�(�͞ v��\�yk\�f}a5<�s�\�ȖO���LZ/\��Q���>�x�`G\�\"v��[LQ˪L!\�k�G\0\�\��\� \�j�\�\�>*{.t@W�ҧ0xl|~R�t=�\��\�%�TuR\�Y\0���\n\�\�\�H�\�f\��\�8t3׷\�\�\�\�\�7��@���\�^��\�Tヂ�\�`�\n���\r\�*�h\�[\�\�E_���oq/�N�˳�����hҶ�ĨX�5p^$�\�M�GJV\�\�g��ɹMIa\�\�Ydd�?\�*\�gs�J\�&(��\�R\�h^G�PG=[cojQ�=\�\��\�^oϳC�\�3\�a�\�*�@\�	\�]�\�p\�W/Eԭ+m��CR��l�,�\�\��H\�i\��\�����\�Y�D\�\�}\�r�\�!,i\�x�o}v�R\�\'\��k`m:B\�\�\�W�J7<i[[\�/\�E���J�&7;���tٜ�0*\�\�\�7����\�\�\�\�_�J�6]\�r\�H�\�4�\��s\�\"Z�F:���xp\�<�\0y��`?v4y\�6a}J\�\\؅\��\�\0\�E	R���7\�0:G3٤���Җi\�\"P\� \�\�������\�\0�Q\�d\�(\�`\�zk��HM7!d\�|�5�[\Z\�|�k�\�=H�U2Ra\�6~�B~\���\�D(7r�q7\Zn�� \�@fD���5(T�\�\�����\�3��\�\�!�\�d4Z�Y�:o&ap\�N�G\��:\�\rm\�p�֫\rj\\,\�扊\�?ڕǈ\�ӳ(\�\0\�u[\�[\�\��#\�9\��\'\��\��s\�0\�\�e���\�-��\��K�\�{\�(�%̬~\�\�o���O#�ȕ�\�ڷQ��;\�NS��\�\�F\�H\�y\�C\�\���/Mm�iN)\�\�\�\�;�.M�\���Pl\�nI8\�!�#dV\�q\�M�\��\�\��)ߊ�\�K�\��\�\�To\��.�%�6\Z���\�\�p4�a��O�T\�v�lo0�)O\�K^Ȕ*\r\r �\'\�\�UQ�A�J���\��ty\�43�\����`0�\�\\���)\�	��?n\�/a���r]Q\�\�?,-���K7\�\���6��\�a+�u\��\�mF�\�OR�;\Z<?\�\�\��)�Przlq����_\�Œ�\�\�jj4��\��\�\�åg�\�E5\0���4r=\�]?\n\���\�\�\0c��G:j\�\�v�^\�1i߻ؘ��\n7���Nck���\�/����B\�R\�3�\�ܔ�\n���\�>���S��Kn�|%(����ŝ4K\�Qܳ\��\�N~��ڭOd�\�\�r\�lg\�C\�j\0\"g\�Y\�\�\�ܦ�ފ�|\��궒\�\�^wϫ\�\�[��9��^\�ļ�\�G�L\�\�%\'plQ)\�\�?\�t,V*|��&\�2�HK{\�}�\�\"ŵA>K�=\�\Z��\�\����\0���C�_>���\\\�s�/E\�ꬁ�S?�$G�^\�Rfb\�\�\�\�$R��V\�9\�\ZT��2���/SsW^i4��\\�ʛ�\\��X\�\Zc~\�DM߂\�\�sb�4\�{\�\��\�)!�4�\�\�\�?\�A���JH\�E���>\�UU\�O�{5�k�|\rz	/\�e��%��n�|\�u\��v�[;��\�\�\�\�w-=m\�p��c\�Co\�\r\�qsZ\�\Z6\�5~ڬ\�x4옵9]\'_�\�KU�I�ț����Wo^C<!\�\�\�\�k�\�\�Y\�g����>�p<\'\�.+t�{��(\��\�)7��\Z\�\�;W��\�\�\�u$_�vR\��\�k..\�\�\�\�\�ol\�u\�\�$ȡ\�^h6Qi}�\r���-\��\�\06\�\�\�\�\'\�c-ve��\�ަ	�\�M\�p-\�)~e�\�b�\�G? M\�\�\�9�Π�\�%�\�}\�x+Hp\�\�\��ÈX4���6֩gI�0�;_ր\�j�\Z\�\�ktlA\�&\n>\'�-$C(@=\��\0\�A<R�3\�\�\�\�MDD\�Q\�x���آ|\�\�\�@\�V#:b��#\�\����a\��(J�\�x\rPyI\�\�\�pe�\\z?�T\�\�g\��\�\��\�\�a\���x�\0p�p0\�?���&�\�e\�\�\�<�ob�BAR|�\"f�ҶQ+~*\��ʍU\�>۵9��ӂ\n��wbu�%z!��_bD8Ϯ1\�7�\�\�MZ�.�\�g�\��Y���\�5*\��\\�\�(\�\�ݎ�\�v*\�ɓ�QV4\�#Eq\"��W�;4\�ҽ�\��\�=��q\�\�\�-(t\�!\�Y=s�9\��\�\�H�q3�5�\�Q��x�!��\�;\Z��\�\r��IM�x,\�#W�iycߍr_\�F\�8\�Ջ@�\�\�^\�At�?\�@�\'Ι{\�4�vKt_�\�m6���?\�%�\���\�7��*���\��\";}','20210901213811'),('my_wiki:pcache:idhash:7-0!canonical','\0$�\�O:8:\"stdClass\":2:{s:14:\"__svc_schema__\";s:11:\"DAAIDgoKAQw\";s:8:\"__data__\";s:90790:\"��ے#Y�%�����fD\�1\�r�\�\"�U\�U%u\�:�\�]�##2b\0��\�Pvq�/��\�o\�\������\�ZKU\�6�gu\�#2Ց\�پ\�e\�ҥ\����_�\����_�\�\����\�\�\�\�7�\�o�\�\��\�\�ηfx9\�\�<�?��\�\\ﯗ�9\�\�\��\��y\�\�W?\\\��\�˩m���\�\�\�\��O�\���a��\�wͱY.��o�\�~\����\�\�\�?\��\��������\��k{얹=,\�8�ܚsk_�_�\�󿶿�\���\�~\�\��\���\�\�\�\��\�\�\�\�o>��\�\�\�\�\�\�\�05�\���?\��\��\�o\�\�\��;�\'~vj�\�\��\���m_�\�\�\�/�\�Ǳ�]^~\�LK;�\�\�O�\�C]�\�\��q�_\�\�ؽ؏\�?�߿7\��\�<4\�\�b�\�ܛ\�\��\�\�\�wK\�\��\�[�\��ȁy\�Η���9�/\�\���[>�|c?{�c;\�;z���a�\�\�;�\��s�\�^\�\�r�/\��ygv�\���\�0\�\�04G�\�L|��\�\�\��\�N\�m\���\�\�\�\�\�\�\�\�\��of�\�i\\��\��\�m\�\�k�t���6\�K\�짱9�\�Y�\�>\�pk�ӊ\�:7�=�\�;\�\�m��\�u�t\��e\�.\�\�^\�\�\�ݡYl\�\�1�~�\�\��\�7x�u\Z\�\�\��8=샚\�N\�\�\�\�೦\�>\�u�u�����\�\\\�\� /s?\�\�7}w\�\�\�-];\�&��iO�x[m{�捏o\�a;i\�2���\�\�>�o�\�y�k\�%\�\�\'?��v\�\�7/�֖0\�\�y<\�s\�_6\�\�	=��HC\�\�\�\�V�[\�{x�t׫=���\�q\�7�}\�\�B\�\�\�ĎȺ\� 4x�q=\��W���ʳ�\�\�\�-\�Y\�\�\���9\�\���#NBk�ɞ_\�~�\�uj�Eg��\�\�\��m�m�-M35\��x/{��\�ޖ�\�\���v��|\�\�؝�f8<�i\�:\�\�\��:\�\�\�{3t3�൵w�\�\�߲\�\�\�؞\�\�m�\�W�pG;؀�\�΍/��\�ߺ\�\����bьYso\�ܴ�\���aX���O�\�v嫛��\�\�mh\�z\�\�8\�M:Ҷ\�^\�9��.\�\�\�6pj�\�g��q��\�qxp�&��Cc;L3wѣ\�vuvQ\�\�\�k�_�y\�\�\�\�y��\�\�W\�jgqm=\�\�|z��\��\�?\�����?\�i�\�:�\��i�W8�\�by\�&{򇝋\�_h?G�R\�R�6\�:\�4\�\�Gj���\���\�±�\�\��\�~�{\�]\�J�p�\�0�7{�\�\��\��\�f\�\�\�ѣ\�\�\�\�\�\�<\�\�v:\�\�\�X\�S��;7�\�e\�U=�G\'h�\�\�F\�\�\�]�\�Nz\�./�\�M^XA�\�8���2iiXi\�l�μ\"aT�\�\�ej�\�-\��F�zq�\��+���-M?^l\�6\�þ�]�\�\�z5aG�;yj{ޘ��-�-\��������w~L\�0\�qd(N:	\�h\�;\�1�_���\�\�\'\�Ǔ}\�|u�̶Z�+4�\�\�v�Z3�+4\���ٰ\�=�<\�(\�N\�y�\�\�\�8\�ӵ=�����\n\�;Ef\�[^13\Z\�\�m\�\���K\�g�.<9��\�\�t�/\�s�\�\�Z�\�\�\�\�\�\��ۣ\�x�\�v�\�\�\�7\�\Zٶ�\��\��\�4XF�0�y1\�k�Y�t0 \\\�\\{�m͡�#v\���\�\�!�]��n]�\�|�\�{\�ZZF\�2\�v��\�\�4\�?l�\�h�ɾ�\�7\�\\PoV��~v\�K�\�;\�\�\�\�Ȼ��٬�\�ryq�\�5m�\�l7�\�\�\�\�0u\'{G�\�+�Z<�-�\��\�\�l~��y��\�\�\�\�\��KC\�M9`ՇW\�\�QʛmJCww\�-P27iW�\�\�\�\�i\Z\�t\�\�\'\�Ι=��#�\�ܚ9\�v�w�\�]\�\�Y/i��f�X\�\�\�`os�\�\�X�g�\�\�.\�[d\0\��W\�T�y8���\�\�ط\�\�a\�g��\�\�GPp����\�\�\�`\��4W\�s8\�\�p�&ڍ�\�\�\�.8+{\Z�&?�\�:�N^?N�_�o즷\�Gn�e\�\�\�l\�aW\�KZ��\�u�i�7�\�f.�;�]��\�ʡ�ǵ�\�G���\�\�%��\�x@m�-\�q\�t?�Z,�E_��TX8Z\0\�Sy\�\�{��}\"\rF´\�~]��\�q��\�;�\�p&\�\�\�	�\��̛ck?\�V\�\�\r���W|\�[\�a?�h�ksf�k�\�4\�\�\�vM-��Z�a<,���\�\�;�3\�?ߩ_\�u^��\�\���\�\�B\�fK�Z�9\�\�\�\�HG�{iosX\'ݪr}h��-2[a�\�{��ϕ�\��=B�\�|1���馗�ٞay\�a_�\�鴼�0Ib\�\�v\�ڄ#\"D<�\�\\�E#?�>Y�7 �i\�\�iY���r�.`�\�8\�\�5�c;�\�l��/l\Z\�(bp���� V�;[?;�a�Q,\Z\�\���\�G� �\�q��h�q\��\�\�ڧ?���\�\'�?\�(\��\�D1γ8��\�\�\�r5��\�\�\�\�-xpw4\�v\��ʓB�u�\�\�y\�\�>x��\�̰\�-\���ƫ\�Ј\'\�{�~�6�\�\"�\�7\�\��B�Y\�>�_�\�\�\�\\\�v\��<܄�=~\�;s�d\�N+�\�e\�\Z`�m\�;��\�\��\�\\/�\�*>6sj\�xJ-\�~�H\�F�z^�O�\�\�)�s��\�\�4�>\�X�=>\�/�e2p�\�n�\�\�D[z\�y�8\�}|X\\5\�v\���\�\�G��c3X$:Ӟ\�\��\��\�\�Bh\�Nn�ed��q�\�;w�=|\�: }�5\�!BxE{`7����]��n�V\��lf8`t�\�������xX�asN\��\�3\��\�S_#^�d��-;М*�\�\��\�\�i�\�?��\�\�U����%Y\�\�\��ҽ|\�\�qI>�\�\�\�\�m�ɝ��\�G�\�\���bf|h\�3O[!&�\�y�\�\�ׁ/�Czi�\\�}�-=?\�z\�\�z:\�\�\�%�3#�\�͜^ޑ�-%�3\�C.h?=\�=$\�\�z\�8l\'\��\�\r�r\�\��{\��\�eb\�\�џف8���\�\�\��\r9G\�8N��+x\�U0\�\�\�Y\�a\�g�b�w\��\�\�{�C��\�2�O�\�G\�\"��w<\��F�%\�}Rf�[���\�\0\�vtj\�=�\�\�p4��h��\�\�\�ܿ|G�3�� kp�{G\�K\�X���CF�[�#×\�T\�\�\�hK �U<�u8\�w!\'���vl��Ją\ng%r4\"\�\����G%\�KS�(�J\�>m�x��\�\�ґ°\�\���v:�\'���1[�\�F\�[\�>��\�m�2\n%\�\�<\�\�e�[���::�\�\�\�\�\��a\�\�a}z�\��<\�1�oi�p\�g�\Z\��깻�??�ż\��h�\��\'�9�\�\�� �\�ǉ�O��\Z\'ܾ\��ي\�Qw�Z^��`�\�^\Z�\�ݒ�\�ڮ\�`�z�\�w�l�dX���\r�ݙbl\�f��\�\�\�4\�\�\�]�\Z\�\��k\�\�͖�����w�\�{|2[\�\�^�\\Ff\�(�:z����iτG�3ڲq?��\�\�2c\��\�e;Xw�\�\�A:�o��Gv\�\�w\�\nkm��\��\�\�\�\�J���c77�YV\�\�L\�n֧�_X@\�k\�/\��d\�nb\�w\�\"\�\�vUV�\���2�\��Pref�֌)$3_Dݓ����R\�)^\��@q%�;�b�\�\�M�#��ו��HϬC\�\�$��\�\�_\�\�\�\�;\�2��G$\�`\�\��e�iA���\�,+\\�\0�QDa\nG/�m\�\�\�BfY@\�^�0Vid��\��\�}vÉH�.;�9Y&����g\Zb\�\�\��\��|$�\0]c�^_�\�ܮ=V�m\�g3\�\�h8�H	�\�Ev�a\�.�����\�|\�nY�^�\�AȾ��^%�\�π��\�<ø\"�\'l=\�2\�\�O\�}��ݣ쓭��,^\\a�M�\Z.~�T��6��{k\�6n�	�\�)��H!\�\\?㩔k?\�<q_��l�e\nP�\0\�~a.�vi�\���M�\�B�\�?6�Y��[\�~h;T\�\�\�XR\�u�Z\�İN��\�a�P\�\�\�\�0�[\'�\�v��G\��\�X��`�_�Ɠ2�%.�2N��\�\�\�X�F���*��\�D��X�\�;\\���}Z��(o5�`\�h{`}kjqa�&\�\�B\�@:љ\�sW�-#қw\�^{(N�\�E&�g\�F\�\�A��C{�\�h7z�3W�S���\�\�\�O{Q6ٲ��=\r�%6�\�\�	�J\�_v\�f\�\�\�j�;lTdܲ\0�\�}��Ё�\\\�j\�\�\�\n�L>�\�L\�\�\�Lh)��\�#=8��ș#�P\�/kz4�Mo?33\�n-S\�Ie>�=�\�|k��\�H\�\�\�^�!��1ͬ�X�-�B<\�\�#5�hf��ɋ��\�\�\��ZVa_쥁\�fO�E7\�\�����y�\�|��3��( Uq��\�<�\��Ve\��vd�]�*\�+i�}g\'����\�?��\�2�pj�O/�`�s\'>\�\�_\��>���e0v\����;\r^`w�\"w�5��H�\'�u\�\�i\�\�����(\�A�$V�W�&�ՎFi��\�y\��\�\�I#x8 \�\�Ӂ\�\�0n7`�r���(\����nu3\�3�u��p�<���}\�\��\0+����f�o��g�\�J\\r�83�Ū\�ӥ\�F\�{-�\�\�M\�O\��}\�ցXO�5v��^��\�\�ADo���V\�\0\�\�z#���^\�\�\�\�Dl+G< \�Ʈ$P�\\��^~a�}\�z<\�\���\�0�U�\�謴�\��\�Ӊ6��d\�\�H�W�߷�\�\�\�ر\�}\�	X;�\�o+�1\�q\�	�r��\�f\�?�/�\�\�\�❱\�$�\�=\�y�\�X\�X7�g�\�\�6�\�\�e)]1�\�o���\�!�Go���s@�iP\�[3\�\�\�%�$t`/\�i!�\0��U\�\�\�yK�TH\�\�\r~\�q�2w�v/\�~�\�ڱ�\�\�Z\���5�SI�\�/,�\�Q^x�Y\�H`/\�\�\'�b2�BA\�+\�|W\�H�B̢�\�G�T��\�T��}�0���m�P\'\�o�\�S ^ڛ�\�L?Χi�u\�\�lٙTY�>`�\�\�\�+���\�t}v+\��:������W\�p~\�ߚ�x\�\�@�µ\�\�Q\�A\r\r=\��ih\�FDh�u6\�r[�f�\�ґn�j\�{\�/\�\�\�\� ��_\�\�z�|\�e9/M7)M\�\�\��\�\�孵�yO��W��/\�e����Jo�!J\�\�\�c)Y\�\��~�6�\�\�Z^��\n�\�^��#���0QA�D�\�W\�W�gOY�½�\�\��pV�$ȫě\�G)��\��}p9~l7�+O%��\�`/\������#R牊�����%���m�m�\�d#�U�\�\�\�\�\�W�*\\�M�ã��\�\'^-o�bԀ\����Ӷ\�_iC�\�`4o\�`X�9\�\�)\�e�\�k}�iWY�Ƀ\�{P\��d���\��\"�[�\��\�\�\�j?��S\�\�\�~�)2}�D��\0g\�S\�h��\�\�\�\�B\�fj�~�\�\�@�����w̰\�w\��\�\�A欴���=�CT�Q(jG�$r�ۄ\�ة�g\�\'\�\�M�ڎFeC<�\�1\�`Ez�׿�@�\���\�\�\\\�\0\�`\�\�\�\�\n;\�=\�sU8\"�E\��A\�\��x$tG\���m����\��Xޞ\��9n\ZR\�S2\�h7�\����\�f9W�L�\�w\�jߨѺ��\�}ƣ�9\�p\�\�ک\Z�\�	\"�n`\�\�\�\�\�\�q�\�\�LL��	ь�&��}0B\�*����\�l\�\��\�4ނ�\�_�\�\�f�\�\�V\�JY\�~\Z�]�G\��6F6f�\�~1�1\�<s	�6pY\�-��:�0�\�\�4�SB��\�5��/\ZZ@U\r�{�$�\���\�)�\ZaQ��\�cL�\Z�\�;[�6n�\"|j�7\�1J/\�:\\�G\�\�>o�6ubMd\�\n�\�8\0U̫���/\�\Z�\�XP�\�	\�\�]\�v#{�\�Y�o\'q�B^$	\ZgVH\�]�\"ji@�Nm\�\�\�\�d\Z]r�\�i1�mB\�\�\��)���\�\�w\�xf�C�\�2�\�O��H%z�!�\�\� $\�.\�v{VE���_�\r���1_ͮ\��vB�\rX&u\�`��*�9Á�~iɀ�;յ�1v�\�J��Et�\�yI\n$\��IH#\�tE��p\�F\�n�}½!\\&PA\�7g\�L0�\�\�\�QY��\�\�,�5\r�n�B\�\�HG\�c�	\�\�|�pf2\��,\�4ᰙ\�\�\�\�W0J�AG�?3O��\�͖Y�/�.�E�}\�׻S\�\�QУ�=�b\�\�=8\\�VJǫ!Sg\�=CfŰ��1Q�I%�\'3x+\�`��)��ў\�\�\�E\�W\�\�`Ĵ\�#\�I��^�ht�h\�^\�HG\"\�\�t}dk\�	\�Ķˊ\�y\�\�\\\�]\�B��\�\�\�\�\�\����[,�&|��}`8��\\�����ł�ר=\�@��v\�T\�B2j�]�{a�\"�.�Ƭ���\"F/��\\(��Y#\�\�]\�)��+\n\��\�6\nl\���\'\�\�$EF�b�m��NI\�\�!���\"�:*\0�\�\�\��\�2��\�\�`V(Va^\�fL\�\�\�\�+�)\�B�\�\�\�\\ KCL\�\�N\�\�G�Ŵ)���Zm����o��\�?\�s�x\�9ݬ�ٰ�@��(\�YWX�#\�\�\�\�\����\�\r)`��9�\�_\�dv��6\n7\�\�\��\�\�\�B=�/\��VJK\�S*�F\�/u#e3�Q \�Lr<�!�,�.T!q^\�#�\�\"�\�\�Pն\0U���f:\�üyP\0\�\�9li��@tr�-�mW�ES[��\��� �l\�\�BF/�\r�m?v!�O_\�f\�\�,S�{b�\r¿\�\"&\�;K��\�\�\�\�Mv}\�S7.*,\�\�U�O�-�%�k�K����\�\�F�J�`Q�w��Q\�\�o�\�J�w<\�\"\n)ք�Zym\�?Wlz\�7�(\'#��\0\������x�`��\n�Q�ǋ\��>��\�U�n�^�u\��C�4�4=�\�c�y\n\�W\�]%�t�\�`x\�E4~�\���_�72�\�qY=￴�\�\�\��b1WA\"E�\n,څ\�U�ZqZYME9��\�)n\�dr\�<Dx83so�?G�\�\�_o�<n�z\��o\�X;�,\�v*\�6d\�1\�j4w\��\��o͗,���\�\��\�e��?#�\�}�\�>0#\�d�N\"8\��|i\�h�ڠ\080\�r�?ه���\�\�>��v6mpWT�1\�\���I`�\�^6K�\\{2\�n\�=l\�\�Woή�\�4$�q�x?�S��W�\�ݬ\�,$\�v�E\�\�\'�~�j[�|H!�P�.0�_}\�\�F�±\�nf-\�\�\�\r\�|�\�#�j\�\�\�;\�|\��\�:\�\r\�\�yb��\��\�)�\�\�ن\�]1�\�x�Mc�\�|�\�H*u�ozڧ���\�\�\�}�/�/9q\����g9\�\�5^�9,\�vN=ߤ�	���q�=F\�\�\�\�n�9�\�#�E{vm�r\�\�4WF�k\�\�W3��\�	��\")\�ߎ�H��\�b@}\�\�\�7ܚnB<x�\n\�=檐ð��\0>�X	�L�k\":�5��\�#\�#n�Sn��:�C�\�\�zŘۂ�%�ȝ\�bAd\0\�`��i\Z\�@7\��\��T��t\\X�c��\�\�׍@O\�\'���?��\�`b%ԘvW�4�Q\� \�v\�ph\�Nm\�\�:�`\�0)>Ui~t�xq3\��va1ݬxa�{?�E\�m\�}�\�q4l���j\�[\�<���u\�!��\�H+xP�\�ܑE����i\� \�2�\�!&\�ʦ�>\�ᕠ����\"�\�Ց�\�]\��\�\�[&R���/@<\nt��駗��U\�y<\r�;\�\\� J\�\�\�)\�\�N�\�Y�(���\�<~�����_\0F\�f�\�\�<3@��QGƭɆ\�y\�#a�\���F�}\�ŏ�t��\�B\�}X�\�Ѵ�\�\�\�m\�S\��\�O8*Py>XN\�B>�8���ǟ�l�\�Dp\�A)(٢\'\��}\�\�x5 �\�,!��ǹ\'�ǰ\"�(ȀZJ�ͺ\0IXkQ3g�\r\�\0\��ܪƓ-qS����BI�$q��_w\��щ0kt�\��w(Cu\n~\�7\�\�E��\�}�Ry6\�\�]\�\�۩�f����}�������\�Pp�W�\�#\�\�(�\�S�k��\�R	}\�Ht��c�ʴHD��\n��w\�\�\�TN�+\"�\�\�0���E�Y<�\�o\�U\�\Z�FNޏ�3���͑\0=���\�\rkL�\�N��ࣙ-!pce5��ӡ[�O\�D�\n#3�#�B��żDE���,��sI>\'��&[ze⧬���{�\�o\�]R.\rW\��\����RX��t2Β�f\�)�?����Pp�w����[�H2��S��Q���v�\�\Z��7\'�u\�lځg1\'\�.\�\�\�5\�}\�\�d\�)��\�(坳\�\�rˁ���rid�ݰe+^�\�\�_�7>cu�3 t�R,B�\�ZEr�\n݌6\�\�;\�rBt蓟|l\�^�ѫ%��\�\��aЃvu���`�^A\��7�\�c\�W�˱w�(Y4N\\G�p�X*\�\�\�W�\�Ȋl��y\��q|W�07\�\�\��H��+�\�mFs��\�\�`+��ZU7p�^��EGH\'B0(1d� .��\�Oǵ94��\��J3\�5\�/P,̨8^\�,\�\�c\��!�a�\�M@��س	��\ZI\�j\�<\��,d\�\�z��趾�s4=\�F�\�\�\�ϩ\�kh;Av,[\�\�\�B�cS٨��\�\�R�_�3\\|���;\�\�&H�\�#Dˣ\�͟��<6\�K\�&RX\�潑Ǽ���\�\�>�\�\'��H\�\�	��\�B</4���_>��x�}>F!6\�%-`Z?�84\�s\�\�z՞-\Z{݋p�F\�9�\'\�VǓ��i\�wуk+a\�@���2:<\�B��iλ\�F\�BRk|È�a_z\n~l�\�	\�A,��hз�Fmc\"z|\'pg>W\�y!;2N�\�9M�0?L\�^\�\�3\���{\�,g��?�������I���G&{\�\�(e�i�V�gt\�\��4�G���*\�EQF|l����� yr�:��{�n࿷{xK\�E��NRD=\�HV4�\�[dj��\�\�\�l!fmj\�3�?&�5�7\�(�\�U]�\��\�Ԩw�<���}\�ca&�o�xlF?8�u�׎TS\�?�\�m�ܡA���6cX{�+\�wψ���\�6G\�\�:�@cP�݅y�|\�f�\rkHB//I\�\�\�\�9\�\�\r*M��\�i\�\�\nq\��%\�wo@#����\�8\�I�e��\�\�<=\rvѩ\��nS�ⶢ\�-9�ixh[ăm��C��M$\�D2��E�N��P�K�\"\�\�\��K ]^M)\�\�op~��\�-K\�+��\�\�_\�ܽ>�\�\�F\�Qw�Hwȧ\�_VT�\�\�]|;۹_\�\�b3�u�lל!\�\�\�s�wuà(�#�\�b\�lO���LF�\�&��b�;>�\�j\���\����@�?x��8�҂�塟T)8\\�m$M=����y�]D�\�ӕ��\'	gb[Q\�\�\�c\�m\�\�\�}��ةҰ\'�%\�\�\�p\�xF\�,�ܩis�_\��T�\"�\\�\�%0�q?�j�����i�\�;<��Hj\�\�B��\�:W\�\�>I\�\�RSn\�޻�w�\�t�h�\�\�>�T)\�2��~�@F%�/�\n\\r\�\���̘-\�\�\�w�=\Zn���b�\�P��t\�\��\�@\�	>�<.�ATHɔk\�E<\�Բ�\�J��\�\��=�~ć\�xT�O��\r\�`Ń?z|ÊjvO��\�\0GQt���\�\�\�vQu\�\�\�\�\\��J�\"��t��TDW\"�g\�7��3M�(a.��6�b\�\�2��\�\�X4_\�ٶܟhgŋ\�?�;O�\�H�\�5�#:�j\��`��OU-Z\0��jd��,\�\Z9z\�*\�F�DI\�.�3\�rV,��Q\�������\�\�\�t�7s\�\�XMm=��o���\�\r��\�C\�\�.wE�\0\�d��c�<Q&2����\�(:Q��\Z�Pg���S\� ��A�o&FQؿ�y\�\�\�D�8�?�\�h\"�R\��\�,W!r�4\�\�\n=���=NP����9u\�\�\���@G�pH\�E�G��\\�\n���\�\�iqܘ\�6#��`\"\�%�\\`eF��\�K���\'��:u\�ԉ�R�V\�ܦ߷�~�\�\'�z+!�(�D~42ˣ���\r\�\�ϊ�90U\�\�\�ٚ��ǫ\�\�\�Nk\�D\n\�4*�\�y2S唯\�@	\�UN�\�\�9ƃ�y�\�+Z\0�I\�גm����}��! *Z3ᰅ�\�8u?�K_j��\�r]T�e�u�R%R\��\��\�2g\�[x�\�\�\�(�\�\�޹\�f�o\�\��:�\�\�\�e�ԯ;�_Tf~��\�װ�\0�+M.�#�r7�w2\\\�\�ς��\�#Tx](8P�\�]�Ec�\�~޲\�D��\�\�:\�޸��\�I\�+\'n_L?F�^\�Q�v����\�\�0�\�`�|U;��7����˔N\",(��(RW`�W��^/�T\�5�&��i!dbv��^9�\�6\�&\�\�͒t�^y�+Cu�b\���h ���\�N<��\�a:�\�?���y���#\�BU�hX\�mOB�\�&��\� X\�/#S%�\�\�\�ͅ��Z�8\��\�ޖsi�-ӜCS-6\�\�\�V؛\�u�Z�V�\�w�\�\�\\վ#,�nM\��Ģ*�lj\�۸�\�N\�H\�\�\�9�T�\�bӏ�\\uIe\�ʅ\�U�\�W]pKnO\�4)	�5yj�8��(�\'�l�;���@\\\�[����v��$\�EK\�C�\�\�Mf\�\n����޲R\�l��P�\�\�Hz�\"�O���?x�*=�4عU\"L`�\�\�ҫ»v�\�\�\�\"\Z��t�C\\\�\�S�}\� @0�!��-!\�\�\�W\�\�G� �,Q)\n�_$-B�G\�R�0�\�u��\�p~s\n:mH@\��w\��Hd�\��w\�\�q�)�ē2���q\�e\�\��\'�p�[�P\�;K.�y�\�%\�d�f�r\�dI\�\�{�\���F\��ؘ?hN�W\�\�\�A��,9�R` 5��\�\�k�4�=\��\ZHZ�K駲�t\�hFΣ�\�\\�K�if7\�.���\�u����7��;\��\�\0�\�H�rԱz�&\�\�\�P|v�\�|���4���*�̕�\�d���q�\�\� ��O�\�j@p:En<�y\�4�T\0f\\q>���Tz=\�|��\�\�\�\�\�[�\�{6����h�1�$�\r\��|o��\�Ǣ\�K6\n��~\n�\�zu��Q��>E?bWp��\�!o��\0y6f3:\�\�62\�\��g���l�\"	\�\rm(\�*{�\�\��x�w��\�z�� \�gD��=\�a�ź�h7^:\\�\�\�#0\�ݍPf\�\�K�~\�\��g}�f��\"\�\�Fa��ֱ_K�+|\�qA܈2�<�\�\��1\�4|z�C\��\'�)�az\�D\���Ϯ\�9\�g�vkx�bK�BrI�Q\�\�s�\�\Z�\'	O5\�SX��\�\����9o\'\�C\�`3e�,\�\�\�\�z\'m2V�LIh�[\�&^�d\�>kf<\���^\�Ge9�G���bk䢜٥YC]\�of3�,^�M\�ڋ7�����$�P�\�\\StY\�bY�\�\Z\�\�\r\�@�\�3\�\�	\�`R�1r;!��\�\�\�O%\�\�&}p�\"�!�\�\r\�\�ί\�W��\�ĳ\�\�@�m8V\�\�\�oR\"�\'c\�\�Dz�\09Y\�%�%�\�DF�{�w�\�@C\�4C\�K�R$��Y28\�~\�\�\�ѯ�b�x�\"6�oZ�\���`��w\���7�i\n�xd59�\�p�\�&&*f׳mt��c\�\�>����{ڢ\��_��,QIo7r�Ki]J(^�\�4n��X�D�\�9N��!\�����	\�aO+\�X�-?\�!�~�{�\�\�\�\�P#��\� &�P_\�n��Z��F�J3raP\�\�\�\�Up#:6�^�Q�\rĒ�\�4����\�\�=��\�%	�gX�?y��e=M*�n4��\�R�\��k�\�݄Bu\�\�mg\�0\�0L\�U��\�*��L�^Щy*���%\��\���e<̼+��}D\�J��SVu��|�\�,ttC\�$Sik�u\'\�q�dGڇ\���v!\"3_�\n}��\�J,\�CM5��|\�&�/�\�\�&䡭�\�I\�>kr\�q�\�TA:yi�\Z�gMm\�?\�l�Dr\�j\�\���Ռ\�!��\�$\�>u\�a�	O\�\��<\r�LDƂ� Qz�v�\�)X��Ж;\�ң\0���\�.Z�o�\�J\�\�3\�E\�oQЙc[X�d-�A�\�\��䁣��$��L�(Xۣ�Ջ\�*\�(\�c�NT�\'\0\�;\�!6�`�\\R�\�\\��\�L-��Ϥ�MV�\�#�O�XqR\�MC7\�W5~�3Ap_\'E�\�\�N{�Tx\�A!E\�ƴr�>\'zd\�D\�	w!4g\�a9�A�\�fW�_\��hQ���Nwێ*8v?�$3;�\�qf1ܤ\��q\�\�\�\ZY�,!���A6�\�>\�j��bD\�\�m���Z&�Ԟh�\�G\�â\�\r\�=�}i\�\�#\���\����bp\�;�\�\�dFKX�?�z4�O.J\�\�\�-�\�\�T���ΡEM2@��45OP\�\�\'\�\�ۛ-\Z\�:f\���Fy���x�\�0sX\�\�\�u3�\�\�\�ecp��\�-�\�>x��;܊�(��t9n�豙��&\'�XF\����t�s݉��\��x��RT\�\0�w�\�&3��jL&\�y\��b!ȣ\0H\�V�:�\�\nT��}\�\�,R\'\���	@N]�z\�\"YB�j	׻\�\�\�|**�n\�YR<\�qE�\�ށh\���\Z\"0l\��\�T�C)r�*}��砭��\�ko8����2�%\�\���\�Mf;\���;�j\���٢��ւ\�Z�[\�,ns�\�/i��E\0;\�G�\�H�\ZZ��u�f\�1�\�\�\�vL;�U\���\�I��O�\�\�\�e�F̮��3K\�g+Q\�s�Y\�\�\�1�\�w�x�\���w\�\�F\0uH��v�\"�8�\�+ѯ}\�\����\�a�Dm^\���Ny\�\�O���4�m5\�r$t\�z��\�uU��e�#K\�_:�f?\0kf\�߹�\r��<6\�2�Q�\"2#\���}d��7\nSv�\�\�\�!�\�ַ���ġi�LZ�䵂^dg~�js�p�\�v\�\�j\�a\�.2sW>�H�	��\� r�\�\Z.�{hq�b\�ph�\��R�jH��J\����01a��`7��w\\ɗ���rȿP�3\�ds\�\�3ȿ\"#_ݏ��\�?c�^8���r\�\���\�%;\�|\�J�c\�\�5\�\�]\�|\�����\�\�)R�\��\���\�}�b\�^7�l��KǤ-\���\�{�~l��VQ�;�4I3\�\�\\\�)�C\�\�@U#&\�\�jϔ]��\�E�\�R�P\0��ۥ��L	9��k�\�\�\�}Y���{�9[\�J�\�]\�i���\�\��j�\r�3T\�`�Q_\��\���\�z\�~���\�RV,W\�o?�\�{\�,\�)\�5\�_U~�\�(\�M\�R:�\�\'-\�鼜E�0\�(B\�\Z�=�\�-oqio*�DHH��۱<�6@��AR\�S�v�Jyks��=��>��!��P�u\�D��?c\��2\�ͅ\���+\�E`z\n\�_؋\�tU\�`�o�\�}u�\\i����h��>�\��@�!N\�(�\�&\�;ME�\�N`�\'�\�ju�\�\�P�\�<���b�S�6Av@J\�`KY伯\�pX\�C\�\'Y�y�N\����\�:V\�n�\�\��kz&\�a��Bi�e]cV@�r\�`U�t6N�\��;\�\���z�\�\��\�f�uH\�ֿ�\rI��j{�I�l@�h�����6\�3\�6�˨\���w��y\r4���|~\�\ZV^���$T$\0�Jr \�h��mn^_��n�d��5�kFP#b\�\�\�\�^\�\n�\�Qn��}��\�,e]2_\�S������lՈ����|V�k._�Ǘ4v31Ӷ5\�Y\"U/�����\�[���\�\0e�\r��\�\�/˿��)�\�\�\�`i&�x\�\���L�\��K�Pc^�\��=�fr\�JP\�9Z\��L/)xl��\�\�\�$d�L\�0\�B\�\��0\�U\������o�j\�!bq\���цm`7�\0f䷸L8��֌f\�J33;o\�\�A\��	t2 �!\\jT���\�<z\�\0o&�?��\��Bxf�y�k\0��}�o��]\�W\�U���g��Q:E\r% mx�-3j\�\0�\�\'\�Q�\�t�)\�\r8P\�A���\�gF�\�\\,\�\�\�\�L;\��̸��=@\�\�R�ԣ&V6s\��l�h�ߴ\��޴��\"8��h9�b	\\B4@s\�\�3\�[!B��\�ls>�nA\��6�Ŷ�劚%�ၩ��\�kA�v\�Xe\�\�N\�H�s�ܘHq}K�1���fiBx7�Hwt\�q\�t\�ݏ?ze4�ݏ&++*�rR\�b9(}O1���5\��p\�駴����>\'���\�\�\�l�z\�\�\�\�x�\�O	�U\�\�4H���\�N]�\�-</[�xCj\��\�82\�\�l�\�~�R(���\�[\�\�\��;\�\r�9tf9i���\�@�қ?F��\���TE�O@\���R��\�� ��\�w�y\�\�\�ӊ�shG�W6J�54t=)\�M}�w�iG\�\�\�\�\�\�Ps\n��`ԩcq�j@c�ک\�Q��\�?�f��	l\��jg�zf=�\�\�$&s\�\�MBh\�\�1?هr�\�*J��U\�F\�.2*\'2�\�\�\�\�Z�.ߞ�i\�\�b](d?\�\�^\�\��\���8kl�q�ݲϯ\�\�.q\�8JV��,��b\�\�Er<V\�s�J��gEǗ\�ۍ\�0\�E\�6�\n0�\�\n\�\�@\�wz�BP�F�h\�S5$�}\�\��e=kq<8P\�?\�g�xkH])(�!\�\�\�\�\�z�\�	*\�eU\�\�+�Z,\�/�z\�1\�\Za�\�\�[	i\�\�c\��s\�Zlw\�Te�\�ի�{\�\ng\�_$�\�\"I\�y\0�\�\�\�yԲq�\�\"\�8\�h�\�k\�5S�s�?-\�Du�;O\�_�y۱B�ι�A��_6&�\�]\�\�Q5\Z�H\�>\�ږ\�CK_��\�\�)s��W�Ώ�_^��v\r�x[\�N`���\'Q�B0,\��`xx�\"\�5\�+��\�U�\�+I�\�\�8�T���P(�9ȅli�\�m�}��\��\�ڔ\�=5�o7\0J�њ\�\Z\�54�,R1\�4>�\�\���\�\�%�\0I���!\�B�rMv,.ٗs�l�v�\�\�\"\�z\�R}M�j���d7>�y\�d.\�\��<���yR\�G\�=�#�s�R|l`�7\�\����N\�@\�_ƪ/n����*R;v�\��ބ͠�\�W�I#%\�j�>\��%\�8\�J��\��@\�\�Vw\\�ܦG�\�H\�f�\\���Ȳ8H�\�\�N\�8\�\�U��\�p\�\�˸��`r\�\"l�i\�\�ԝ%Z�G\Z\�N\��~\�4s��إ�\\\�n@p�\'�SSM\�r\�i\�)c���}\n�Gc\�U�)�\�I`\�\���\�R4\�˨\�n\�\�\��e\�K��T�!�%\��}&\�HĎ;�B݊\�*eq졻!o�O\�ԩ\�\�t(aF�\'+?j8\�6�\�cЍ\��]]]��y\�\��&\�Ƌ\�dذkjs� V�-U,��[��\�e8�Lهr��\�\�\�~���B�{#�O|\�\�MH!0��\�_Z\'A_���\�\�9�Vn3\�\�*]DqѾ\�\�\�\���9�H\rO$�I#�/�H���AJ�x���f��6d%4%\�9�$�yo\\\�y\�\�ڑ9g9�\�\�!\��$�.\��S�\�\�d\�\�O,-\�I���hǠ\�Srt=�9\�\�B\\iw#y��2�E�J\�xK�{rV��\�\�\�?��\�NA2*l�]	KU`5\�Rq�5U��z�\�.\�\rMN\�	\�\�\�8��3�(B@�\�f~Y\�\�k�GڡнՐMe�\"\�b\�\�c\�U^:)�;\�J2�[�\�iI��̡�\��5�\�n�\�ȁ�;7-\'\�\�\�\�Z�\�Kms���щO��\�մ\�xF��E�\�]��?\�Ж�_\�\�s!�/����h\�v�Yj=P�ӅI�2�3M�G\r\�\�5\�d\�\�^5\�;��e\�*�7��N���:���v\�l@�\�\\\�)\�a\�\�\�9Y7��nY3/��v7)S+6E��\ZV�\�f\�d+\��\�0�E��w�\�\�w�tAy�M��\�ª0�\�Kf��\�s\�MՈ���h�Kq(\�d|C�\�\"�\�\�as \�$ߌ�\�xx��x\�s� SO��Cڕ\�\nb�9\0c\�\��T�\�\�s�fzr�5\�o�\�U\�0\�e\rh�B<�ae�\�\0]L\�\�҃\���7-��k�\�áAkC�\��z\�	Jt�,7�Ba\0\�k�S�M\�2|\�7\�I���\�#��\n\�D�JPO�9樦f�� \'\�̎���O��m����\�\�\�1?g\�\�&\�;��\�>?2��\�*�\Zz�g\r/�*\�\�U\�H\�\�;��+\��X\�7�\�1\�7T�Js\�;\�\�\�ɾ�][S[#L\�2J��4D\�\�\�=�\�R�\�\�AH\�J,�.]G\���\�q��I��\�˼�X�J\Z��\�\ZJ� ��kS\�!rj\�EYx���7th�mB���\0Y��\�ϡo}�4���X\�)\�\nS�c�\Z�,��`=\�t�\�6yQ�[b:\�5݅֜��<��b�5P\�?\�-w�dL)�=����S�\�0�\0{j\�\�\�\�\����wF]4\��\�\�\���u�o_:\�\�x�\'�\�c\�<�\"T	┫\'ͯ\�\�;:*���!Z헎�I\�\�{\�\�Gu#e$�i(�q8�\Z��\�\�\Zs��\�{w5�)1\\|Υ�\�\�~Pxv\�\�\�kM�\�PPED\'éE�.\n,�\��Ǔ\�\".D\�<��\�4\�\'\�\�Y�\�8Ҵ\�Wz\�c��\�V2x�>�L��J\�b�䙟\\��1\�2.i.�R`}�YDe\�U]��Wm\r�I��\�u�b\�\�x��+\ZO1	\�0��?\�\�:5��J�jr�\�m6\�m\"&\ZD\�\�.\�&\�7�\�2���\�\�t1��t]Se�a�K�qc\\M�\�i\�(\�\�2�D\�1�\��%\�\�OH�����\�\�%kE��sϫȅd��s��e��+\�}}G�Β��v9(�9C��\�@\�tR�l�+Kݢa8YK�@;�\�}�N\�P_\��\�C�\�$d9{��rl0\�8\�)<8P%�]\�\'$\�G\�ޜ-�H���E��r\�\�t\�����,���ix�uf�\�9QJ�y3\�\�Z]�pY\�\�HZ0��^���\�|7Ql�\\\�$\�qA/�e�����\�n\�\�\�\�[:\�K[˅J\'\�\�}�\�\�=y\�9�$h�\�\�z\�l}fA�jP\�a\��\�\�+4��mYq��\�1Z�(\�\���?\�@�d޼\�OC�\�Y��\n�;s �&�\�}\�\�\�T-t\�\��\�|�HAۃ�\�G1h\�\��DN\� �6�\�f��\�d\�;t\�ű;4[\��\�٨\�\�o)�2\�*\�ɘs�]����zr\��O�I1��\�\�<`\'\�Qij!�\��j��\�Gi\�=\��\�-ޜ@��I�>D���2r\�ͳS�C�G\�-h�gW \�\�]\����_�9�8>_�R\�Q�J}.�I�C\�w��σ�q�S�A	tv�\�tę,\�t\�7\�$J\�\'�\�\�\�\�mW\�\�\�\�׶\���t��\�lZ����VUM�\�\���Dc<\�\�#R\�#Q �T�@�c\���S\�z*\�M-b�\\&2\�7��F�\�\�a��%�\�\r6φ�O\�n)��2ڈ�!h%\'2��4W\\tNyb�ZI%\�\�LT\�\�^	o�[\�g���	�^�M�i\�H��\�\�FU4\�(�2\��\�c&f\�1�\�N^���w`�\�~\r�d\�	u.;�M\�ڡ\nn�\�*��\�W\�;\���i]��pw��Zd�\�	��\�VQ�\�\�irh\�\�M\�v\�9>$>H\��ֆ�\�\���\�9��U�Ru8\r/㈼\�bn���Y\�h#jA�&+=��%���v�3w\�Bf1\�\�\n\riR\��*�\�P����\�\�,�]\0$o;&�\�\��\�Wc\��9�\���(R\�ֻ�?�!\�\Z?I�\���\�}�\�\�\�\�\�U\�_�a�P�!�\�HԔ`��\Z׼�ͨ7��T�\�\�)�\"��\�\�S&i  �D\�\�\r��H_+�\�f�!E8\�1��G���vݣ@<{�W\�M\�	\�ҹp\�Oa�z��)rU\�\���<]	;H�\�=ͻ�\�2 \r\�£�n�i�٪�ڶ��\'9st�D[|	(���x��\����R\�M]\�v�\���;��1�اO\�\�r\�\�\�1\�\�b\��\�+B�O�Z�=�&}{\�K��G -\�������\�?\�y��q/\�C�\�\�\��7�W\�{\�`.�\�\�\�P�\�\�\�\�\�\�\"j�?��\�$�i���\��\�gzj��\�p��+\'j�\\��\���+��SճD2`\�ex앷z�FKR5\�\�l8-B��G\�\��wu\07�Cj\ZT\n�z�O\�g\�޺B��\��\�dM�3\�ɻ�\�\�v\�&f\n\�\�\�T\��\�QRm\���O��|�4ŊV�R����j:\�B�4\�\�\�\�l\�X&\��\�/|\���D��K�\�Q�\�[)|Ui\�Dq\'ǧ$���ûf�i\�i\0\Z8Ǟ�ch��\�\���\�\�V*w\�\�0L3�CX\'\�/�AS!��oDZw���\��\�\�4<ɒ�v\�\�Q\�>;�4B/��\�\Z\���3u\�ӈ,_\�B�V$V-\�{\�\\��9\�Qg���\��Tİ~\�@ԪT4\�C\�i\\\����0Lh�\�7�r:\�\r%\�3ĩ!\�\�\�`�{8\�G�\�\��|N\�\�4�N\� ��Q��tI_k�6.2��\�\�ձ�%�&8�C4��\�A\�mW���!\�\��\�Ŀ�]M\n\�\�Y\�۟\0_e+v\�x\�KxT\\�5u\�\\�\�C>\�Ά\'\�\�+w|�f=ܛ\�sD�T\0:��\Z�h\�<\�g���\��\��B$��*�e\"]agȫL\�\�F���\�U \�^\�\�(1�m\�\�\��\�E�\�}D\�\�c8\0T\����u���gD\�g-�yM\�3��i�-\���xZo��X\�\�\�\�{HXA;X\�f�n�\�:�#f���iރh�4�=\�\�1�����G\�\�\�,��,��^\�{\��>MXe&\�m��\�\�}\�D�rA*	�k�>H�=&k�\��\�a]\�\�\�p\�TF\�qW�\�1X)�P`=\�\����\�\�ҭ\�a�\�\�:8u5��\�[n*���\�9���i\�v�N\�\��d���� ׎YƼ^#\�)o\�ʔ;ΧeO��b\�\�NUҺ\�7�\�dn\')�M\�w�!\�Z���5bW�K�T��^�\�}\���\�VK_{I�K�\�\�3���?�F)\rcOI�dGVY\�)\�-\"�ʎ�;%z>}Ћ��\�v\�p\�%�\��x�M\�^���KJͥ�\�l\�h�X\�\�m���\�~\\,��BF�Fᮌx\�(6ɼQ\��s��\�\�*�U��&ͅyq\�ZQ\�X)��1��\0��OM���\�A0c\�����ѻڨ\�\�$D\n����\�C\�=|\��\�\�\�Q\�V��ܕ�\�\�2̵X\�Ǳ�\�9���\��VZ�\�t{n\�Ĕg\���\�\�gO�	r\�5xO~\'�\�:\�\�Ůߵ\�\�Ưł�dM,v�� \����xSSK\�{�<TBG��!�ǎ�\�\�\0\�O��\�9�\��k%+FD�\���@\�J�pU��J��\�Ft\�AHO��\�^\�DEcxl�����ou\�vj c\�Y\���ь��\�nP\�&��74\�!�-ỠǗNE�\�:;\�~�.+⿦�!\"jF�p\�\";xzK�wUi�*\�\�+�\�)\�\�\�\�\�\'��`� >\�\�b)���\0���]\�K\�\�\ry��\�\�\�9[�[\�z�`�z�:�G\�h\�		�\����\�\�]���>��cc�|\�_>D�t\�khs+\�\�\�~��\�\�\�\nc�R*\�[R޾��\���а�\nE()��N\�A\�s�\�gN�}\�\�{\�\�N�����J>��\�G�q�^�@\�f�F\�Em\�\�&��\�ߡ�\�\�\n�n\�X(P\�vY\�\�\�^ܟ�u�ݹi�#(\�\�I��g���j\��o�\��t	�}3�\�D<oo\'\"Y\�\�FӐ\�,\�\�V\�R�#\nAo\�Qp\"	[!\��u\�\� X�\�c^��\�\0��\�,c?\�Iܿ\�@�d+r��\r\�P\�?U��sm��G-D��\'Aw}.\Z\����HP%H..w\�8�l\�\��p\�C\�u�\0�,\���\�\�\�\�\�\�(RT�ں^\�WJ\��NP��#\�\�BT\�6\�\r\�Z�����\r\�yof�M_u\�hb�EZ��S\'\�P���\��6\�\�P\�ĥ\�`�\�\��GxB�\�Ng\�� }T\�]\�\0\"��K/\�~\��މ�`�\�p\�ŎN΄\�r��\�;�ߛWh涗\�,c\�ڨ׌i=�\�\�T��\�\�\Z\�\�\�~�1,R�b�7bMBIK\�\�\Z�S�\���@$\�\�\�\�\�\�)\�;�\��Q�|R\�g@A�_U�\\�ᱜRo�\�Q��\��\�!\�#}\�%J1��+�\�Q�\�\�\�Q\�Ԩ��?�z���~�\Z�ڽ�1(�6\�@X��\�2V\�\�\�D`\�\�2l\\�\�\�$\�$�\�~!:?��(9)\�\�f,64�\�S,J�?\'\\\\�\�\�c9]��es\�(l�N�-�ǰ\�\r\���\�������i\�\�@k\�lV*\�I�aN�O���u\0\�[\�o~5u$P�\�ʱe\n��O�\�m\�F{\�ݵ4S\�M\�3\�ҕ\�\�\�\�c\�h\Z\�0^Ģgqz� g��Y41��Ws�1\�\�\�:y�\�\�5\�	b������\'=F��7@[l=\�8[�ʷ��\�F�Y����Y|y�\�D�I!*dV?Ÿ��e��\�M!P��\�)\���\�m\�\�3#u�\Z, Q\��.d�\�\"(d� \�\�\�\�*p?\�\��\�SW�\Z�\�\�\�U�B\n\�\�\'�Us�󜖅Qwz���\�%\�\�\�e\�\�|C!do�h[\�Rr�s�\�\�\�\�q\�w,z6B\�\��\�\�~���LeLS]�˂?y\�Y\��Hy2�[XQ�\�|�M��9S\�&\���S!M�����$\�)q��Y]���l`̺A��\�}.\�,L���\�Jh��g94�\�\�;W;\�\�P\�\�\�\�x��34\�\�\���\ZlR;�©N0\�V\�\�):�)of��!qtt\�,Msq]�$?��,&\�TGapbkA����C�b��\�\�>\�w����\�f\�\��]��\�T\��\�e\�\�H	\�և(\�<�\�\��,\�\�\�\�\�\�ve\�pʚ\0V\�G\�\�\�1\� [\�jz�K\�i�CRu|\06�\�D\�C\�\�O��g\�\�yݯ\�~ξy/��כ\�N*6`�F\���]q�Y~\��E\��/�Vb|.+P��\�a_4ST�On�75�d@\�+�]t3�\�\�E�\�0K\�i�\0��\�\0@�*\�X��N\�\�m�\����?YrD-g�\�1,%\�`dIڿ9\�\�[!aC��ȏ_8�7�\�tW\�\�{V&1�(Y	UyH\�Ԑ���Z$�\�y7�nh�Pb�l���[$!\�3�xz\�\�\�r\�-\�\0\�r �§qg���Gk�G1v\�;VQ�RM\��\0@���z�3l��\�(\\P�;[�Iln�+f/��X\�\�7Q�W\�\�\���_�p{�f޹#\�˾�D\�C�\�q���\�ס(m�7cV�93\�\�\�fg�\�\�6]\��(\�X��\�\��O.�C1\�D\�\�\�@pL�\�\�%�\�*\�&E�3\"�j\�>ň\�y�B\�XEj\�>ٞ�k�n\�\�~��\�3{;4k�\�zN\�\Zo�T\�\�o�\�[g��(\�\�]�2I\�\�}\�Dz\�+\�<[�K^�\r�\�\��>9T\�\�\�\�\�\�\�p\n\\J\�\�\Z\�T`��\�8�Z�\�\���$��uyL��2�����6�)\\H\�\�]6��~5�\�\�L$�eU�d-��aы���\�\Z���?\�\���\��\�;�s5c�\��ބ\��b\�@\�\�PȆ-J\�l\�\�9N,\�\�;�o4\�Q�m�)>*��\��V\��\�Alr���\�\�!\�9�f��xf|jW�=:�.=�\�h�<�L\'�s�\�\�8?\\F\'�d�KK*#B��\�\�\�-\��Qh�~2hlr���i\�7(R+\0�h�]\�wx�\0_8��*~Z��\�7-C�\�u\� �t*\�\n\�\�f�a\�εkO5Е�)\�,š�����u^ʗ�,d~ȳ5��\�\�T��\�\�T�>�/we�\�G�\�\�A\�y1\0���\�\�\0֋Z����=\�x\�V�\�\�G#\�ɶ�\��\�e�\�\�\�Q���?a\�THՐA\nV@>���b\�\�b\�~S\�\n\��Rz\�o\�c\�ѽXV\�G\�\�(�`o�7���\Z�2 E�\'�hR\�e2\�\�\�%\�\�\�7Nb��\�I\�+9\�1*u���9h\ZR_=\�F/$\�4>w\�U\�2�c{k�\��\�Q\�\Z\���0\"�\��\�\0ٸ\�\"Qx���z�b\�\�\�\�jT��������W>T3�53[\��\0|��.�t\�4�(-�(3b\�\�%3��\�󶱝��E�ae�#ou(g�Q\���[T=�\Z\�݄���\������OX6�@S�-\��\'yH\�ڏ�\�b\�\�\�����\�y	�!�B\�~\�\�\�7bΓ�=*D�,B�@\�\��b\�d;x\�/\�=��!wlc�qN(#[���\�Z\�֏Q\���8d�x��\�ؔ=�%:a1h�\�-{j��k\�W]�\�\\�R:\�̃\�r9^k�WY\�\�\����z(/��_^P0��\'d8\�w]\�\�kk�Sb�N�\'\�\�1e\�i+\��\\�,\�\�U$\�\�90g:��T\�;�r\� K�\�/1<�x>�ֺ��,@R��hU\�[�Ń\�Cͽ�\r Y^>}L6�,5\�js|Ϙ�p�1d���\�-/9c�s��\�n\�\��~恙��~\��\�_wu\�-V�2�F�\�-\n#�B\�\�$\�G12r�2\"\�:z\�и`��\�4�\�G�8�\�T\���Q�m��*\�e\�\�\�ܺ 1\nmLLF��<JSa㩩}Y��Ж\�B#5��vs\�\�\�?�|�\�\�\�?,,)�\Zf\�m\�\�3�w3�,���$5T�\�\�\�\�a��\�\�\�$q�\�r��6M\r\�h\�(R�-��y�t\�ɖ\�8\�]��\��������ڨ\�\Z�B�d�$69w>Ս�a\�|�\�\�P�\"d\��KKe\�G׫H\�36b\�ٯ(c8\�{#LsP3Y\��N�a]�ѵ�l[\0i\�\��a��&\��˨n\�\Z\�`4%Z\"֝0����-zj,\�\�p,YB\��U/��:^��\�\�N��\��Q��\���]�1�\�\�{Z#\�\�\�\Zi�h�\�i���1%N�x\"\�\�\�\�\�\"�BI�H!e\�\�\�_�O\'�\�:v\�`A1���\�7�\�\�\\\�L~\�iw\�\�c9\�a9\�.\�^�\�Ynӈ�zi=\�\�\�l\��IW\0}\�f\'�\�\"_\�\�nK)%��\�KGJ\�цK\�@ܝy\�j6?�\�i�\0\�]���l�	\�\�r�o\�9]�0Q,Uߺ\�m�_\��\r�\�\�\��\'���\�a@\�ع�\�bC�\�3p-��҇mUMp�$\�E�埜�\�Jl\0z\0��n\r\�x���1\Z-\�\�V��I8\�{�N\��m�\�1@\�g\�{y+��g%\r��\� \�ͪj׎�a-\�\�\�:\0/\�<��\�\�\�<�Z�p:BʳJ��ы��\�\�\��y�Djތ\�\��T��<\\��ĮX�\�o\� ��5�,�:2�E�N��\�\�P`��*\�{Xd�D��\�CL\�06�\��\�jx<\�SQ\�\��\�\�-C~�rz�\�\�\�\�%H��ٛ\�Z�ml\�\�\�\�\�o��\�>\�\�\�\�\�x^Hb=2�U_\�\�Q\��ӏ~}v5\"	f}s$a\n\�\�+�\Zp�4��)\�u\�\r�\�=�\ruyiL����x�A�t�\�\�\��N�\������|.ѵ��g�\�D�Mݾ�\�T�\�,i\�Z\��>��S6�X�*���\�޿�)\�\�G�~��-�|rՋ+q�\�8��\�9uUe�df��\�U��gk\�2(\�Y\�E�93�=�W#-\�y^5�M�d�-�j��I��\�3#\�TW\�\�� \�\�\�Fp\�O\�y}���\�\�C�\�\�\�:�4Q�$}(^\�\�\\{\�\��Jw8\��\�\�UTZ1P�\�\�\'�\�!\�u\�\�AG��#\"Z��\�{\�ve>_z\�\�vU\�%u<\�1h\�=�H�y!��9t:;qL}#\�|K\'�{�s\�\�\�u4\�Cď\nLBBn\�#\�a@?g\�5#\��\�\�h��\�\�~ڱ%�E&C���}-� \n�-�\�u�0�\�p8�.�#\\\�s������\�HQP/xuǡ�5�\�\�{��\�\�壨��\�.�%�d?�\�Ub�O�\�\�5C\�\�7�<��̙}�\�yj�k�{`!\�摊¤vE�\�\�0�b�9\��[����\�6�`u�6Q�(L7�}i��\�8�kJ�o�\�\nr\�\rt\�``�\�@{\�ѧā;�\Z��ѯR{\��q�{]�X��h\�H+}b\�\�\�茬�7�/	�h7��Le=\�\�\�\�>� \�\����BrB�\�pl��\�\�\�j\�\�%Z$\�7�\�/Y�1Tv�\n\�Y\�ۧl�\�F\�LmR�\\E�ʧ\n^S�%#\�\�)\'R���k7i�Z$\�\�\�K%k\�c=*@�E\�P.���PHQټ4�\�kÉA:����[\�j\�\�i:Α\�Dԋ(,��3ղ����s0�\�?\�D�\"\n\�~!]�\�NP\�<�\�}ْS\�YK\�\�d\�2\��\n\�\��N@���\�.\�@�����\�N��:�Q\�\�\�\�\�\�TI\ZυE�)h\�A�4\0U\�.Ӻ\��\�\�\�<\���=\�(]~�2�t\�9 \�*�\�hԮ\�o��Fw����Aݳ|�i����\�3t&o8\�4\�\�\'\�\'G��q#��\�#��	#KsX�\��\�-\�R�C\�{h\"\�\��\�0NP��\��a\�\�=�b��\�_�,@>\�R8����|>��\�A���&�\�\�AP�����C\\\\\r\�Z\�\�iYu)>\\R]Y\�g{�o���(Q�Et8��\nU\�!͗�\�Vd�|X\�\�a�\'o�C-\'/�\�Ug\'w,�\�\�Q*���\�L��5�T	kf}\�P!,\Z�\����\��b��\�l�a�W�9\�Ɯ�\�H\�\�Q�=Ik\�9V\�\�Y�\0w{\�9dJ0T�.\��\n�E\�\�/e��I/#e\�\�T\��\�\�*�\�u\�q�vՉK\�\Z�\�is�\�_\Z\"�F҃�&\�3���0�\�IK~\�qo[̄u\�3\�ޢD�\�s.�v\�4\�̺\��j�\�8y\�%GV��f]\�\�#\��\�Q� \� \�\�y��\0\�ͅk\\hW���߉�\�k���C&6\�\�!�\02+\�wnn}\�a�[\�3\�\�e�6��\�}=[e\�\�\����0\�y5�hћ\�\Z\�fr����I%`XOX��c�\�\�`\�3�d�0�\���nO�O\�\"dȘ���ޏ\�s�w\\6\�1\�r�f8\�@˨U\�e(^<�}\�\�t�*A��\�\�bK\�ݓ2،�gY&�\�t\�g\�\�\"\Z|x!L۸���q�J����\��JL\�r�8~\�\\]�e\�N��#�\�\�;\n\�\�L�xf)�R���ݺ3M��Jq(�X\�\�O>C\�ov34\��_9lN=y�\��2\�_4OSQ�sq��e�J\�\�\�\�$�e\�VL�,1)�\�&�7�\�O?�U`���C�уbt�T��э\�\���8QAb�m\"|��!l|�B%Z\�\�\�.�\�Qͽ�\�\�9c\��{@�\�\�\�Aw�P\�>(�;f+nC\�?�\�t��.��\�\�^8�\�&\�\�y��\\\�\�\�?���\�\�n��O]۲��(ȍ>�\�%CVwmX9_7�U���L	mK����\�\�l�Mq\���۴=��i�E��7\r�ݿ\�\�6\�!+ �I\�\\aV2ѽ>\�D�u�`^�p�ٕ\��e��*q��w ϸ\�r\�\���&\�\�[\�\�D�M.�\�+\�\"Z?9�<W�\�\�\�9\n@YX\��\�0\�\�G�\���@�cb��\� _P����H�\���P/��?טh���M P��㟲^��Kd\�\�޷M�\�\�#�S\�҆6\'\�:@\0�%{\�\��ٹ\�eok�z\�;\�{�WDq�����?�\�\�\�j�Qڧ\�\�N1p<\�VC?��J��Ͷ��\�3�<��\�\�\�iՀ&�yc\�\�\�]�Y~\�pU���\�\�:\�\ri3-���\�\n�\r\r\�\���\�^�v�;R�\�O\Z�\�4<yP\��!}eH\�l:�S��װħj\��\�O���,\�\��\�b[�\��U�\�e\�Z׹\�7>S�}�\�\rl3\�pR\�\�+n\�7|M#��Ы�����\�\�y�\�8e���\�\�s��RT^g\�\�z����^.��]*\�T�hA\�<c*\n\n\�>m\�ƚ;\'\�\�\�L�d\�<\�\� ��4\�\�2�2\'\�\�\�J6%R\�i\�b/p\�\��s\�A�l+��n.��E�)up\�-���Z\�yX�\�c�:7�]\�Z\�\�}�Y��\�ڛ9r\�LeN/�W,M\�zcS�$�R�ԣ\�k\�\�+\�Ѫ��\�H �s�\�\�6\�\Z\�7<�P�^E�8�\�J7\�:��P&h\�d�\�_�\�\�uv;t1��E�\�Xp,ڄ�Rچ��	���7�爱�52I��\�h\�zsy&\�?��O\�\�\�T�t\�tХ�;@JC$I\�{�,8\�^\�\����ߺd!ճ\�+\�劢�\�\"���\�\�\�e\�?\�k�9\�\�鿽��\\�\�ց	\�[-Κ�\�\�\�D�T�{�\�\�\�HΣز!\�PΊc� ]E��quGj2��\�N\0\�\�\���kV�7\�Gc�o�\�]�\�\�\�2GQ�#dJ��.�*\�ۡV\�~^����)nѓ\�\���.��}&�\�Yݔ3\�Wx)ƈ�\�p�\�?c\�\�ܧ\�.+\����{|(-5e\0\�\�m\����@�\�x\�\0Eo\�]\�DQ��J\�s�A\�\�EmK3}P^jՄ\Z>�%���\�8\�\�G��5\�x{*\�<s#��\��\��E�\�\"\� ��h|��\n\�\�h\�zȁ3\�?͕吽\�z�āԽ\��	Q��\�\�5��2�-^�\04u�\�:�𳡭ب��Ia\�ovT�\�.������)(#\'\\\�\�;\�\�\�\�\�:�s���N�%\�JYU^\�N�\�\�U\�e��&X\�]�h\�՟iڂ��\�8\��v\"\�\�*\�\�u���9$�\�=\�5:\�U8P�\�5���c�\�䛌��lzH�\�SZ��0C�6s�\�[��{\0�\�\�\r޻1wpu��ą\�\�\�\�\�.ɯ\�͵��$��\�\�\�Ck�\��4l\�\�\�難[�\n�\�E��\�|T\�\�\�C!\�\�e-���\�g\�᠄\�+\�us`\�\�gfUx��\�pa\�+��B�b�\�^h)-^rS\���s�)rTAҨ\�����\�U(ݽtnP�v\��!\Z\�\�T�=л*Ӊ\�ה[�}q��)8\�IF+���+���ݐ�\�8\�q\�i\�\�\�p��!p\�\�\�K�$cQ܍�i^��\�1��~�a��*\��\�8��`\�23�\�P�#�\n8̍\�2�[\�M\��\�\�y�\�\�\�Kȿh��D#�\�r\�u?6\�M�\�*<n\�\�0[%%_�\�х\�W\ZJ�\"�\�R0\�z\�\r�Q�9��%��7�;-(��O/�\�\�\���L\�\�L\�$\�#)��Q�F\�\�\�\��0@�Ads~ni�-�\��Eط�_=KZ\'\�yG\�P\�+��g\�OK�cBp;�6�\'�\��^އ\��T\�A�\�\�\�C���N\�:7\�}��aX\�\�M\�U��\�L\�\�\��BiX�-\�S\�\���C���B�wZ\n ^\�i\���[ܟZ��ߪ�\�:�\� �\� RE\�S\�\�\rfGx\�O�\nj\�ћgi�\�\�ϥÍ���ڟ���\��ؕ^-M\rˁ\�ʇ\�F4NNѝ[�*l�#�n4\�Oc/\�\�\�\�A\�1Jc\�/rY�\�I$\Z�\�\�!DR}OR��U���}e�\�\��KS�A�����5�LO#u\�!���9N�{sj씒\�\�\no�\'\�r8�$-<q�\�ы�0ڑ\�v�\�p�^\����Q��\�\�y���\�:�A��\�\r��SF�\�\n�\�-�\�Z�y\�<~�:AX\"q�	\�~��\�k?��&Y���!\�19jUex/%`*�r��\�8o\�5�ԕ��<r��\�\n(\�=\�%�8�\Ze\�\�>\�\"\�\�S��\� q��C\�\�T\�~�\�\�[��i\"�\�,\�rp\�\r�?0�\�i\��[�\�p<m\n\�\�9�N�\�k[}��N��\0	xP\�֩\reR\�<\�� p\�V=\�~�����O�z\���\�\�e\�:\n\��8��\�\�+��+^a��\0\�G@\��QtX\�\�hq�o�\�\�@㠐<� ����JR\�H\�`�5\�˙9\����bI�8�\Z\'\�\�]q\�%�jN\�\�d́v\�촱���Ol�\�\�4b\r���HD�I�/_*�u\�5�Z�J\"¶\�_�}{�4�\���\�L4\�X���GN/.\�d�\�Cc7���\��l\�B�\�\�Wj|�\�\��nE�;k\��\�\Z?.ߎ�\�2���bd�`�5d�\�A\�\�2I\�A*\�T{\�\�a\'\�\�\�d�8�\�\�K��)\�c\�q�|���L�֐�8�\�tr�\"�ۚ�uJ[Į\�W\��\��G�bH\�pN��2L@k������E��\�G�tH\�ao\�Z&mc\����pֻ\�W�6��N����du\"\�B\Z\0rt.\�?Ij\��m�:�����$\��6i��\�\�TI�D\'p��\�\�DVo_\��0\�tQ\�Zff�d\�բ\�H��H�e\'Cܗ��}���i��/�n}�\�:�\��&I\�!\���Ɂ>�0\rL�|:�\nr��\�/\0^��2ߧ\�\nr\'h/x\�\0{\��I��Q@�ڛ�d���x\�\�rj�0\�\�7�\�\�J\0���\��s\�׽�\�\�/58A\�<\�;Aѷ?�7\�Ad���\�s\�\�(o\�%\�Ne\�\�\�]ۭ\�Ⱥ�\�mr\����\�\�\�k�\��\�m\�=Ky\�\�tn=\�)��\�{Ə@�\�\�S9Aݏ�j\��\'T\�G�3�N�\�\�\�̨l\��V%\�*(�\�\�+\�)5�m>o�!\� \�hE�\���\�}��1zK�\�9R\��$\n\�|��rH\�\�\�p�5\�\�m��|J�su]NG\�]9�\�#�\�hyzŤK\�4/[\��%c\������S\�ʍ|J\�2ݢ\�\�4�\�\�\�M\�\\\�\�P�竔5�y/�\�F/g\��\�@�\�ЍXWzBv5<޵\�QP\��$M\n��I�l\�\�\�^\Z�0�1�ehH{\�)-j{ܰ(Hz\�y\�\���\�\�\�g\���\�	9~�y���Q\�\��\�^� BeF\��\n\�W0Am�WtƢ$��\�1�C#jX:<���\��Q\�_q\Zt[\�NV\�vϜYf��\�wz�ܖvT�z\�\�\�E�	��e�\�$y�>�\�\�\nV̓\��P\�+\�{N\�~�Eø��\�\�h\"̅k{֮\�GN\�>qTK}\�T�\�h߸\�7\'\�8�Z\�·:a�UQ����}\�H�L�\�3\�TG8\�gdY�pQPș\�\�\�w\\z�(\n\�ŕ�\�!_x�����+\�\�U�<\�\�\���8]\�\�M{b�v\�\n`\�\�a_�q\�\�]\�\��^��\�C��Ed���KP��g�\�A�	%�諎��\�\�\�{/�\�]}�\�M�\�\n\�/ت7\Z�і�\�\�Ћ;��#}T��\��Q$\�bMy@m\�\�*_\�9��Y�M���\�\��9���\�:�\�qlPr\�\���0�9�\�\�	�\�\�\0>/\�\�r��\�Kw�\�\�L�\�\�\�p\�>\"0Rҙ\Z\�\�\�j�:�}G�φm�\�?h	�\�\�h��׽����6k�2\��\�C���m�i\�啝\nCO\�Z��2+\�\�PbV��\�j=&K\�0\�b�\�\�eu|x�<���[ӷ\�گ\�3\�;N-&�\�k�M\�=\� qѽG�\Z2\��;\�\�T�\�\�M\�َ!<Q�\���(�rݘ\�\�j�>@\�D\'hMM�\�$\�\�O/\��v8x��\�k�\�ߢ\�\�\�K<�\�E\�����Y r\��\���q�=�+C/\�\�\�gO\�\��L-�h�\�ZRB\�\�\���\�k\�N\��\�-�5C4-BƉ�$��AXƁ*@�o\�!� Rv�\�^FN��[^\�꒺l\�&H*�H\�EfX�F\�B\�߽��x\�x�YTU�,�}��\�1Z�I0~�z�87�xL ܄B�D`�\�\�ZfG\�N\��S�\�s߻w\�c!l\�[3\�������J�\�#Ƭ�D�r�>\�G��U�\�\��\�{+�wx�\�N~\�\�\'�6I\\��0B\�\�M�V��i�>�\�$\�\��\�q\�\�{}D{\�\�\"�\�暨S(o{OBǋ�\'\�p\\�(R`@j��H�\�x�25\rֳ\�X�H��/���ܻЋ[�\�g�*f�\�(f*\�rX$�eҤ�k�\"\0b\"��7���\�j\�I݊\�\�\�RS\�\�9�{L�x#�\�\��\�m\�p��\0\�\�U\�N�\0�|	���[\r\�8\�A�f���\\�\�4.˘\�����\�)�\r\�YRA�\�\�>\�i\'\�py\��\�\�*�\�\�2OE�r\�\��<X6$\�̱\���Y\�\�$�z\�f\�\�\�Z�\\|.\�8�@_\\ATM\���=���\�\�:��C\�\�\�M	^���\�\�l�\�\�	�\�۔\�S�㙞<<tz�\�\�y����W\�\�\��:B\�q�A\�5\�8JE\�{�y�\�V\Z�t�\�\�g��C2N�u$\�#�ȥ��\�!V+\�\�\�\�K3�Tb\����O�?ıM-��O\�0�&\�WFfD,�\�Emi�\�\�=Yb(\��\�J.\'�� }w%f-\rR凉\�\�,��\�\�/삏���f\�Hj\�o\�#\�F�B\�F\��\�Y-:PWVL�B;i\�ϒ\��B|xlS�m��z3\��\�\�\�wsa?	�r��a�@Q.\\�Y\�wg\�\�Ɯ\�&q\�lR��\rc�`\�\�(+:fs=i�\�����\��5ɑS��`�����\�\�R��Q�\'��-�!h5Xǌ�ަ\r\�u\�\"in$o\�9,\nB\��_�G\\�B�(��y�~Xu\�fI�cԓ1۪�\�`\�\�\�P0\�uG�T/��\�|�\���y�K/\��:�ܒ~|\rO�h/�\�\�+v\��\�\��`K\� \�r\"zWޕ[1XcW�\�GBѩ\�(�\�Fs[\�l$\��W��\�StB\�[>�:����/��\��\�]AqNn��\�z�\�IMT�j�?��HZ�ɦ\�h\�K\�ǒ�\�h2��O\��CS\�+\�	.j���>\����I;�\�묀լ@\�gK�\���`?(����\�7�\n\�U|\"��5���HZHAݥ�焲u.U\�e\�X�u�\��s����\�mI�]��\�J<\�]�\�塂mXYI*�\�:\�����t�|-�\���)	e\r\Zt\�ӧ7C���\�y���e\���\�	\�$\����Q����\Z X\�\���\�ރ}\�m\Z4lC��i\\��j\�Wyo\�\�{g\�:\�pk�\�\�7����	3�J��\�U�G4\�r譊x��C��\'ɯ\"\�\�C\� Z� Q\�\Zl\�\�Yܫ�Ri��V�\n�\�\�pds�f\�\�\0�KE���\'\����\���΢\�b�\���e7�K2�`\�Ļ;�X\�͐㷵\�\�M\�e\�CEc\�@�\�9�^�faSj��fX���z\�\�\�\��5?L���\�/C���yHY�\"\�r$w�\�\�w��\'�ki�\�\�9{\�\�vE@T6�\���_\�2���T\�ֺ\�/W����K��q�\�z}\�\�8\� ��)U���6֛b\��\�\�}\�4���\�\�\�%v�e�\�eʺ�Q��\r�\�	�{eO.m\�\�\�\�\�)��S��zG\�G�`!W\"p����\n\�@ ,姌R\�.�j�q7��\\W0^\�\��]\�\0�|\��\�\�V��\�\�\�\Z`�ep\�e=n�\"ctV\�\�S!\�Lˎ;�H\��\"\��X�>�\�\�\�\n���\�B��\�8\�Odn�y%\�\�.ͥ�.=�[e\�^\���y\�&�;x��\�\�T8W0\�\�Լ嶞\0!��X�\�A\��\Z]-\�\��ntW�v����\�\�\�J:&w��\�W\�1�5\n]�m\�.\�\�\�Ta(\Z)+\�\0lѿ\�\�I�K��(\�0B3r_%Y\��}\Z�\�aI\�i\�\�\�~q�֠B##u&:\���l�\�CE\�NG/� �oIو�R�\��\�S\�\�U��5> �G\'<;_\��\�?F\�}\�\�!\�Ŷ��I��\�LW\�\�ԉ~gk�\�\�\��S�)l�V�\�\�/(r\�w\�g|{�Z��?j�}\��\�+\�\�\�Ζ�k��k?��\"߿oB����\��\"Dx\�b\�\��3�92�^�\�\�pc*��O\�\�V\�͵\��\�M\�c�[�!Dm��d[(\���|@i\�Jd���9\�p3\�\�\�\��\�Q��\�O\�\�-\�bf0\�\�x\\~\�K\�V�AVL\�\�06g\�6`Wֹ,Jê\�|͞*\�I\�[�M\�,���m\�\�9ȍ\�F\"D\�\\\�O9�}\�?%Y�\�\�G᧚�&j$p�\�(\n\�\�9�	\�j�Dc\�0E\�u)�\�\�\�f)\�\����`\Z\�t覃3C<šF\�@\�,�w�\�D\��BO~\�A\�^�.Ğ4?\�3�$\�\�h�\�\�\�\�\�J{w/\��phU�-�@�`j<�*\���\r;�ᵝ�\�)�Ƣ!\Z�E���E%!?\�=4q��\�>��\r\�\���\�.��\'\�1�\�\�\�X�\��;�\�;{\r\�\��\�s\�J\�1R�h\�\�\�\��\�r)���\Z\�0����;(�d�#>\�\�z���\��	�_0�\�և�\�w\�Aa߁��^3i��\�\�\�\�j�#2O\�h�J���\"�;{�S\Z\�W\�@h��c\�8[{m�s�\�\�Nu\�jեD$&ٞ�\�c)?L!\0��\�Xi\�\�:ŤD�\�\�9\�\�\�j�۠�\��\0EI\�3�\�c\�\�\�t���\�\�p��ٽ�\�!�\�VQ��Y\�1\�\��/d�&�a׬O\'4��B\�\���Q\�K\��\�lᾭf	�c\�uE�]��\�\�������7��}[i�z\�\�a�\ZG\�\�)3X�\�ޢ�c-��r\�yZ��ٯő̐r\�Xt&\�\"�͎\�\�j\�	 \�ڟ\�\Z\�.��\�\�x\�tpvmM�\�t���ٌ]����HeV_\�I\nzk #�)\�V��P\�^#u�9\�^��2�\�ȶ\�J\�\�\�땙IK\�U\�\�7\�h\\D�@\�E\�`���(\r�o䔇�:�\�\�\�\�w�\�\�P\rB���\�$�\���o�\�]P(9RWu\�\�\�?@63��t�&��P�y�oM̰�`=^\�,\�\�y\�G&\��rDHa(�@o\�\�\�D7\�_��7��\'^\�8^\�\\�\�z\��l�n\�9e\�\�>o\�ĉ�.�\�:Jg��\�<I�o�H\�.D_�\�x���`�\\�q~���08ȶh7T\�\�\�\���\'��\��\05\�:[\�\�\nm\�\\}�S\�\�9�C�{O��\�{4,^x=z\�Q/��\�N�d�3\�s�\�ǘ\�`<\�k\�\n�\�>\�WVc[4\�\�~\��\�ITp$8R\�\'\�5FlkA�ԨBy\�\�ADC#3;7E|E6�T�(ݗ\��\�)ر;\�\�&�\�Q��\�\�Ɣ�p�,�\�g\�\�;ښ���\�^ĩ;��Ov�$狆���ZpY�&�ӈ��ؗQ\�\�JQ؊\�\�\�˻�\�N�\�Xax �S�\��=/ovƛi\�\�\����\��\�;���\�\"m�m(\�~\��fz헎.əd�4sZ\�\�\�-\�,lQ�;\�\�b\���c����Lj\�b^��&\�cʩLq\�{\�+\�Tع\�bh\�\�0�\�e��G�_���B�\��Y%ff	\�6��L�PP��� =\�S4��B��\Zi��U�Y�\�fƳv��8?\�16fyQ=O�\�\�\��r^\�S\�$Q�{36�b\�3��\�;9\�;�F�\�>a*ʧ\�2*\�\�͍�\�.���O\�[Q\rR(��HK�Ԩ\��2׉�ֱ�zx����\�{�\����+\�p\�|��Z �.�U0\�+\��t\�\�S�a�\0���\'\�q���#/�}f�\�w�i�~\�R�se����\�8n&}d\�@k\��\�\�fQ�\�\�\���\�/���\�9Bn�A�6�\�D�E�TWeΔ���玳,\�Þǩ��;�h\n�r.�\�b\�\�tK!\�\�;Ȩ�FpT�.eX)�m�FQ_�\�%\�3��LB\�\�j�A\�y Ֆ\�\��@:\�&��[Y@]\�\�!\�<^��\�/f�6n5U�\�_+��^<b\�q\�ќv\�ܒyƬ\�\�ڣ:����1\�d��Si\'��s\�َ\�|F\�{�Ԟ%�\�QA\��E�\����j2��qǳ;rJ�\�ߊ�\�\�yѦ	�\�N����[6\�C\�a\�(�`\Z�\�Q�_6\�@�;\�̵�$8\�1\�\�\Z5!xgф�e����A\n\�\�U��++]�\�\�\��\�\�ɹ�y|>����\�\�  �\�G!8;e\���\�&][9��F3U�\�W�j�4	~\��\�KyUP\�\�F��q�\�.�3�m�K\�\�C?u\����FJ\�\�;�\�Ȁ\�\�\�\'�\�\�cF1�2Ϥ����I\�\�\�H{l���*�Q\��9�sn��Ǌ�\�\�\Z=D�F���KƦ�\�Z5˂�$�֏�&)\�\�,IK����a~Й��$��؉\0D:�#�>�\�S�2.�\�\�(2��\�&�^\�Qз&Y��G�%D\�\\\�=�+u\�(p\0�|\�\�`�\��&Ղ�{E�	��h�\��\�\�=D\'7(ѩu6��\�\��i\�R����10�0��$�\�;�>e7\n8\�۱\��&;]s�`jڛ9\��\�\���_�\���\��\�g���\�?�e�oz��2�H�\�\�J*q\�X���\�ƺ\�1;� iv��4�D\�!M�����k��ڶ�N\�x\�\�1{52�I�1����\�p]J�\�R\�\�r^\\[\�\�\�\r4O��\�R^%�\��^.�\�\0\�F\�C�~H�\"e6��\�\�j�\���\�\�)Q\'\�:Гэ*�*-���wSV�l	>��Z\�\�\�Q(aA���\�\��9\�\�A�\�;\�+�\�\�:\����N\�\�\�(ͻ\���@ݢ�\"\�8�Kw���v\�ѕ\�*�7\�%\'6��Νb\�R\�ۆJ\n��a\�;k\r\��)c\�z@ͅ�	\�b\�$Y&$�K؉�޸\�\"�/M��6�\�x\�W0\����\'Ij\�\��\�X\�)\�de\�\�c\�*b���Tԣ&\�zEm\�fЊ\�e�\�S\�>M�\�\r����\�g��f��\n�;um�ꈚ^P�.~��n}���b\�\�..\�:=G��*�\nŢ7�8j\�f\��\�\�\�ۖ.\�\0՚%\�±���Sٍ\Z�~�\�\�͗W�Vx\�\�\�l�F����\�\�!dAMޭ\�D\�3h�/\�\�d\�̗di$\�6\���\"�\�\�\�\�\�L㫂��	^�\�\�v1&-\��-\�{\�Y@�� \�*�>J�*\�\�!4�$��.b<v�\�\n\\\�|<\�\�PO��\����%�4�E\�2�&_ʺ\�\�繨J��]�\�\�\�\�b*\�|\��H!\\���״�\�\�\�6tJ_\��C\�=?ϑ2J�\�~\n��u(ٜO\�:Dg0\�0\�^h���\"�\�\�n�޳s\�Z,�짝B`�\�\�8G\�(�?�NGr\"\n�F��\��\�\�?�]t�j0��r�\�yq��>��\�Ռ�\�\��ƴ�?��\�쁎X\Z\�H-\�curB\�\�ҩm�\�\�Rh\�A�\�Gq\�}\�(C�\��l��;)x3\n��oޛ3u	�\���+.T�=߹�+\"�\��*\�z�݃\��mzG\�\�Ɛ�\�cK�R��_.\�J�\�vQ�\�.��\�\�\�e\Z\�(,i4�\�>;T�\��r\�󇚱�x\0�DK�rI\�:xCW\Z�\�P�k\�\�\�Wi}jќٖ/Xe\�\�x+c\"}�c�%a�I@\\Z���\�\�q\�\ZG?k#1a\�.a�\"\�>J̷�9��<\�!C�D	\�\'\�̌\�j\�hFN�$�bt~>\�$\�\�n�e.\�z]��w\�4/\���)z���\�pJ\�\�\�Qhښ\�h%\�\�\��\r�\�,K�?�轞4��ٸ�@*\�b\�C������0f�4\�d\'\�\n\�n�\�ӽQ��\Zl\�\Z\�4E@<uw�<���g\�zܳ+6\���\0�\�\�\�\�\\9}\�	vE�$� \�V��\�i\� CۍXV���\��\�Q4�f\�\n\�\�*\n �Y\��]�Y\\�\�3�\�{�F\0K\�\\fy~�\�1r�\�̜ n�rY��U-\�\�e\�\�\�\���M\�~Z\�\'C\�\�5\'�J9d\��\�n={$\Zöb�g\�b\�\�̃Ys�v?�H\�p@d�Ovó���\�\�\r\�\���f�q�xH9�]ط=�Rtڅp\Z\�*�\�\��s\"b�O\�b\\MO�\�ղ(�A6���1(M�\�{��\�!;��\n;�P�2\�u\�\�D���T+\�#�\�|]�y@d��\\W{r��=�\�e\�nٗ�ĄaOa��\0\�b�KW�P\�\�QA=\�ϒ\�z|�Q\�c\�BdIk٦\08\�ީS\��\�$n\�*&w\�\�\�d�=b\r�\�C\�:$W��e0@\'8�\�x\�7ы1K\�S�Dt\��b8wB����j���\�IA3���\�H¯�v���\�@~�<�N��^-F��\�ƁT\�3u�\�i���;�\�M�\��Qes�\�q��f%p\�\�|e\�}�}>�\�#\�FL�\�\�8E�ws|\�Gm\�\�\r}\�q`�\�+\�K彇c�o)��\�D\\:�)b�\r\��a�U�e��flp\�N�\�\r���\�\�ͫ߇�B��\�r#z���P�\�f�q\�̯K}��!\�#b�`ϯ\�\�ā�v��̭�eE��D��\�4�\�j\0\�u�xuJ��6�V�8��(\�Ss\��Z\��JiLK�\�\��\�W|�\�\�\�\�4�\�\�XF)Az9��|\��\�햗ٱ[�a�{\�Z�F\�Nj\�\�q\Z�1\�!k\r\�xݝ��u�\�\�K+\�\�\�K�\�2�\��\�!-�f~��=\�&=3��jcp�)\�\�\�_f��\�\�3\Z�\��X/��\�9�\�LT\'D\�\�\�T\�dIr�\"ᵉr�I\�\�Q_CW\�\�\�gj\�i�����\���	O�\�\�@+1�4J����\�!\�sY\'g�U�\�	/\��\�(��\�yI\�\�\����}!i@`\�w[/��\�\Z4|.6�\Z\�\�\�O+�d#h\�K�\�L�7�E\nǺ;l��\�A\�\�\�h�\�\�Lŀ\�}�7W�_\�\�����:�<�)\��@�\�\�ӆ�~S�Z\�u\�\�\��\�}\n1K�\Z�`@\�Hf�\�g���Ak@\�xГ=�=\�°k\�X�T\r�\�[\�|�(c1+$	�5~ă��\�\�=ำ\�l6\�\�9-\�\Z�q���/C:�\�n\�S\�\�x�D���t�$��@A)\��\�\�Qg\��Mݥ\�\�x��-�!IH�v���ߦ�\�H\'ćp|\�nk���\��\�%6��\�\�\�fl��c�UVaҘ���>TW\�L�d\�\\��\�*���xy\�t\�D\�3�\�\�V$�(R\�^a�Fr\�.d\0��+��\'\�*V\�Q��iH��\�\�r\�\�T�+��+gYb\�UvU�\�^\����\�.\�:�d\�6�\�yz\���\r;M�^+�p�-�~\�uq�kU+\��(\�\��,�\�\�Xi�z^p+\�Wu�\�n\�OE\�\�3��tgn,S\�\�x	]\�\�	�\�^\�\�3���\�=¦/z�;��L�\nLw\�m\�:\�\'F ��*�ԣ\�MΏgX\�\�s|!J\�j-\�FsM]o,dޛJ��\�Z��Ӓh\�\00IDf\�\�f �\��1�\�3C�Z&ˋD��o31\�S���p7�a,s�пT\�Jpn\�F8��\��4�To�\�PІ)3ٷz.�!v�g�\�s\ZA�\�\�сCUH�\�B�\�&\�\�C��\�{j��֜�b{\rt�6��\�\���_~\�\�*\�\�@�\�AsDb��WN���$\�\�z�6+&\�t�h?\',\�\�\�\�\�\�S\��>O*���J@\�\��f�\Zr�c�\�;\�qY\�\�|���\���\�mK>���\\,��\�ͷF\�\�\�\Zp�֣pIF\�\�\�ڌo���;�\�I8{\�P�Œn��qJ�R�cQqx`n\�x\�\�j\�Cش\�\�k�]\�)�\�O�C��۾u�AZ`m\���\�\�`�D*�\�²�9N�6T��\�9 \0��Z}uH%�hMX\�(�J�)n3K\�J�N?�vv�\�\�7�?q�CF\�	?\�\�\�9\�0��\�EQ�Qy��w6=W�^�\n4ߜ\�\�\r�a<\�	O��\�Kw�5;%o��_\�\��\�\�,\�sWQ�B*A|��ݛ\�\�\�\ni)/\�\�!%<G߲Q7n�65T/\�SQ\��\�x+\�${���\�GVl�	\�7R��S\�oH��ʈf�p�\�9�\�	HK)1T��T���8�H\��nHY���h���$\��YK[ѧ6�V�\�͔tv6+�H\\�7^���\��\Z\�\�\�#�<2�$P�1]H�C隕\�\�iJ��b�Ӕ\\7��\��ky�\�i�b\�\n_\�\�\�9�9(�\�~\�\�m����\�&�(qj���E�eܓ)\�\�\'\�U�#-B\����8�\�\�\Zr]gﮮ\�ʠPn;�)e�%PU+�\�TAal�ek\�B-\0\�\0M�\�.댞^\�;n�S2S�\�V�}����w��I��\�\�K�~_�(8V�Sa\�G�^\���\�h�\�%||�X5~\\g_\�\�I��.\�Mm$�O�\�\�\�ev�\Z\�\�y \�&C�0@P\�漝\Z\n\0F�ي�l\�rq�\�-��g�-�\��2\\�\�đ��0\"�Å\�Z��ctM����\��yJ���\�|\rm(|8c�[�\��`\Z輆4�#\'��\�$l2\�\rv�#ݠ٢�\�E;�\�\�MP\Z�\�\�-�4\�rǑxu\�`O74w\�\�g�\"z�\�\�ݰ9ϓ׼�\�v\0\'ۭG&\��2ϱ�:�����\�(��8DZJC�z��G/�P�m\�\�\�\�R\0\�\��\rS��P#\nWQ\��}\�jV��Ͷ\�s[\�=l��1,-\�X\�M-\�MƅO��\�>�|�o\�E�@y\�H~[D�\�{\�\�\�\�2G$����\�\�\�;\'L\�\�\�\�ө_\����J\�uK3D��\�\n\�[�\�\�\�ڣ�\��io\�ht\�\�|5�\�\�vHk�o��\�\�Kbo6C�N�w\�\�����.�����&!E\�\�\0�\�\�\�U/1U\��c�o\�A�\�%[\�\�\�F��)\ZG\�}p +.I�W��)\�-�C�7�k\�;�J0\�+�\�e\��}�,���\�\�ڂ�>\�\�\'\�\�YW\�{��׊��\�^��A]�Oh����\�C�7\0\�.��pi.[,$;�>mi\�\n�\�C��\�\�k�0I\������Y\�<U\�x�z&bP\�\�\��\�\�(\�ǻ�#�kky\�m\�^t\��\�d+X=l�|a��\�`���\�i\�\�+\�\"`y��.�\�wɓJ\"�\�ʃ�U��\�Awa\�\�[w/���I\�i�\�\��D\�9\'H<\�h@QX\����� FD`�v\�X\�w�\�\�E�oL�@�I��SC˪lʽ��P�bf�@\�\�Ph�)p&2P\�ƻ@�\\9\��ꀫK�\��u\rX�S�F1\�\�QͲ3�槤N࡭[EO�~\"p��X��N\�\�Ra<�\�zH\�ec�\'ċ�ΛI:UI\�\���o\n/(VE�X�\�o\�ػ���-R4A~YOJ\�9&�\�\�\�U@�d{vr5H�\r\�c���hK��EJI5і-��Bb\�T�T�\�:@O%�\�YT\�V�]\�\�\ruߎ�\�K\��@�<�F�$2�\�x���f\�;�n��\��\�x*D��%�N��?����գ�Y�\��J@�\�\�5���\�\�P$65\�z%< ��^O4E:\�4D_\�$Զ��\�]�ũj5\�\�@��}V�\�j�\�1\�(�Ʒ\�x�r�摕\Z�]\�S+T����\�N\n��V�%\�\���\�\�D��v%�Ҩ�\�7\�\'�\�\Z*�}�F-s)k3�\�]q��\�M{\�zg\�S�X�\n}��p���i7I�\�\�1\�\'\�B�\�MMY9R�Ö{3T\ZR� q�KQ<4ܘ�\�)뢸���\��\�m\��6�~�i�q!Y癓+L1F\��J8i\�S}x�>��#.h\�Ѿ#\�.�\�\��!�\�i$\�\�[\��\�|X����\�hLz��Ij@�^a\�0\0l�O���}^B\r[{G}+b�e\�1\����\��Y���Ħ��l��2B\�Zk&�H�\\��`B\�%�q\�\�)��\rmu�����/�j}�|�]��k(@\�;�\�\�\�1$\�1��ҪȬ`\�}\��AI\�1R����\�\�����\�F\�ʓE\'��\n�\�\�\0\�>uj9\'\��z\�^sK	+\nF�\�\��	\�w�~�\�ѧ\�7E�\�\��7\�Р93�r\���T�\�a6\�\�\�ut�܃K4��\�\�,\��	s�\�\"�XyXf\�<�\"\��{\�)��Q\�LqB]Ef�\0��9l\�w\�\�O��V-\�p����h\�o\�\�=\�c\�B� \�Z\��\0m\�\�//E\�0UY\�;���\�Io\�\�X/�\�ø�L{�\�#\�+�8��P�mq2�ܓ���\�s���\�\��#�\'o\�:�O\�ޑfJ\�\�0gjＺ\��H���.GZ]\��\"v��/CX	�\rOJ�O�\�C\�;\�#\�ɛ3\�\�\�c1�\�)��M\Zn\�\�\�ѱ/�\�\�JA%�%u�D\�\�\�N\�C5�\r\\�(�>X>�\� �\�\�#\r�\��\�*]�e�Q~qF\�\n�\�\�6�a~ʻa����	�_\n��3;A<,\�G�kRO���A\�&ʛ�F���2\�v��:k�\r�ȶ\�\�\�w�\�T%)�G?C\�~$\�3��\�@\'�m\���:\��x���P6�Q\�&Ճ{\�Xn�\�z~�ڛ�sE`\�R\�\�408gP\�U\�\�\�\�\�U+���f\�\�o�\�����ȷ�ǈ�w\�a�wtǌ��;D\�N\�\�o�<\�&I\�\"���v���\�۴\�\�zP\�u\"��2�9\�C\�S�\�:��d��U̝iX�(Dhes\�l\\���͛ԗ\�\�M��D>��\��JĆ\�I\�`�\�e�\�\���\��8+��U[\�%���(\��:�\�\�\�I\�(�íA3�,w\�m\�!�ca}\���F\�e\�[\0\�\�\n\�\�0/\�\�\"�<mX\�v\�\�Ъ�\�\"\�[#9�p]\�\'�Yr^��.\�J\�i\���2wͼ\�.��{L��Ɗ�3\��\�e\�\�X\���\n\�!�mX�j�Uٽ\�VL��o\�\�$�߳\�2�T%\�\�^.�8\�C�5�1\�\��?а�\'�\0˔s|c1	\'駪�*D�h2C\�Y-�(?S,�\�-�ҵN����d�g1}\�9Y\�\\[_��V3jTh\�\�\��\�)\�\�V\n��ߧ��q�\�=v\�L	\��\�pnK�p��P\�j\�\���\�5uҕS\�\�WfVd�l:��\"�b�׎\�\�bқ)\�\�u�vWB�[�#�fY�XyփqLZ>�#�\�\�\�A�\nʧ���t�)�\�\�iB�\�%s\"�Yxo�\�ܸ�-\�Z\�H\'\�!�\�5��l.d�\'�ꑪ;za\�HW�U�+\�d�5 �Ư\�\�Dӿ�M\�\�\�\�\"4��$�\�\�\�מ\���j\\Kf�\�I\�\r\�h��m�]��hA����8�(�\�J�\�\�-��̿h4��\�\�Ժ�D\�\�j�r�Ã�YLtS\�W)�s-\�\�\�M\ni\�4�(1e\�^b\�\�\�P6\�O�\\\�\�mf�Uǧ\�(O[OP�ːb��~;|!E�\�H�\"�\�\�\"M)\�*�07\�&\�qQA\�<�Ս8dF=\�bMP\�\"�MG\n\�x�PD��s\�\�d́m�cUjpt���\�u� Zpz\�Tk$�dOx��i�R�@pŦ=h�ǎS5`tTw\��ޡ�\�@9~zr!w$@oT=h\�<\�\�;	�\�$�,Uw\�+�t���S?ԊNx�\���h�X��\�)\�d\�nq$Y\�\ZXw\���/	\�\�\\X�ub7��SH�\�\�K\�|����\�c7�1#\�\�\�\0\�1\�n\�U^YG\�G�oԞ_)�\�(\�P��K\�\�,lva\"I��(\�mX�q��q�PnVx�\"�+g�\�ܫ�}\\����\�\�b�7h!L\�t\�S\�#M�\�\\�\�B�\�}\�9��%��\�w\�1�Ѕ,�+��.爂\��1�\�\�s9\�\�t8��\�6�\�\'#-�0�\��=\Z30QR.�R�t�CO\�����L�(?\�5˫�Hum9U\�Y\�+2g�ьʈN�6�u]0כ�~��3\0�\�He�!\r#v8gi�Ru\Z@2�����\n�\�>�\�c��F��#\�7h�b\�s\�:9 .<\�Ex\�\�E�\�\�z��c&\��N=�\�\�\�:ͦb���\�L��\�}�\�7�J\�1�\�z�#\�W/�	aM� ��5ui�\�^�\�D?\�\�\�0H�³��e��iRwX\�W\�UgZ\�\���zk,|@ E�\�y���[�R\�\�\�\�;�h%\�6�O\�\����h�g\�Ug{,N*QuR��41��*\���\�;\r\��\��\�i�$*+�%Xp�\�\�\�\�����?#<v\���K\�9ϋ*\�އuaV��ۨ9���K�Q\�,\0}\�6>\"	]�m\�\�]y	\�S5\�\�\�7;k��7$J�%�a\�\�>���wl\�j>�\�\�\��ގj��-i#qE�\�Zlnp�`\r%��\�o���\rߖ\�\�S\�F\�\\�D�K\�S��9\�3!^�P���`#R���?g�L�u��&\�\�r�H=Cp\�\�\�4�#\�bTO\�l�B#\�\�\��,�@堊\ng�\�OSM� d]�\�\�\�\�\�\�GUbK\�\�\�&\�G3Ċ�Tԏ@\�����9ʏ���(J��\�4Q�2\�\�\r�ǆ/Ms�W\�v���{;}W�>�����\�\�\�\�\�\�?�\�6\�h��)\�M��z �	H\�\�\�F\�\�[cw\�/���nSх=+p�CN�\�|�R/\�=H��z��]<Qt\\z�`d�G\��\�>�H_�n�_<\\ѻ\�#RS\�@5\�����e֔��]��\�Cz�\�9��ٵ\�\�\�t���u�n��t�}EX5�}QOǒ\�D\r\\�wfP\�\�\�~(X�\�\�my�Ѯ3.�#\Z;ڹ��\�e\�]q�\�\�\�!�.m\0���\�q\�\�Z�\�\0&)*ṧ\�MzN�q\Zd0��:c�;7��\�\��\�\�|�\� \�<�S(\�%�\�j\�]��@�)�cd�SA\�:\0�?5\�\�\��\�qfXl\�\�:]�^0|4.\�wΌL�\�\�~٣zT�\�>T������\�.8N�1\�0\�G�\�>\�+�c\�@!\�g/�J-\��ﹻ�<���d�GH�HK���\��5�G7��\\̣�\Z\��#�N%~_\\�	�yƧ\�<��I5�\�,K�N�d\�4\�m�\�}	&2\�\�m|��;zr\�\�k�^0��Aɖ)cO4\�\�D�d�n[��\�}ё�g8�K�v�}�J{�¡.!U\Z��3RH\�mc\�ܵTf�\rO.�\��y[�\02�IW\�&?toP\�WW\�|y����gd�mo�\�b\�~=\�\�O�Uu�f.Kv,\�\�ҽ�D:�\���ˎ}�\�\�ש\�_X�Bm�\�/\ZQu�0AzvbT\�1��}R\Z\�\�93\\�%��>:|\�	K���\�\���CLX\�H� �I�!a~H4��ps\�9�@\ZzI��\'�]�9��sǾ��\�M�o�@\���\�\�GT*\�N��\�ؾ\�K[A�(6�\�a��lpNqgI#\�\n���ݽW\�%�7z�Mt큞S3)�\�\�\�\�\n�x$K)B�\Z�_\�\�\�kQ\0�\�~�֫q\�~02ݐ\�\��\�Ş\�\�~\�Qz.\"&�#+�)ѩ\�\�\�B+�\�7\�Y�(�m\�0�\�җ�Z{�$�\�1,\�\'��:\�E\r4�\�\�?4�9\�F\��euϛd\�\�\'�t\�|X�6�TQ\��V�\�o]ء�\�%\�:�}۶\�\�{on&\\���gL�R�\�\�\�\��e4�3\�\�L!�\�L���\�$I)�)\�\�UY?\��Q�\�n.ؼ\�fс��5X\�\���=>��9\�C\�\��m\�N��\�\�\�\0\�\� Sǋm\�x\���k<E`�\�~�g�*�\�\�0\�p\�|e\�\ZdZ�\�:T\�\�hz�\��\�zJq\�\"2d�6=�M�#	��𳷷?\�e�Nx4\"W�c\�j�R�2lc\�z:6�l8��f	K�Kk�!�	�\�\\$h�<\�\'@isq*��\�R��{�;ٷ�vj̰�\�l��\��M[�\�-\�nv�_��3]��M$\�\�|&0�����-\�E�����69玑�����r\�͊��\Z\�\"&����\�dF\�\�e�\�\�\�\�\�\�s↪��\�*�\�s�9���\��\�\�!HjY�\n|5\��\�:�;���v\"��:\�\�\�Q\�8\�\�H �\�\"�\�\����;J�\�c\�\�/�+x���\�p�O\�0P�Z�E�Kf@8\�\rV\�CeD�vh�eb(���r�_�\0�\�E�\�Z}\�\��c}Q��Snl��\���Q�{ۼ�*�%���\��\�N\�D\�\�)\�\��\�\�;\�F\�\�G\Z\�ʧ\�	�I\�3\�*\�%O�\�Tx/mޚ\0����LN\�U�Q�<f	^!J�\�(q\�~�Z��px\�T1�t������ҟGB��\�\Zebz�9ʮ\�P\�%�\�\�\�\�M��n\"���Vݥ&�H��F\�\"�\�\�آkI���9�h�a���(\�R\����҆��ی\�+�o=U_\�s�����¦\"	\�\�\�w�!��hu�Y}�:�\�B8���%>\�&�0\�\�\�\�Z�4͓��l�YpqiX��]\� �b\�\�\�C\�V��\�{G#�w->K\r\�&\�\�,a\�\�\�V ����G�仄R\�8�\��u���\0��0о\�\�~LB\��Ͳ�=�`��U5j�1\�Uc�\�N1I5�F5,�\�:\��[pr\�1Xe\�\�-�Y\�\�\�\�8&��x�0�\�\�\0,��+�dH`f���\�@\�Cr�\��tt]K\r��^TK!\�O#��&Ɋ�\�\�\�>\�s\��\�\�\�F\�ؙ�g5j�]HղN�\�D�\�\�>�nߖ��\�8A\�g($^\�lz�9�\�^\Zzz�6sf\�2՚v\���	�\�\0�-9�>�5��@��\�\rE�f-\�a\��*:\�;\�\�<f�Ϙj�!\0�D\\\�\�\�\�\�+�6��)\�Ђ�\�\�����,\�\�kC1zܵ}\�쇁�M\��\�\�R#��v\�h\�\'X<�\'��8��s\ry$.ձB?8\�I\'W^�V�	���8ͪ\��\�)��u\�\�\�^OP\�=\�0�M964�N\�U=F<N\�6.-\�\r{.���\��ncv�\�Di\�\�\�\�\��\�\�%��{�\�MC�-=\r\�\�TF��u��\�&\�\�*\����o�|�fW\�a��O\�\�ե�\�o�\�\�\0�:��-�Ώ�\�3*\�wH58�\0�?�����\�\�o\�\�\�\�\\�c\�\n\�}N1\nL \�x\��\�J6\�I4�>�\0���qP49�5\��\�\'\�7\�|�\��\�\���\\\�\��[ۗ鯿B��ʽqr\�\�Fo1]K,mv\�\�_�sH\�ꦕ\�\r@j��5T\�\Z|G	��y��\�\�\�\��\n����\�\�ND(ۥ\�\�A.\"\�\��ihn���k����7��t�\�\�\��\�\�kM�\�-�\�$�\�w��\"U�\'!�\'8�\�<J\�/\�]\�+#M{�ʁ���x{b*�+���0�C(n=�-\��F�#�\�\��\�Å?�D[nHpx?Ó�\�\�%ose�\"�\�d��#\�\�褙%C\�)0�\�\r�Y!{7����\�`^�\�\r�\�#r�`�x�\�\nl�\�\�p\�y#����83a��<>�I;,�U�\�M\��#�\0��:0^�	K���\�\�qX\�\�,՟�=}b�n\�}\nQH0ԝ\�l�Ʈ��?\�\�<G��\�\�\�q���\�C\�\�G���� \�\�gQ9\�x\�l\�j���\�\�\�\�4��\��\\\��N;�/�k�,�\�:�\0�1p�Qcq\0\�)l\�Ca\�S�\n��o|\"g�7\�\�UAx\� �k\�\�\\�\�dL��o�o\�8\�m�):�I�h�fL?�e@I\�\�\'	�G�.��\"\��\�\�l\�>�UEQ=\�\�_r\�\�>{\�\�\�\�B:K���\"2\�.5t\�Շ2W\rZ�!\0i\�ܘE��^0K\�L�`PPs\�\�_8S\�\�\�(��\0\�+U\�a\�3xh���I<�F\�#!��9�P�\0@�f�t�h\��Kz�d4�CK\�#�J\n8f �ݓ\�2\�)�\�9zM&J?�ӣ�\�/Q}\�\��\"�!>ݔ\�\�`\���!�\�]\�Z���Er\�ЦXqj�\�0@���k^_[\�(\�<Pa\�a\�\�_߻� �u�\�ᜊ�To4\�\�\��q�\�\�\�\�P���,\�+5Kt)\�\�8\�\�*5:��pt�C\�,ʞ�wPpzG*)�\�\�ٹtm<�dᄙ\�zs=���\�ZT�\�7��D~��m|U�s�d�BCT\�\�h\�C�?���`\�\�\�9m\Z\�cO�\� �G��G\�\�R�H	\�\�1l1X45C4{�E\�3\�~z9G\�\\�hln�SU]o\�\�O\�\\\�j\�զ)D��{\�^͗���\�7�Qj\�/sS�>\�\�WNṡ���ԮMq�!3H�ǚ\\��GT\�Eo\�\�G\�jW;<A0\�Υ\�N¿*6c(\�\�\�\�%T�S���g\�\�\�p�!!�\�\�{�.\�P���c�^Zqԃ\�6\�U�[#\��\�\�1�j��U\�;\�\�eA\�5\�\�%3t\�\�$�P�\Z.�O+P\� C]LG)1\�~}?\rڼ\�i�A3�Ɏۤ�}é5g�[?0\0��J�0%Oi!�2Z�\�\�׬\��\�U�uh�\'���շ\�\� <L�\�`\�eZ�9\����֌�O/�\�\��\�\'��Dn�<41\�!d\�6�\�X��I\�ȾH�Q/\�{N\�#R)\�\�Ei�.\�O\���\�_V\')��?B\�7\0�2�bx\�k�\�;�ީ\�>=�4\�\�����j?Bo�=\"<\�\�jΣY*/%\�y|��[�\r���[a/\�=4c\�\�,Z�4\�\'5���\�-6\�)ΔWH\�\\I0[���kۃ?\�N~�t\�S\�\�]�\��\��0Z\�L�IVe�w\�vL���7�>w\'�^47�\�U�8zv2]\�\�\�\�Q\�!v\�h*$��\� \�+5e�|\���sF6\�89�\�\�\�L@E/��V�YR�_A;�\�\�\�\�f\�\�q�`2�\��=\n_)�	��wS\�\Z\�-Ӯ��8ߧqJ˲\��{��\�sz_3G\�5�\�{\�N\�\���\�±H\�Jy)��k���\��}���\�M\�\�,�\�ӳ�WƩُ���!�O�v�>#;�Q\�S��\�g\��`\"�U<��\�\�\�\�;\"\�\�f\�C\0�RuƐ7�z�\�!�{�\�ʰ\�l���d\�-&\�CvY}\�T��`\��<\���߶�:\�?\�xA4L	�\�-\�v\�jj^B�\�~y(��\�FUF�\�\�\�a6�\�БH\�\�x\�,x��VA�\�\�\�+l!j\�gG\�\�\�;\n\�QWq��	��\�\�?\�\�\�\0u\�\��T�\�#�\�#��y�|.\n�\�\0CN��j�t�i\�a�\�R&�$\���\�\�E�rK\�pE�\�g\�O(7(\�+�\�ͪ��\"iy�c\�i\��_S\�\�Z 3�\�jl\ns\�\�8��U<\�\�\�n�t͂N\�\�tw���}�Y!y�<>\�~Q~�=��o�\�D�\�2D��b�˂\��\� ��T�\"\�c{\�c^y$	t}\�P\�K\��T�\�j\��ȩc\�=\�1-%�\�|\�\�w<���\�?~\'�\�\�l\�Zc\��IDz \�M\�\�Ҍ\�\�\�)=�*	�۲�h!\�\�]=\�g\�\Z�A�\\��VǢ\r�\"\�\�v�\�]\�`\�s^\�E\�#�Խ:s2\�\�YmwB��R����&D�mRS�Y\�\�\��	f�!\�Ķ�\�r�\�<�\�e�\�eֺ�L\�]�ҫta�t�\�!\�\�\�>��\�\�PZ��#��=�;\Zb`%�]\�\�~��\�\�\�\�\�f�\�X\�¬�K������\�S�\�\�Ԟ�6�\��ǭ\\Yj��/I\�	�(7�|S=n\Z���={\�\�ɻZ5{*��*�Y椱D\�eQ\'K*�b�6\"I\�W��,<\�˿]�x��)�lݯZE8�;\\y���E\��l\�\�?u���:�)f.\�\�\Z#\��T�Y\�\�I]L�\�藃��S[\�\0\�\�\�K�T�<@�eh\Z�|q4�p��Dj�\�dK�%\Z�fI�������\'JA5q\�ѳ\�\���[��\�\�,�,2�\���w~�,ZĺN���O/N�I�A��TK��!P�QD���ù+\�C)\�\�d\�\�\�{��B0�\�	�����%ש*�w\�1�\�0Ԁ��ϫ\�*�Z�\����P\�\r}\�=���(����Jh\�\�;\�\�\n}�*\0S\�\��V�-\�|�>\r��\�4̯\�V�9��\�N\�\�f�yb^Z\�b:T\�\0�\��o�K\�vՍ�\�\�1��\0;ú>)�_Id\�*\�\��\�=\�b�r78\�&\�NUgU\�0g2��Օ��c�,4\�U0�\ry\�\�!>u�T\Zf\�V\���so$\�\�bIF\�w\�^\��K�eR�&���+\�3�{�6�?51\����\��\�:\�Y\�\�6�jBr��\\\0*�\�\��,@\�c�\�t�/�[C��7v�P\��>\�6�jp\0�Er\�=����dl\�軓3\�pD\�\�\�\\����\�Y�\�\�I�>\�\�\�\�\�\�\�W�\�\�Z��\�\�5*l\�@\0�	ݡ\�RJ\�%\�n�\�\n�\���J\�\�T�\�\�`+\�\"����yV=.��|u\�\�T\��\�Ɣl\��.\�\�u/\�Ŗ\�\����N@�X�\�}m\�aIއ3\�I{�c\�\�\�E�N	�E\��\\Pѫ)\�5\�U.\�\�%f��i\�ҳ?\�\�\�\��\Z<�B�qze)�\�M\�\Z0Q�\�J�\nrd�\ro\�#st䇩}�#\��\�H\�\�չ?\r\�\�\�\�O�\�>/\"�\"l�\��ti�~\�\�^m���\�Vӵ}׀\�-�K��`\�\�[\nBfE��z \�\�OKZ1o\�:ӫ�s���`\'\�K/r۠\�\�\�\�l\�V��`��\"��+�\�%��\�m\�\�޽|\�\�\��<��&\��\�y�f�ocN��\�\�\� !\�>_\�\��O\�\��\�r\�\'Ϗ\�hK2+N�\�!�w(\�S8OS��}�B]9x�U\�\�\�j���\�C7\�\�_t�Pv=z1\�&@}\rR�ks& s�7@\�h\�h\�P{\�\0Y\�밋\��\�̡s|���_\\\�\�5m\�\�\�,ާ��Iyi���͠\�uv\�!ǮI9\�\�\�#=�\�\�:)@�8�j�-�-�N�\�+&*f\�3X���2J�ƺza\�/\�b\�\�!�\�J�\�\��r�J;|}Sb�\�	�\�:_}\0OC���3n�	\�^,!\�\�N\�\�ص\�ƅ2�\�>\�cŧ�\�\�\�[�[\�?Ը\"fv��<6\�ܑ\�\�r�w%Ң���\\޸�u\�4\"X$c\�\�P\�;\��2L�\�ɪn�����l\�o�SD�\�\r\�~B/	Fϴ\�J	HS�AW+8�\�M\Z+\����p\�b5訞\�tk�\�ԏ\�\�*\�\�6/\�\�x�8���}��\�\����Y2m�\�L\�g�\�pJf��z�bC\�\��H\��L\�_\�w3�Q=\���\�pU\"f���y�O\�\��(��	C��m\�W}3�>��j�6\�ˈ��S/<a\�`�^	/\�\�\����\�k�%BE\�Փ�\�\�=*/>\��U\�\�%�\�n?5\�\�i�����-��\�{^\�7ѐq\�Q\�W`5\�\�X��:�\�S\�\�L��Tf]\�U�l�\�p\���jJ�\�X�\�W\�Y!�+Aů��-lS��ɫt���\�nY��j�%\�\rй7\�V�J\�B�}^�wO\�\�\�ڢ~�\�y\�\��G\��z\�I\�<�P>;5\�ڵ5��h\�>Ф\�\�+)e�S���g�\�̃J��ű\�򹐾��\�mgy|���R�����\Z+�6s\���\�\�����v\�aݽ�y�9tD9d\0�\�\�=����x�(@e[�*\�i\�\�\�w��4��)�\���x\�?\�|\�;K�A��o#�pi��\�\�\�\���RF\Z���\��\��gB:\�_ �_�-��f�\�Q��f�wu\�`���\�a\�\�\��\Zب�5\�\�;\�c\�c%�\�-B��&�ʈ�\�E3O\�\�ƌ�sQ>\��Zc3�16�	>\�u���=#�:p�\�%�=��\Z:�)M�53z�sx\�}ba\�\�,hQ\�f{̜�\�j\����8���\�Dv�Y<r�D.\��M[\�!V�BC�\�]?73�ף%�|tl콳���\�{3Pù9�X�=8\"�-e���\�U�])�\�\�\�\�#è�\�H�XG�£�Mk^\�j°0?\�//\��r.\�p\�h�j�/\�u�\�L-\'h�V�(�\�x\�K�E\�w�\��̆\�&u\�\�\�0)+J۔.��ay���/�tm��\�	-\�\�\�p�l\�YQ4i�\�ד����� �\�+K\�\�k-��\�\r�\�\�ZtU�2�!)�i�\'Z0\�\�\�O)��\� ���7��:�|�.�2�\�{P�;7D�e=u�+?Z��,��\��a�w\�\�\�\�3\"�O�uP����֕C�b�|n]�v�\�k,\�\'�e\�\�\�K\�[���\�{wԬp��Q\�\�Ep	CbGv4�\�3���\�À��\�\�S\�\�\�M\�\�>\r\�3>\�\�\�\�>zb�ް�z`�pm3T(�\�ML#g\�z\����-\�\�\�7\�cF^�I�2�\�H�\n��\��\�x_KRi\�\�\�\03:۫\r&rI@{��QNNR͂�\�_~��\�Վ\�V)\�<\�rU>�\�҆I�;�v?J�uT5C\�\�\�oYf�8\r\�Q\�Kpb*\'\�޳\�cQQʕ�-N�Y\�?�VȊh��ܓ�hk\�z<�\Zv�\�߼\�\�˘\\]R]\�?\�\�\�\�z1)wX\\`ƶ\�;d��K�r�T���\�\�g�o\�\�rl\�g�V\�1$ۅ\�)uz_�m[N\"���\�r�\�}�\�v1\�o�\�9P\�9B�mH> �:�}9$�:�s��^\Z�\�|3�]B����#vQ\\��m��\�nvhJ9ykS#\�d(I|�t�7�cO�A\�(�Y(\�8$�˜	\�\'e\� �s\�\��r��g\�aǹ-��E\�\�\Z\�\�\���2�\�\�\\Y��4e�(8�\�N���@\�\�J\��\Z	%�\�,g&]c�۳\�Qm�	\�8�QUcJV{��v\�$X(\�{=��Vz�\�\�\�5{�\�u��1	�\�M�,��k\�COi�C�\�\�OKwC\�B_W��:�\�\��WR\�\�R7ᆍ�\���<Ø�U\�s���\�E��!fQlh�u;U\�Rj\�\�0\\\�H`�&�+A𡣄�9\�4�0�\�#��A�\�\�#S:\�OĔ�\��\�oX�͖�EJ\�߷��{\��� - [��$y��\��I���fv\�F_ou���.��e�=\�\�\�E\����ɮX\r�\�RDe�yd�\�Ҳ\�(T�nڶ\�\�\0y\�GA��5�\�\�ؿ�\"]\�uՓ\���j\�\0�q�sա�\�:R�h\Z�\�J�\"�\�15Agx\�\�\�ӥ\ro\�Aic�\�\�$\�-��\�1�=\nM\��irD\�>\'\�\�C\�ב\�\�g\�񅻸\re%�\�\�Ĉ\rf_\�\�\�\�8E\�p*S\�\ZK�~�\�6�{�)\�v\�Q\�I\�M\�<��\�\�\�ae����,�\0�@�\�\���I�A_\�\����B\�\�+ٓ}U;\�v�j܎���I�E\�\��w�\�uP\�J74�W�\�\�\�\�8�w0|A�ufm]�3���i�XE N�	�\�\�}\�\\g��vo\�mW�b^�*�\�vN�^�r{M+3\�J\�>\�l��vd\�:�/\�\�~�D�ݬ���Ni;Ш��lr<\�Ԉ�\�!}2�GK�?�E\�ak��#�*�\r���ռ|\r]�\�r\�D��PwYu\�6��X�\�\�\�9���J{iӓ\�Ԕՙu��\n�y\�|�\�^�1\�J�\08���K\�y\�\��\�mh҆ڧ�\Z5��YTd`\�~\0�\��Uc\�_k��H\����\\3\�\�\�J٫��\�T\�b<P����^C\��\�8⌟��,\��^;Э�S\\\�bgf=\�\�4\�mi�H\��F\�n��\�g\�\�_7�<և\�;X\0t�H\�Ƶ�Kz\'8a#%C\��*�\�\Z\�[��&��\0L�\�\'c\�M\�N��\�#\�q�����:&\�\�\n��\�y��\�l�|�r4�Q\�sG\�\�\�K\�r�s�v*e<I5\�84\n[\Z�QK?iE\��x\�I�9t���et�WM���\�v)\0c�\�Ug+e?\�\�����\�~��)�T�P9r���G�CiF��=�˲�\�0\�p\n,1G\0��\�q�B�Rz?��ܫ��4	\���Q\nJ\�pJ\�\�1ٛ7���r�聴\�R.f�\�R!��\�m���a���\��$&m��<V�i\��W��a?\�\�:2�r(P\�MjĒ\�_\n:\�\r>\�\"�o\�6{K\�7��A.w=�Sͷ�J\�kqU\�Z\�y\�ƶ��Aqԛ\�P>�ó�\�\'���\�y֒��Jʁ|�x\�\�Mv/ߙ\�\�\�\�d\�)\�@�0^\�\�.{�Fi?�Y�m�\�\�S�ZA;E\�\Z�!d��:@+S�ж\�e�\"u\�\�F��\�\\��uح\�0\�����\\\�㍹Żʥq\n:����\�\�@�\�¤\"\�\�l`\�\�\�J\�(޹\�+�>\�x\�\�D�̊:iķ���(׹հ죥2\�{s`�\�PtEn\�N\�(��\"��߀@RU�\�\�C��Y�\�W\�\�\�e�\�58�D\�$�P\�Mݬ$�ַ�z�8�b�\"D��:\�V\�Vl.\�5D�\�^�NR\�\�I�8 L\�H#}9\�Ѿ�#�jF.��X��i��K�_�\�FC4y�F\�}L����sE1�\���\�x�U�\�\�̣\�)\�U۩�>�M\�\�iB%7�����\�\��9n�[�_\n-\'xB�Z�O��ro��d�\�O�J\�\�\�\�?<*�\�\��$r��\�v.\"@\�ν\�\�U�<x\�jQ5=z\�a�(��\�1\�Z�f�\�\���/\��:T݄R\�\'=2s\��4�~\�]�\ZT,\�E�\\�\n\�L\�\�-�m\\\�SN�Ex\�{\r\�%�[L&�tv�I)\�n��sg#ѱ\�\�GLQ�Q\�\�+I%��\�U\�K\�?j\�t<�k�\�\�\�\�=\'\�\�\"��g1(\�\�\�*�r��B��K�\�$_Y/\�\�\�G�\�fVbb\�A\���9�����\�\�<�m\ZW�\�zX�\�b��=���u\�\Z���{Ք�\����e\�\�\��\�\0\�2n\':D1.K�N\�y\��_qr\�r�PV�(xx<[\��<�\�gP��\��/Vt���ѩ�\�\�/\�7OR�q�x�\�-\�\Z�\�\�A\�+\�%퉮_\',\�f+�,���~\�fp\�R��\�X��d�U\��k\"u\'��\�B\��ZRMx\�`\"�5�\�E��\�\�\�u\�x��\�\�Q\�G\"\�+\�:\�\�\'\��ӣ}\�\�Է\�s���\�D�\�\�\�\��ǐ:-\�REE�\�_d�^�!\�P\�9\�\�8\�T�U�\Z-@%�\�\���\Z:�\�\��C��|\05j���t��\�ԘW��\�`\��\�Y\Z<M�7\�*ZjᑄKE\�I\"\�O#.$�N|õ\�O\�\�W1\�1V�0_�0486?�ԻI���]?�U�\�؝9Ì��3�1/\�E}j@)\�|it��\0\�\�\�]%\�Ux���\n\�B\ZFY)����NO�\��7\r��*\�L\�� \�t[\�oIF�7\�Xwd�\rv�834X\�0~\�I\\v�O%��\��r�=�\�\�\�VMň�\�\r\'\�ӣ}\�\�\�\�[\��f|\�V^\�����H�-d����\�mT�ā�ZHp�����J	ȣ\�\�6�^�&0\�]\�D�}۟�\�y�\rȕ�F�ǫ\�\�\�(=R�]\�\r�Sc�\Z��\�Z=M��O��.\�YNN\�ɚ-�\��7�7��Rk_\�Pa\�\�\Z�ـ�tp\�\0\�/頷Vݐ�\�\�K6V	��	�|P�\�\���a\�md^�q^&!1v	o�9\���jX�\��\�#�\�UVq�\">�\�w�vbޏ�\�e5g{.�\�\�ER7c9��2\�\nb�������3\\\Z\�d�@r,0O�\�\�c�5��\�]�\�-6�,c�\\�\��\�м�X\�?4�,lqM݌@\�\�\�\�\�\���\�O@�y��\��M\nF\n��\� \�,nwJ�_��\�\�\�J\�v�KI\�\�%#�󨨪?���r�\�\�ʩja�\nI-L\�)��B0��`��}\Z�玪c��C\�\�Ǩ|0>N\�@\0Gr=\�j\�}\�G\�}���.m�C\�\�\�|@]�eA\�\�\�\�p �]EKsmxu\�%\�@����\�\�4�\�u\�*\n�\�6\'�܂��kL�;G<\�:\�\�\'\�\�)�f\�\�F!.�hS�z#W�\�\�We\�u\�\�\�W!�!��kK���}bEJ����K\�B\�\�\�y�\�h??F��+�\�Q\�,D\�\�\��\�A�\n4\'\�Fb΅�\�\�?�qǸ�\�ȵ	�\�\n\�줟d�ʕ��`\��\�\�:YΪI\�\�����Ho5�[���m׉\�8\�z�H+�\Z\�\�J\0\�\�Y\�QE\�VM\�p�Ӳ\�\�\Zt\�X\�\� \��,���\r��k*����q:)\�\�\�9G��O��\�8٧P\�\�\�\�\�dj�D�*�\�b�M�)�0/�q<\�<5�]\�\�\�IZ��=yyy�/wڊ��L�?\�3{̙�Y���\�,�\�3\�>�a\���vҁ���&e$���l\�X\�&#\�&9\�\�(W6�p\�y�\�L~hp�{�\���\�\�	s�:�\�\�\�\\�+ޡ�B�\�~5+U	)_\�k\�Eg0�2�\�VV���-�R(\�dw�n\�\�u\0Jּ�\��$nPqn\�87\�\�@�\�Ĕ�\�`�\�\�\�\�\�\�G�H.\�.�\�V�>?3� �*��`�|��Ft�\�%:\�Kt2LҚn؛|\�!�\Z\�j�B\'\�Vb�l\�)Ѯþ{���}�\��\��3\�\�\�\�(���\�t�\�\�8�\�\����w�,a|\�8!I\�\�E\�0S��h\Z�v�D\��\�e\�ռ�q� mὶ[S\�j<\�(,�9\�B2�\\C*ǋ�q1/\�<>�o��W;e�4h^X\�\"wj\�݄V\�\�}4��ϝ��7\����>�>����K\�z�m���\�\�{\�\ng�#c.\��#\\�v䢑\��)ڲ���Z�\�\\:~�\�mH� \�g�nr\�y���\�t\�c�a�O녩�S\�\�\�\�7_×V\�M{&B�*Xɍ喯>�y\���nڡ��ug�4ÏWJ��S�q�1A\�Ր�zS�\�.`\�\��yDH\rvg\�\�W�\0˸fۧ\�D\�\�~jܕk\�\�\�W^`\�ML\�w\�r\�c-T�Ґ��\�\�\�ԣ�Lu>g�n09�\�TH�a��\�Ǳl��\�\�ݷn �]\�X\�Y>\�u\�T�p<�K�QF+,�JueU{���!�Y5\�=j\Z���ޙ���\"�\� ���t\�i\'7F԰g���~\�F�\�����k\�c+M{tA��גBo�%�n\�h�B\�\�eU\����,�A\�`�:ס�\�z�?ޮ������=%|�z�\�~\��š\�\�J\n&�\'\� X0\�\�Ho7��3��\r5\�Թ`\���_�K��\� �GB	h_�Jau\�\�\�\�&��dɈJآ�t�\�[!\�cj�.\'%\�s֓�ܕ2�sGOk]\�\�	[�F\�ȑ�T\�IB�-ӱ\�\�z�-\���gq�Ё�\�\�\"�P:��\�\�\����\n�(<\�TM\��tbU�fv�k\�1�\�}��\�\�\�(�@W	Uɤ>�1��~w6J�\\[Ɠؕ(MJ\�6%��C��\�^B�ς ����>\�c�\��\�?{Mu\�\�\�\��\�\��`̥�a\�\�G�d�U�e~n\"\�k�V��|\�\��\�6װ^�;G�\r��\��-�Rbb\�W),�鵒�Z����\��\\�/\�P=t_Y	�k�W<t<�h\0:�h�Rs\" sL�\�`�rl���[\r5�%\n\�R\�\�\�\�o%\�@l�#���\�PV{�¥��\Zg՘KV+�u$���\n\�f\�N T���\�<\�=\�-\�\�!LܦH\�\�: �\�\��~_?S9�c�\�:�l\�\��y�O�`\�v\�F\�T/[�\�aڻ0`NA��HuP�)B�O] \��O\',��qG��k�G�\�\�W-*j\�TR|\�Z\ZA\�!ʇQ[<U;���W��\�m|\�k�;Z�B��;��u��Ǡ\�R~�ɰ�\�\�:�Z`S\�\�:u\�\�\�BTFk{���9y�up}\�3\�\�\�\\����\�k\\\�\�^���]-���\�Y�&���Ik\�\�\�\�\�WC\�u臫�k_į�\�\�k�>\�Q�UL��\�I�\�\�?s\�K�v�KY\�B0���7 >��\�\�c�c�7Ԩ�_\�[P	.\�D\�+@^��2\�\��(1>;ZGק��S\�\�8Fop\�t�B�:�sO~\��e;\�WqdINs\�\�`U\�b\�\�^-�ai�\�#T`ӎ=��\�5De쏯ǩA�\�ŎƸT��h\�į��\n���\�\� d\�\�\����˶x��3�]򨉱vC\�2��l�O)����T�\�^��6A\�\�\�XO�N~K\��\��r��o�\�\�p8�\�C\�ni�Zڋxj��q\\�e��̐gC\Z`�rƟ9hSn0�\�s7ݩ.\�&d�\�r\�\"Q?&\�cY\���w�q ���\�\�Wb�gtB�\�֬.�q���\�B�	\�\�R\���x8��\�p,i\�Q�g\�\�\�\r�\�T\�h�\� B\�\n}\����Z��<\�O\�O+/k\��Q�H\�\�}+�:_\'�\�ߺ��[��\ZBV�΄Naf\�\�-�b-�\��W��j\�\�\�\�7\�q�\�ྖ\�\�\Z}[�Γ\�\�a\�\���%ny�?KF��\r\�$w\�C�<��1���K\�h�\�\�\�.\�x��B� \�C71��!<a��\�5\����cW\�*Z!��\�N4d\�\�\�$K�\�ٶ8���\�+O\rs\�#B�	NU�\�T:@\�\�Z�A\�m��|���X\\�j\�a\��t�\�����`K|�\�\�\�¹K�7e\'��\�ybP��r��,v��\�\�ۗ3�c9Z\�\�\�ZT�a\�\0Jz�\�/��ÝΜ�1n��\�\�=\�\�\�ч\���.1�-�\�AxT^F?�\�#��\�\�-\�\�Faݜ\��PP\�j!)G�\"X4Q��\�Sj\�n\�щ]A\�,\�L̹X�$�#\�*A�9I\r򸢌	�v�`\�E�\�qdC�k\��(g\�(/%=Լ��m��)\�\�>f4�޻�*\���o�\�.yy�J\�w�K\�\"�䥺a\��\�4=���	ZK˲Zl�\��ޜ,\���\�֫�\�\�V\�\�\�z��`\�\\��{,�a0\Zy\�\�2��\�-&�a\�\�\�gP\�R٦�R��ٟA�1|\��Q�\�)YY�d�\�\�b�\�\"���MC)\�ӭ^�27e����rk|e\�>�;z��!t�T\���\'V\�	\��ʅ)\���ň*�m\��TZh��7f�\�\n��\�\��fyw\\/��]�D���#_�%�@��\�\�q\�|hOl%�d\�o�\�\�\�\�)�\0\�g\�C⸐\�\�*&C�D\��K�%\�JB\�����hŢ�#d��a�WԦɈ\re��X�Q�\�}uL\�\�,Jq\�M\�{\�\�\�\�\�\�\�Dn�T^ܮ,D4�yJ	qX\�^���\�\�1�\n��\�z:�\�\nEY.�\�C\�uߜ\�,~�\�\�~B\��5\�$�L�Kb\�\�j\�m�u��W\�\�X4A�K�\�h\�+ˀ�����D�\�B��ߜc:��Ϛ[ur��FbmHE�\0�Z���`��\�ث\�Ѕ\�?<\�,\�\�\�)\�\�\�(7\�\��� �\\�\�_�)��F�\�G#3��`q&R_<��\�\�+tx.\�H�	)��J��G0/���f8\�K|��7(\�\�F��ޟ�\n\'COz�\rU\�\�\�\�yȩ\�B\�vK�\0�,=/R\�ʣ�\�\\}xN\�ƚ���6R���κ,Z��\�[Wn�!�I�UMҶ��\�/�c̢.�u��ǳdD\�tÊ$+�\�V�\�=`t� ėl��q:\�|��\'\�\�\�E\�atS(1���9j%9?Vb�c�l*�B+/$\�R.��\�\�K@!߷�\�n�E\�4e\�M�V\�\�)R�b(�0�d�KTx�tj4~>\nM�-�\�y���\��=Z��iqQlML��G\�1NjD���j��$eIH\�\�Gt�,*@+jp\�i^|\�Om�>d���-\�.\�\�ǽ�	W\�\\�||Y��!ĸ��\�c\�6\�\�\�\�s�َ~�F\�S\�\�Vң�l|��s�\�\r��g�w�Ұq)\�ɐ9C<�\�g\�T��]�p�f\�T��\�[��\�e\\d!y���d\�I<\�O\r$���\'�=o��@j\�L��F=\�7�d��˖\'����-\�j\�ᕉKO�WoP\�\�\�XoT�Qd��t%�\�\�p ͺ�0Wu�\\7j\��\�?���\�\�\�M�7��\�y~0e6\�� �l���	Fi��\�\�u �\�\�Ĵ\�\�\��\�q��\�\�G��\�\���4\�QK�JJ�T�2�bO\�\�)�;\�\�\�~�\�_7.F�\�\�\� �\'1\�r\"em\�U0��\�t>8��%|]\�:\�\�H��ݮ\�̄m(WI�bmP�Vss�\�]��-iUl\0�\�=;8]�\�g��\�\�eSMH�\�\�vĝs\�2L&#R��\�h\�q\�\���\"��$\�Xd9}[M�\Z\��0�f\��\�n	L��\�P:�\�	\�Ұ�&\�0f�\�6Z\�\�De#́\�\�\�4�1\�P\�n;���;\�S\�vjo}W3b\�K��\r�ɾ��$PT���\�b�\"|F�\�A�H)\�m\Z\�\�\�\�n��ǘ\��{�L�\�����\�T\�d�ǳ\�%x��hR\��\�C\�\�O�C\�`\�o\Z&\�D�\��\�WL\����\r\�\�IW�{\�r2	�\���\�X\�\�9�J!j �A|2�!c�l4\�\�d\��S`\� t�=�\���\�\�3�fJKB}�\�\�N�\�\�E7]��`\�i�%\�g |�p\�\���v]\��;A\�\�T�ٱ*����1\�\�Kf|���C\�{�)��\�e����a\�\0d:}�Zڭ\�E�u{\�?��N��\�\�~(;Pm��P�[\�>��x\�5�\�\�NQ8�7�{\�n\�\�\�\�\�-\���g3�2*\'�\ZN���!\�\�m\�<\0F\�1~�\�w\��3�/\�a\�\�l)\�*ԭn���sJh-\"�N\�*\��oo\Z�\�-���z���\�Ǚx�\���\�Y�u�=�*P\�`O��&Ҙ�\Z\�R�/k\�\�U{ˌ�\�p/\���\�:����>$�\�Ýؑ**@jvP2\�[.\�5zDd�\�~=\�,Q�㽈Vm��\�\�\\_\�1CO�X�Bq\�������\�U\�w\��X�Z\"�NFym9ҎKy�\�\�Y\�\����\�˙�\�\��R\��ƥ c�\�IK�7�;��*R� �\�\�$\�\�T\�\�2�Lo\�G��u�c��\�:\�\�\�\�Qn\�\�\�9�\�jb\�hպ^\�l\�\�W/\�#Bl�Q�{$�\�[�1\�\�XL\�x�X�\�QM\�\�\�Pg})(��!\�R\�\�y�\�\�E}ʂ]\�8�	JC&��YR�l��\�\�>\�U�\�sGFF(\�/+�ۓ23\�q/\�{\�}\\\�tS�5�_n�0\����\�lDܻ\Z�J�YW�\�.\�\�o\���G�\\3\�\�1��G=\�EH�\�\�\�w\�=�ě�\Z\���\������0�Y\"aEl`f\�z\�\�N|}�=�\� JM\�\�O\�g���+�Mf����\�WM\�.�OK\�\�t�\nq\�\�\nM]TY4\�H\�qH�LlgA\\\�a�OW�5\�\�\�ܡ�\�0�\�E\�\�\"��قb�)���a\�\�\�x�\��\��!�g��\�(��H�q1�b\�\�\��\�u\�\�Ƕ\'\�\�h�)~*}zO�AW�$���xG���,1��.[h�~��5�\�\�v\�ư�\�#C��ԋ��h�b�M\�\�l}\�n�Z\n�E��\�i���_!���\0�\nnO4M]5Bb\�H\�@\�x\�=��N/\�ti\�\�ć\�\�J��\n�ڥ��\�\�4\��\��>�$Ԑ�*��hj\�\�ST�1\�\n(\��iLGIK�\�\�]?K	�N=\�T\�\�Y��\�*b ev\�\�\�6����H��pd�-��|q�!}�\\m\�(H\��\�\�g\�#Nix�A[�\�Y#�E��Oط\�\�\�\�\�Ȇ/\�\�fx{��f�^{u\�%<\�B\�JZ�/:U\�k�\�\�T��\�\��D�g\�\�÷\�\�(�\�\'\�:c%���\�G\�;\\\�*�$�S\�\�E꘴��\�\� �\���\�6��mW\�<X\�\Z�E\�RBp\�OA5\�Wa\�ql\�\�\�E \�~@��KB1\�!\�\�r ź��\��I\�\�WI���G\�p�\�8ׯ�\"c縐؄#:R\'�m�z\���}ʼ\n�\�v\�o�%E�\�XLis�\�1#HxVτ\"x\�\�͙���p�$I\�\�m\�gQb\�e\"���¸�mL\�YA�@G���\�HHW%G���ʣBk�\�\�\�\��Y�͹�H�yS���\�\� R,\���\\\�\\#]^#b\'O=�WаB��]�\�\��g\��n�\�VO�\0\�8kⳕ�\�\r�\�\rc�3���E�`\�iZA�fW��\�ly=\�k��-)#��ӵ9y\�ѷ�g��ݯ��請�\�$�Ok�N�#c.\Z|\�P�Ň�+�v��z��艹�\�\Z�\��pG��\�\�D\�h{v�\�\�)\�g\�bH;�<�{�}[���l\r�Lq�\�\��y\��\�\���\�\���\�X\�\�\\Uߌ\"\�\�\�\�Ha/\�p\�y��\�\�>�a`v�\�y�&�A��Q�T\�n\�o��Ea��\�v3\��\�7��NB�q\��<\���ޤI��_�Y|\r�OH\�]?��X���\�4@\�aK�\�Gdɏ}\��L��SԬ\�_��\�C\��\�ßQڡf\�,`\�i��ʑa-@AU\���9�Z�\�\\\�\�S{�\�bj8\��*��\�1q~&\�\Z�E,�{�\"H\�\��y\�~W\�)O\'\�\�&�\�iؓ\�Ece��;�h\�_#љqy^nߢU�\0=�\� \rׇ�\�\�iE\���$xo�Ʀ\�\��_�퐵�\�\n~I\��8P\��*`\���b\�\�\0\�\�iX7�ܱ\�]ɔ\�\��\Z�\�;I��^\�}r��I\��\�\�\�\�ߟ{[jk�����\�@K����T\�]h�\�2c�\��LTGߛ!����n��!�\�W\�|��\�-mTv���k�\�\�-\�\�+�\Z��\�\�PuFJfii�\�a\�ǃ�uȹ���0\�o��\�\�.ֳt>eV�6\�\�\�0.\Z\�]�k\�w�!�?zaaW\��\�E���um�G2�a\�j���D�\��\�}�k�z5�w�\�}d�m\�t��B��sfħ\���n�7[�\�T���i���ƪYW\�\�\�ˡ�}�}/\�q<�\�J\�\�)\�\�\��@e􊷝߂nY\reµ�\�\�y�^V�e|Ñ\�\�mU�\�\�j\�\��{Ǿ\�b/����\�\�`~�홣r�Q\�\�\�2\�l�f�%�PcY534hq\r���\�PV9?��:S�\�\�\�l�D��>�=+\�ZVe\\>\"T\�;t�?q4U�E\�\�5��\�`�E�3��dq\�\�,hht�\��Mr\�H�Ê\��x\�%�4V�\�;\r��\�ħ\'�\�8iH\�\�\���\�f\�9\�u>f�\�G�L\Z�N3�,��G�Qù{��#\"`A�r�\�\�H\�d3\�7\�t5\\�\�*�\���s|v�\�-�\�4�Խ�\�*�12��ٷgV�\�vJ4T)5\��0_ Y~\�Lu�a\�\����JrɘbW C���~\rT�s�\�\�&\�\�[�\�?LB�J�ʹ\�Q\�\�y�\�m<\��\�\�\�\�g�xm�\�c�M\��c�}t\�Yt4\"4�a2S\�4��\�^G�xu�T�g/?aLG^��\�v�Ǉ�\�܃���%�H�\�s~0�\�\�%\�ܱ\�{K\�5;\�~���ݣ\�\�&�\�B\�F����(\�\��_\�\�5\�)~\\�,h�1\�|N\�I��\�\�#��\�\�ѣҰa�ʛ�7�\��@�Q=�Xt\�4\�\'���W�,�\0XC\��\�}\�v�A\�Օ\�x��G\�ޓ\�G\�ŏZI,U|�\n���ӝU\�^>\�#xY��{7]d�+�䤤3�&u`\�\�($\�\�1\�\�\n<�#��\�\0�\��\�\��Gt��>��\r�\�\�n�\�\�\�w\�i\�n9�\�Q��\�(&	\�\�J�엣&RUDg$�^\�:L�\�g�I\r[�w۫·JQmE\�ҽ\�\�j�E\�\nrs.�S�\�m\n�\�Q�\� \�㍭d�\Z\�\�)j+\��\�Jy7��{7��ai�p,\�n\�8��^\�*�.��\�+To�{�D�\�׋`0�t\�ܺ#��\����;\�t�>8\�\�\�U\�\nNr\�f(\�)k\��M\Zv\"\�#�\"�\�*oŃ\�\�\�H`$w��hz�2�\�`\'\�\�2�\�\��\�=J*�6.;q�����b�C��)\�0�)��Z�<b�jjX\�\�/�\�\\\n\�\�\�2Or_�\�?\�.g>$�]ӣb՗v�\nA\�H�iºD�pC]�~L\�\�\�\�\�ݼ��\�:\�tL\r_\�faA\�7~.o� ��B�l:Y\\l��\"\�\�\�s;\�{\�P\�\��iv\�\Z\�\Z��L\�)��Z\���\��FnVw�\��k\�\�aW�i�\�7}~\�	��	3Y\�P��\�\rE@�\"�^g)�-\�	\�\�7v\�x&\0UgS\�Z4�0CYRWWR4\��*�?��q\���}��R��a\�\\�(�t\�d�s�s3�]%\�\�>���\�&\�]\�\�\�\�*PG\�\�\�\����Ռe8\�f`�Mr\�\"V�%�\�\'b�M�\��JC>�\\�\n\�+�w\�|R\�\��8\�\�\�j\�ne]\\Y�\���	�i�\�\�b[��d/p�*`٢\�ETԃh�\�؍\�\�,!}�7]ȫ\�e\�`h\�8\�\�ӹ��\�C\�\�կD\�\�T!oo\�>:\�ł\�\�X+\�\"b��v��w\�\�+iqU\� G�S�\�m\"�6�X��v\'��Ṫ\�ݙ��ƭk\�9�)\n\�\0\�\�\�\��f��`\�=|\�\�\�i1]h\�y\�4���\��m�\�x�<sU\�\�\�s\�&U�\�\��\\\�\�>0���u\�\��\�+��\�4\"z\�T+�z,�r�%\�w.F̋�\�+s�\ZhF6\n�\\�7��\�Yî\�`O��Y�.\�jz8\r��\�=%6\�\�~�c`�c�O*I_\�l&u�\�!\�\�:�ëB��S��{���čf�&]\r=Η�+yH�Q }\�\�!\�ٜ\�\�]<\���\�򾝰c\�@j\�>���\�+Y���\�\�I�)��\�\�X�`�h)�˒�FQ)&\�݇�R`��:\�-D\�l�Yzy�T��{|�p)�9�C;[\�\�\�\Z7\�}w^\�\�BgX\�\�\�G(KU\�\�\�h\�!W!s\�]��=�*���\��\�b7߆^xm ǡ����\\ڍ\�\�\�N�\�\�\�3�\�\�٥\�P@(�+\\\�*\�\�\�:�~���\���\�\�\�嗶+E�g�\�@\�)\�\�{$?�qv��1\�\�S�����\�񇨊<^j���JS\�\��f0i�|���tO�r�� LR��ׅ\�.\�vA{hm\�\�\�P\�7qM]�LzHR\�СfǕ(i9Iz\�\�\�\�\ra�dv��%��+$�r_[D\"\�:�Fx�\�х��k\�S���{\�KR�\�\�>t \��\"_�l�c\�Sq~p]�\��c�u.\�\�u~�\�Z}�y����\"\�+�)�[	��\�\�Қ��r�G\�\�\�2�\�,\���\�&\�\�\�W\�\�ˬ..:�\�vv�:I\���	e��i\�јIK*D�\Z\�R��k���\�R>Y��}S\�7˩�LOu���\�\��?$�1�(�3\�\�\��z,z\Z\�\�L��W�G\�?>�	�\�\�\�V����\�qxc\�\�\�\"O��ӏzu�>D�ϩ�\�ߜ\n\�\�ik|������\�\�~ZÍ90*\��\�\�s� ~�L\�͙\�W��҆���p��s�D�\"�\�\"�޽\�$��\0\�L�k\�0\��<��\�\�\�B�_�W�ӻ�\Z���|oڒ3��c\��!�	�A\nU\�Eq�x7\�\0�}\�\�\�\�\�{��\�>�n\�d�/\�({g�w+��h\\D��\�+\�$/4\'\�G0\n�\�\�\��\�y\�x\�@{=�?�\'\�\�U\�Qu�&\�r�\�\��;;�\�n�����ف�\�H��tN�\�i\���E��\�D-\�,o�o&\�1^\�8\�\�\�L\�k�g{�&^��O7N��5�/\ZJ5\�_I�w\�\�\�`�-J\�4S��r;�\�L_.DZi`DG5\Zy!)ŰI۹T�\��\�\�-�\�myc��\�T����RL@H��+�~ji+7�\�\�\�G?�ʱHB^��t\�5\�\�\��rő�iߥf�7$�9fyh淘Z\���\�Mߘ\\\�#;\�\�\�\�\�\�<������c?�5\�\�Z\�\'o�b��\"\�v\"}�u\�A!:p���\nD_��P1���o��ߨ�\�\�:�\�\�\�|��/���|�(�3�\�\\t\�\�Ȳ�\�\�\�\�&JޒЌka!Gj�\"�\�\�ꉉ\�5\�\0\�\�u��Ǜ��1@�c�\�t�\r��W\��\�\�#]�\�\�2�\�\�3T���|z�͘*)\�\�t�/9)Ɍj\�|\�~�p\�6���\�F\�1\�3\�|�LL�Ty\�\�y\�v\�6ޤ0�@Cs�\�!g�\�yw\rs�\���T\r\�\�\�NDj���gT[�o\�\0�\",�%���\�V^�bb\�͗W���O�΁\��)��T]�	\"\�\�\�F\�\�KD��Ђ85.x\�G��6m�j\�DzJ\�\�\��k��:�q��������\�\�D�\�\�P�\"�&Ox\�\�\nyQ*[.���\���O.������Tmݏ9\�\�1~u\�1\�a\�&wY��TJ\�L\�|\�,\����\�\��\��\�Xuy\�V\rO\�w�\�c\�F\�u\�\�76\�\r�\�\�-e�\�\�V}��_u�$\�\�=oTù�u\�<wU�\��(��)�\�\�N\�\0ח�p�r~\�\��\�P�P-HTL\�\�{\�\��;2J�w\�\�z3�_^�[$\�t\�~\� \n\�6ʳW�*\��\�\�3\'4	tdz�#*zbZ�N\�ي\�Os�\r�۾!q�W�rR�\n-\�6�A\�M\��\�w>W)��\�p\�~Ô�h�1�V��#�\�\�jj\���@_\�RF��q{keo�� �n\�T�$J�\�\�%8�]�q\�s�W\�w7�5\�l\�\�PE( ��J5���\�\�:�L\�u~\�\��J�L	�\�9a}Ę�f\�\�\�iŶ�v@\�\�R\���{\��\�\�)��f����\�\��5�WҐ�Mk\�o�\�#@\�X]~@3��k�\�Ppc�\�\0Vx\�Ȋ\�8%\�T\�7\�iG�Ga\�\"M^� e5\�o\�\�~�\�A�Q\��޵\�$q.[�J\�\�\�\�a��\�+\��-\���N�\�\�<�\\R7b\�\�f�Ւz$t	Ƀ\�3\�\�S\�pV\�}`F0/-�\r\�/\�6K��t�R\�S�C:�0Z\�\�қ\�D\�^�\0O�o)HӬ^D\����\�̕ �\��xW��^Z���S�ѩ\�\���1\�/�\�<.���\�(08�L4\��\�K���Y^\�\�ڥ@�O\�7�����\�|a���\��\�\�؊�x\�ڹP��\� ے\�\�k���jhwK\�>\��C�ϥ�(P\\;o,t�\rd����t-g��y\�ظ��\�\�\�d\\����8\�\�E�я\���\r��ۻ�h�_y��.\�\�\�A0\0\�\�H�\��,*Z�\�\ns�h�\�\r=L\��\rw|\�\���Q����ZJ\���B��\��\�\�Yw\r�\0و\�1�\�zd\�MPt,��H\�+Î}\�%\�.�J�\�\�b\�|d0I6DK2\�n\�\�ߠ\�N�7\"\���\�P҆\�Vȁ \��F�\Z\�2Qq�^(\nN�1yP�\�:_Ha\�\�4.\�y���O.�h#P\�! \�\�\r\�\��\�\�\�Ѱ���\�\�&��R��Z�\�}�^\�\�te�)\�!	PgD�\�+%��x��S\�\�\�\�fN��Xw�\r�@՜Z\�\00\���\�oï\�P+H�\�\�-�\�a;33\�c��\�|�v\��\���\�F\�\'\r�;\�u\�<�\��\�u\�\�\�ɇ�\�o�\�-dht\��:OT0_\'�x\�(FjX\�o�Z`|d\��\�_\�U��\r\�\�G\�&�\ns\�X�\�\�y�&���L���U:�|�RPk+Mn;�\�q�+V\n үfM�\�ؚ�\�$*\�\�)�e4c\�2�\��\�\�!N��\����\�[㏘y5\\\�_B՘�Q��J����zPK��N(\�Ĝ\��\�\�U���\����O!�C,|�\�Y�@B!!�\���U�=\�A:/\Z5{K\�P\�@\�\�\�.��\�\�=[�D�\�;�2\�%e;x<�@u?�\"I\�U^\�Pi�\�z\'�U\�\�-�P�vM�O\�:J\�\�c\�\�}*y+QX�f.�g�\�|\�e\�\�	́k{�J\�k��-\�\�G΢�u q�\���4	ԼQ\�\�VW�h\Z���\�/x\�\����\�^ARi�\���\�=t��֕X�ek4��T\��A�\�v?	�\�0��*_\�\�5VKV]�\�\�W?�M>��*#c�4\0>~�tu\'C��²&޵�@������5�Z\�}N\��&<\�P�VS�\��c��W�,\�\�\�\�<�\�f\�\�FB�r\�t\�^T\�Ҍ�d	��\�$\���\���\��^ݍ���~\�\"�8u! ��i\�ߎ�K�\��3D\�	B%�E\"r�\�&��\�!B��mM\�:\�\�\�W�J/!Ia\�\�ʈ���Tw�Z�\�+�<\�c�Ԭ�p\����\�޻\�8�]Y��B\��@\��T�n\�R��2��\�EHBM�!I#i\�F3\�.\�\�,�O\�z`�\�3\�O\�%s\�Z{\�s�d�Ԙ�~��FWE:of\�\�\�׵\�r�k��P�C\"w�\n}%�Qk.��GAX;Ƭϥ\��|0�]\�p�hT<�H�Փ[ʥ\�U\�\�Gd\r��\"Z\�K\���B*\���zU�b3\� �~N\�s�\�#�05\��^�*1c\�\��~\�\�b��\ngeE<\�d[�\�\�\�D�\�l�F��fH�MRr�I�\�\�1\�\�&/�S\�\"�1��\�Ҽ\�qn�E*i0\��Z?��\�\�f\�\ZD=)2\�z]d)Ш\��=[�|�\�YB+%n-Z\�6��v/�\�$y6f\�˲���1.\�\��nҽ\�mMSB�jc\nU^[\�\�T�j��\�\�\�\�\�\�r\"�\��\�J\�0���H�0Rt��)�:\�\�7y�\�\Z5(I�x\0��\�$�`s\�c϶�y3#QdM)�<*T��$\�j\�4�\'M\�\�1>!\"(nS��\�n�d�\�̂ԧhB\�\'��8P��\�EڗYW\�曥\�r\�\�%��~k�TEF>��4�ܙp\�\�C\nZ����r����m\�00��:��㩢ǴY�<	�q~d=�nR\�{`QP(~\�)�EVu#�\�\�\�,���MT7\�̓�Q\�\'\�v-\�sǑr��fud��`L\��k�I�\�\�C$,f�\�\��K\"\�`Ǽ\�\�\�|8:�;D�P\�D���1�@|I\�\���h@�)�Uʷ)���9,���TzՓ�4\��d\�8�pf>�\�*�{�̈́�a�\�J\��V�\�\"�o\�X�I�>?\�Eo1Q�\�q5r\�R\�\�\�`\0\�{м\��x�\�u&\\\�\��8ͷ\�\0�\�Q��U\�Q)�`_��B\�o�\��\��[\�\�-S\�\�-�-�MbG\�\�q@�ƀR\�z\�vo�\�C�e(ުN{�ay������\�\�S+VA\�\�\�S\�\�ɐJ\�-w�\�\�\���\��5ڣ��hZL��\�Q	���:ƣ�\�cp*}|Ёs,+\ry�\�\��\�N�V�}�ڟc��\n\�I,؀_T�i��Tc\�\�g[�&1w\�]�\�8\�\�\�\�Ծ�i�\����Ǝ��\�\�\���H\�\r\�\�\�\�,Z\�U\�Ո_S=n�\��\�\�\Z.zt\�u�\�p�$\\�\�\�sV{\�\�i\�IAd\�u��J\���\�\�9�+usQ[�ץ�kf�і\�\�B\���\�S\�\�C�\��\�\���*Xϔ_G0���\ZD4F{�x\�{D�\�Yd]\����\"\��\�H��\�R@�VC\�AYg�ţ�\�8ͷ�%D�2wM_\�\�Ms�\� ]��\�\��\�2�{\':U\�\� ��\�\�.\"�\�wV�ЬV\�:\�[\�\��\�-\�\�7\�S#Fe�����%����)h.\�Қ�I{%�VT�j\�\�\�sW ��^\�S\�aQgG\�p��b\�?v\�\�\�C^��\"�	�\�I�g��6�\�n)�Զ��\�\�\�\r��\�\"\�m�\�4\�		���\�99#���t34\��C��\�\"�\��t\�\�\�\�\�\���iA�\�8\�\�PRM{��\���\�r\�:fV\�OŊ��P��˥���\�\��\�\Z�7box���4`��0\�e�S�H�-�\�2���ZDu\�V&�\��Pfѷ���\n$\�i��ݣ\�	��\���g\�-=���RZ�*P��dĬ\���֤3}D\�\�Q!2��%̔[\���+\�ae�&�gĦǠ\�\�;��jFA�7XUA \�\0>\�/\r�+S��\�\�)��\"\\dE\�\�+�BԤ<\�?\Z���\Z|�\�b��3vmT�\�\�D[�P�F��aW6\�c$\�@yE�\�\'\�U%�\�L\�E\r�_Xh�yv��\�,X�ƞ�>��f�[\�xI��\�\'i��+�M7\00�\�\�،��զ��\�N)�\�q\�oX*6���X*qU!�(\\CT	B\�W/�46w�&���ro@0��\�\�\Z�L�\�p\��q�.\�_��	1�ݢ�\�\0\�|V\�vq�M4WAB\�G�\�\�K�w,%�\\\�r+\��~\�\��y��а\\�w�ys\"H\�l�@~\�jRb\�\�j꽱��\�8t^�n�]j8��\�/4j�lB\��	c�\�c�<�����&r\�\na��5R^2�c�<��Dm\�,&\�Hzt\�f�J_\�*y\0\�A�ʴN>\��,\�,\�rl*#k\�{\�?\�ω�\�\'��o\�`���\�i�	\\\�t�|Xs\r�Ր�($�\�9(�\�\��v�,c�t\���\�\�8?\�`�\��\03q��6���x�}\�8�<P��\�\�]\��v\Z�\�\\v�&\�\�%hm��\��\�m\nDXi��.|ǉ�ŜL5->W�\�\�\�xA�\Z\0\�\�r�\�X�\�\�\��3\n�\�\�\'~�,�.�\�\��ڂHU>d؜\����\�\����M��\�-��\�\�\�n����$wE\n�\�}\�\�A�2T�ğU�R\�1�\0��P\rH\��Ҽ\�J\�s\'L�yT\�\�u\�ӓ1\�3�bLS\0\��a\�\��*NE(\�\�7~ɴ\�\�\��W\�ӵ�\�\"V\�F.+\�\r�\�!\�X\��\�z\�\Z\�\�\�]J&\�j�a6:2޶Q\�RL�\'�9\�\�f]�d\�F5��\�V\�\nW\�\�\�dO\�@\'�wJY^�N�X~\�+\�=%؄J\Z-1ꍏ˨�+��\�CM\�\�l��\��\���\�1\�nӦ\�^淩 4yp\�=!\r?�\�\����Tg�˔,;\�)ZO4\���\�㾏\�ɌA\�ֲl\�\�gՀϛU\�<\�8\�yA��WM�G|\�ǩ>�:\��9��y�h�\�t\�\�i\�HN)\�w������\\\�&���]jo\�\\��\�{o�z\�\��q�ʜ�\�y�Kr�d�Z�K\��!�pL\�M!6�)\�h�	)Odk\�gg�l-mC\�\�Ƞ\�\��2%d+4yZ��\"A�\�t�\�\�m\�\�Ocד\�\\J�P�o{�%Q\�\�	Tv6N4^����Ҿ�&\�Po�C׸��\�\�\����\�\�f�\�S,%e� �\�OG\nz�Wdb\�QX&6V��$v�\�\�/7�\�\�7���w.\�<s@\�\�*DG���P@��g���.ei�2�f�{�A@\�\n#x~��/6�\��żP�\��Ȕ;e��Xlc>�?u��G>�+^6¸[ң&\�3�jN9Kp�\�y)Ne9Wb��\�G�҉�\�ܨRR��$H��иD�!]�r�=Qv!\�8.]��]H\�NV\�\�:�\'|\�y\�\�/\0t�Ĭ�\Z�\�\�Y�ժ\�8�2)r,.#*\�^�(T��\�QlK�\��\�[�рV��6>F\Z\�)\�_�t��*HfY���\�}h�3\�I5\��\��\nģ<��fn����,u8-\�D3�\'ĶSL�o\�3<�䒏�:{n�DsfY$b*?q\����L��(!�\�x\�P\�Z\�\r������ό�\Zo\"\'�\�\��\'mo�\�bu\�RL2�/\�{)��\�c�`CG�6Ar�\'\r\�<\�.kTad\�\�/�7)\�pl\�TII}5+��\r�Ӭ	�cz��gYT\0�\�\���\�P\�\�\��/,�Y�ջC\�\�*\������5qe��\�Qd�0v�j\��7\�\�Vf�A�y\�\�\�\�3�)\�\Zs#\"�\r�PM\�p0+�ܑ̭{w��\�l\\\�TF.4\�3\�>[�*U��\�I4`-��Ԅ�\�BU\�Y>Ȫѹԯ�l\r�,\�\�M���^\�\�7�2��E\�9Lbq\�f\�\�ki�\��\�V�m\�xws(G\�R}T\�0\�\r�\�V%T!m�		�Pηx\�Lk\0�-�\\\��X=H�Ӗ \��a/�\�\�\�Xg\n\�t�Ș�G�6\Z�H\�*j�/s�ij\�\�O�2Oħ�\�8e\�-\��R?#8�\�U�#�\�R)�թ\�կ�]T��\�\��Y=I�Sk\0�\�Q\0~\�R\�r\�B;��șjDȣyou�\�Ű�(���-#\�m=�\�\�)��3�EI\�\�Q�^�2M�\�W�o]u�28C;m۫��Ri����00vz\�E.4��A#�\�\�3ȍ�\�9�Ǆ\0?/O\�C\�^\�\�\"8QP�\Z\�8\��d�\�5-\���\�`mr��	+R��;*\�U�\�@E9iS�W.�ܦ|���\�S�y�i\�nn\�_\�\�\�:Z�\�8 �\�\�=�\�˒�5\�\�yT\��)� \�G��\r�\�p��/���\�\�?9)�\�\�\�T\�n\�2v\����T��5\�o�\��Y��3�4��G\�2�s�\�f1�F n\�\�\�\���9zv0\�U8#߇`\�1_&�\'\�Q\�C\��.p�\�L\�ɐqm\�/\n\��~\�,5L��%C�$$\�\�MJ\�D)1\�]Q=UMP�T\�~\�\�\�O_\�VK�[\�L>i�\�l-\�C\��`�ws@u?{�^�\�\�=��K. e\�W\�\"r\�\��\�\�@C��Ȧ\r-�b�3��:\�. \�xt#{)\�\�^�\"\�A\�\�\�r~\�_\�O�X\�lNA�\�qU\�\��un\r�\\u�z<Y��\�\�\�O߂\�B�/bF\�5��7��d\�\�>��q���|g�Ǭ3\�W�XH\�V2��cK����t\�)h^�j\�@j\��sد\�N+\�\�ق\��o�Ʊ�VB�Z\�28)\�YN�\�\�7\�\0d�OϨ\"�]�zTS\�B�z��;]��˩8\�؏��\���[=y)�\�l7S\�\�_LJI��\�l^D%YR\���m�d\nc\���wV�>tUJ(\�G��lӦh�\���v3h��p\��\�\�Ǽ+-Z�\�>�@6��Q�!�\�@n\'�c\��@�\�/	e�\�gڝ\�\�\�56Ԍ\�J\\\�YUC<i\�\�C_00\�9־\�	=� �Ɍ\�\Z�pȻ��h�\��;5���[�\���\�xѡ�N�fr�����x	�w\00\r\�Far\�%p�b\�۾\0�a�/c�[�\�\�\�v[��\\��\�n\�wM�5$�\��\��0t�.�b\�ff�RG�K��\�4���zIѨ\�\�\�\�\�|�9\��\�\0�)\�Y��`\�J��ڤ�\�1~��\�0r\�e\��3�\�D���Ҋ\��8\��\������C�\�\�\�p�$\�u\�\�O�\�gV�\��>\�1,H\���l\��i\�u�[E\���\�b�S�+��x�c\�\�uI\�O6A��\n�\r�\���\�6�M]\�c�-@\��6��.\�ι\�w���Wq�9��\�\�FT\�\�M�\�0\�DRw]l�OX\�\�I�^��\�\"D���\��H1��\�\�\�T&�\�i���\�:�0\�ZV��5\�(�ی��6\���¦\�\�\n\���$6\�\�\�[m6�8[N~k��G]�Qa:ZH7)\�\�T��x�\\,�f�(\�́�\�6�� \�Kֻ����\�UX=w\��x�\�L�M�~2\��t9B��\�r|&QNo����OdN8s�\�`�X%H�q\�l���jI\�0e\��ɍz9�\�\�;y	Rk�����\�Dw\�\�SB�l\"��3\�\�\�A���=\���\�\�c�)\"e�Uc9\�g����ْF(\�t#\'a-1={n\�X4\�aQ},��G|\�\�\�~9fzp7u\�\�8aܚ($\��\\\�\���=\"\�\�%w\�\r�-��t�O�\�4\�\�\�X\�\�����\�(\�\0\�\�\�-���\����m�\�\�\0�\�\�b6�\�otQI�\�g��c&\�	��蹔��\�1@�\�g��^vzZ��\��\�+\�/!-vSYܑ�O@����z�N�E\�OU\��\�l\�\�.�\�\"\�\\¡�Pj\Z���i6*\���\�_\�,���	p�ˏڊ�U�ud\�\��;�\�\�v����=\�\�\nƼ��\�\�4�\�\�gA�î�U>�\���[0�U!`x�3ك\�6\�ɯ�\�\�h�\�z\�f*�e�1��ц�\�{!����\�ɖ��\�O,��)\�1\�Eu\�\�2\�\�\�\�Vs\�\��E��.-_�����>�!6����Ƙ\n�kʁhw�yr>��XJGtw�`\�\�\�6�D�Ṳg\�R4>�uu�}ț\\m�\�7\��	� 8]�\�sN_\�f~��r�\'�Z^b3���8ބ�|\r\�W\�\�z5�\�)�cV3�?\�%\�X\�kl\�^Zg◬��2\��\����Ƈ�\�P:\�8Ť\�~\�g�\�\��\�rZ\�l\�k\�W\�r\�|\�f��˽a��\�z��f�i\�� �\��7�6�F���\��\'\�K�a�\�\�\�\�W�\�\']��K�\�7�	)?\�+�`CM���\"\"͒��ױ8��Z�w�\�ك��K\n����.\n}*\�\�o\�Q\�\�`,$_py\�1�\"��P�\�~\�\�Q\r���>�!YLyk���il1\�\�\�	V�WQ\�\�ԯ^\Z���W\�^<:��@!3]\�\�Ɣ\�\�\0�l\�\��ga\Z\���\�\����.�\�׺@[\�6U\�\�\n\\u��\�]\�H���pTA�@�,z\�-\r\�W\�hc9\�\�D0\'l.C\�e�\�bD\�VkC)j\�K{\�\�\�t@�\�\�[�x�\�W�_q\�2�TFg].\�Ix\�@�pC(�\�db�\�m�l8�&\0m#�Vc(DFt�M6Iv���2�\�\���\�f1�\�Ξ\�x��-+-�|\rI�����i\�\�m\0�\�ł\�am��!ӱ\��\�K%�o�&C\��3��ƁoJK\�xS���Knz�\�\�fJ�N\� }\�\Z{\�k=\��E2\�5�nR�l\�\�쮆X J��䚅YǞ�\rƽ1�7u\\��\�\�)9a-z\�Hq\�\�v\�g�`\�픙&�N`��W\�0��#۪��\����=E�Ϭ�`F\�\08A\�i	�\��(0�E\�TI۠�P�7\��&��i�~\�-�m\�\�Ƴcu^�\�:\�P���,�\�_]�\�\�8�\�\�7ߦ5q\�˶T\�^\�1�\� 8\�s-i28\�`\�\�CbG\�.�罰1^�1\����!�\\L/�Uc��\'YN!\'1��N�&!#�U�|\�\�4�l1IV��j\�\���8[��\�\\VF0�U�\�\�\�U�A�?�\�)I\�UB\�\�R\��b9��\�0\�գ\�*=\\Q\"W�+�Z�\�)��/L\���ʝ���ȲRFz�\0Z�V%��,ݓ\�J.\�\�2\��c\�\�\��Τ+\�?*]��2�\�r��LÓ�6L*\�\Z9XiC\�X��n�ÃD�\�7/\�Z\�\�9 ���z\�P!:�`I@emL+]H\�0\�\��】��y\nm�d�\�\�-�\�ىX\��\\\�X0}�x\�R\�85\�K\�\�s\�(�+Q2NY���Ѫɀp\���]\�M�o\�#�\�(\�\�ظ\�[-\�@+�{�xT\�c�\�s\�9�[�\�S�}ñ�썭M�l\�t:_\\\�m\�\�22P�\��\�\��A��\0\�6v\��\'\�\�q\�\�\�qy!\��;�>ؿ�m�\�G�U\�}LM\�`\�\0X�\�cv��\���\0\�ZY\� [t\�<\�\�ZU�	R��x72��\'O9\Z#KIwp��eT�^�Um[\'\�����nB�x4�-�k�\�\\s�}�D{��-I۵�n3W���a��S&͉\����#57ӟ�\����H\"\�\�\�)��׷7�\�\�\�\�\�qz~\�F_�\�\�\��ɛ�`:\�q��y�N4���\�\�\�\��Vw\�F-M%\�\�\�6�\�=3�a\�m�l�U`aVm=;+ww�ƔԦ\�4Tu��ίE\��\�n\�ڗX�+(\"�\�޲\�\�H��M�\�\�<$\�R���\�	=\��\���b`ؒ꥟�����\��\r\�\'Aa$p�\�.5S�\�Ȃ\�fYw\\V\�A\�\n\��/)��[���zi�K�\r\�v\�kgdq`�$r�V�V�\�w\�|\�)�F-\�\�i咋�Lt�X_��Q�΅�\�N�����٤�oiN5t��y�2T\�U\�k\�\\�,7ѯ�\�\�?{)��r�O\��Xkrp\�\�4{\�\�%��N�He,��u\�l�X\�\�l,�0@~T.�ĞK\ndÀ\�2\�6�\� �b\�\Z�hW\�UNa(H�\�\��Y?\�h>\��Y�\�\�=\�l\��#Ɖ��e=\�\�@\�	���<g��E\�+�\��\Z\�z6f�ɟ\r�K�,\�r\�h�D̺�Vh)�Z�\�Z{.��\�o%�`\�<@�jR7ȕ�\�x:\�{:\�b)y%\�\�3\�|7\�\�i�ʏ֭����2C�d5�\r#_�� \�_4��\0M�l\�+5��\�O\�u\r�e\�^�\�[��\�>=�G�\�~wի\�^L�\�\�.�K(12\�w�\�m�Q�+0bh	<\�%z]Q\����V�\�Og+,���U\�$�\�\�\'ze\�?���Fm�\�;��	Q�Q8_3fy{�2\nT��pڣ\�\Z_q��@��ĥ���\���9<���\Z0\r\�\��\�9A,��R+\�r���@]\�\�g=V\�-�����B��h�aT?��\ZӾ���}�c��\���ת�\nk:�\�yj P���B���\����[\'��r\�\�s�\�Ŏ��#\���P*)\�s\�E\�p\�HL��aK\�\���\nB�r+�fC�KU\�AQ\�l\�\�\�#	-g���\�:¦\�&�\�O>\�u\����}�w��c_ 1b)��\��\�sߦCh<m0��uM�\�1U\0�\�j\�|�-�8��.\�\�\�T�����\��\�\����l�\��\�\�e1�m�1�ͦ��\�\�s�FRH\�\�7���;G\�\rfp�\��W�`=(\n6�w5\���\�\�A8\�U\'H��#q:6V�\��I`��\�B�J\�e��\�&r��ݢ�\�8��\�\�hX�\�\��&\�\�XB�\�UFj\�z���\�\�$l\�F�8l�\�{\�!RI��\�k���7�\"-+\�*�&\�\�o�\�i}�-sI^�;;m���䄑v�:Sd�}̊��V��aHaB2n�\�0�4�\�\0�(��!,}:�ԭ\�A[\�\�\�\�\�A\�\�ՕE�\�\Z�,��\�\��E{ʱ\�\�\�,\�2O=3\�w\"VU%\�\�7ѷk\�\Z\�($J�-n\�\�#6e)wŦn1n\�S\����\��Y1䬏\�Hj\�tO�[�w>\�ewqT�Ú]��\�#,ĕv\Z5M1�*�\�\�X\�2��\'�otR\�\��SK�h�\� �8���R�Py1=8��5�O\r9vS\��C��Φ��i��\�t\�\�)C\�]l\"Ⱥ�\�BS�8�\�\�@{���_P?\�Jߊ\�t\�^��1�\rAN\�\�\�\r]���c��\�g\r\�*�>\rR��l\�k\�\�Ba�3�\�us���Ba\�2��n\�a\�Q�\�6�\�M_\�\�Ո\�z\�\�\�\�\�3\�\�P\Zr�\'\�Hb�.��i3��o(Q��\�\�R��ø?=�\"\�\"0;��\�a�����}�}\�t�E\�dӓc]cTC)φ�\�~\�\�q\�Z��1ͨ:G\0W?�\�YD��P�x�[\���K�5mvGY��\�6\�Y�\�p�\�\rEͪs8�No�T8y��N\�9�S�5^�\�EV�\��\�j%4�&p:�\�V���3\�,\\���l�m&7\�!��6�0\�}\�\�\�5�v\�\�W�\�l\�\�l\�8>�Xb\r��M����ɯ�j\'�\"\�C\�G>ZG�9�\�ARl�\�Z�kִ\�\�N��h�:+C)�o�2֨p1yrU�|�\�P>.��\�,Į�@\�\�@݂\�\�\�H��\�N�EDn8\�V\0\�rYz�q\�v\�\�NM\�\�e\�O\�C��\�c\Z6sR���,|����\�,A�\�|A!���q\�s3@�\�ץ9�L��!�xH�~�\�\��\�\�ܚ\�]lXk2)\���1)\� Z�8#kr��Ǥ\�h\�\�G�U\�\�\�U/�\�\��搷s#q�8���^K \�f�\�\�p\Z@��([+�\��@G�,T�@z3M\�\���<��zbz\�R \�\r�\�3a\�U�oĪ@��w�\�\\�\�\'[NN\�\� Q�h\�\�5��9\�^�\�\�\�9r�(o\�F�i\�5��W0e\"\r�K\�\�J���7�\�\�\�{\�ʂ5�+�2]/9T��|��`\�vYu�\�hm� ��CJ�(��oi%N\����f�(�,f�ng�\�zG�a�Ϭ;�W\�٣\�,\�V�B-E\�>\��Tae��C)w6(�\�>\�A�V2?��\�Q\�d�\�t\�\r;�Ng\n��\�tyf\�\�W�_�P��\����ꖅ\�]u����_/�\�_\�rVIy6���\�؇\�\��u\�=J���.�N�y�ȓA��t\n�\�T\\��\�\�\�UQp\�rK�Ţ\�}�הu_�iY\�ޠ=�^P�\�\���(��\�\�\�y\�\����1}\�*\�e\�\�6\�m�m�\�\�\�N\�\rɐ\�k�\�㈶:�X�\�J�\�\�\�J=-N�\�~6J\�f`\�\�~ׂ�rK�\�wqЃ\�^�h\�\�\�P���zg��x�c\�6Ɣ\�]� \�\�\�u\�\�&\���>ZH���\Za�\�2\�j\�ǜ\� b�ol�F+��s�9�\�ݎC��6\�y�=g\�6�/�>\�3\Z��\�\Zpю\"�XĲe�\�.\�b&M6\�Gc���<\�f<��\�1��[w�Qk�\�\�`�Rc{\�7F.ĠXe�y�Ł\�i�� Cd@\�\�\�j}-<;�)Y\��@�c�\�zUF3/u;\�L�/�B[\Z[�YR\r�8\�+\�LII��Be��5\�\�iH�\�\�*�k�c�&\"��eY vu\n\�\�s&�\�6\�Ta\�t��*���]reUS��ȧM��\�dZ��`VOe\"\�=GZ\�:V�S���Ǌ<\�\�?��xn\�K\Z\�\��#u\�IO�\�l\�=\�`�W��H�	id\��-�K\'pz�\���\�\�E�0�Q\r$t�������\�\�\�\�h�(��+�\ngG\�\�AӌY�\��\�\��q\�%]c�2�ñ}Aq\�\���\�Ir\�,Ŧp\rܱDF�`{\�\�<�N\�q��LؾwL�x�%\�m`²֌`^cI�o�t\'\�vz\�nP��jWa7U\�`\�J�ʮt�\�o\��\�0\����1p_\rٍdˎ�`@`��\�X�wU(LIi\�Ȃ\�^L~l\�Q����\�,��b�\���]U��o�-�q\�+��+\�gxS{�\�,\�O�1��\�\�\n�N\�\\&�v\�6���\�g4*_��~\�\�u\�LFDzY�ɢ��;*��2�=ǳؿF�\�\�^t�w&\�bz\�0��ur���ކ�B�\�䄎6ZUa\�\�a	#$\�,\�\�\�\�)�\�1\�\�\�.\\g��\"V�\�\\�2&ҹ�\0O��\�\�Έ\�a9#n�nE�\�M�ߺ`���*UKч\�1�%)J�X��\�\�2\�5J\�j�f\n()�\�_�Z\�B\�IF�\�x�\�:\��\�\�SPQ�l\�U\�\�w��\��<�k\�r�\�z쬩�]sn�f\'츘7+{�\�\�,ѯ�N\"�t�b<T�\�\�\�\��W4�+$}Eg\�fbk\'�A<<zmѦ�h���G\�R%=�y@�o\�@(7\�-�I�\n�\�	�\�;,�Ӳ~s�����\�m�d9\n�e�\�%vĉl��y𓽿�\�0\�\�=�+]�\�fN�!�\r� \�:\�Tl�z�hϼ��>N\�r�>\�s4+\�\�ם�eޙ%|ӆAO*-���C-\�S{5\�D�z\�I\\#\�^eDP.J/(Ʈ�^\�^�Q�M\�t��m\nn�\0.l�\�k>�@�.�M\�Q\�\�Y£�7.\�wV\�:�;T/�3u�;㽩�v\�).6�J.��{q\�\�\�\�|\�h2\�d��i�\��\�\����70W\�3Lʰ\0�\�O\����m�H+xu�9Y;cٙP5-��=\�\�Qe� l\�0�F\��X���K�Dr�\�eX\�7d�0�p�\�ab���W:��)�Yq\�\�#+\�:���\�l�\�ʄ!�\�P{NI�\�\�z&Q\�4����)L\").\���\��f\�$�\nSR\\s\�\�MW�iA\�\�U+ �P \�q\�Ec����k\�\��!	N嗭�/%���\�\"Zj#�.�\�\�@\�\�J�\�΀�8a���\�Z(\�r�<J.^4\�v((s|Zx5�곣n����Lh\�͓�\�ƚ`\�^\�αk{Y\�ԕ�+Mm~l\�%$ |�\�p�66.f\�ݕi3b=鈦�p\�3l���@2���\�Hdb̄Q�j_��3��0\'�kdt�\��KC\Z�]L\��\0�fmh1��L\�\�a�KeVCt��\�$.��fp�U�\�9�<w\rI���|�\�\�I~^����\� R�HL\�\��\�5\�-/&e\�\�\�YJ�C!�Ġ\�3\�W1�\�)])�Q\'S!jTt\�\�F\0*�|H�Y\���X\�g0\��r���!c���`\Z�b\�\�\�.y\�(t>S%\n\\I��k^\Z�\Ztâ$�\�\�\ZO\\�ir9c��a4\�\�Y}��\��6\�TMQTS�}6\��\"tk$\r�\'�99$@8`eo=\�\�	\�q\��m\�~\�vi�\�$r�È\�?�L��\\�G�#u�y9[y1�R\�v_$\��z��bo\�Z���\'ey��\�I��$I\�\�\�cj07�����nM_\�s��s\�����Y\�7��\�I�3Tmgڏ�������Y\�(�\�\�\�;w�*\�˳�f�)��г\Z��b\�	)l��h\��\�V��M.g̗��@ɲU\��]\�0\�E{\�%C�DaH�t\�]\�N\�1XOx\�s�l��;P,N\�\�p>���u��ǔA\'�\Z\�\�Nsh\�����\�q�\��D�\�0\�\�w<I>K�m��n�\0\�\���\�db��\�f�����\�?{`\Z����xi��9\�3\Z�I\�\�5����n\�\'|m\�=\�-r�\�L�sq��\��0�s\�9e2�\�B\��Uf�\"b�-\�\�T\'eJ\�>=�\�\"�@vm�\�κ\�\�anz�\n1oԲדCP3��\�\�:$6tη(>\�\�\�\�9�?\�j�dj�\�M�Q�\�\�e��1m��tgR\�\�W\�\�\Zr3o6 )�.LBګ\�-���\�{\Z@n\�\�\�	sN\�0�C�+\�\�\�Y\�e>$]\�$\�QMEi�d�l��UX\�\�a�\�֤���aV�l�k�*\��	�J|��q=6E�=k\�D�\�\�,=\�ѩ@ҏ\�\�ϊ]{4���US�\�w��\�p��\�f��\�\�F\�WB%�Fn�XT��b&Jx6��٣t�-�F\�\�?���\�\�`/�U\�\n@^\�Z��2\��W\�纟�\�8\�}�%VSm\����ʝ\�\�X+\�\�ٺ%�q2�!汍\�I\�+\�2��t\�^eKtG\�AQs\�\"PQI�yP�d�\�V\�MI\���3D\�E\'ӨpR$\�\�<\�I\�\�\�	��{\�\�*\�R�0\�G�_L\�d��Q7�\�D���#	\�b1�<�kfQJ\r`�\r�BӜ\�6?(\�t�\ri��Z\�)\�­rVy\Z��wp[w���7\�\�\�E~�u�5&,�䭗<�\\~�G9++T#P���\�A;\�\��]�A�\�\�\�(kv\�0C<Y�iX\�f\"\�\�z�C[�	\��wxM鎶�8F\r\'��+EZ\�\�M\���\�c\�\�\� ,\�_=硆7�M�S����!\Zy\�ꗦ�[/�e\��@E.\�\�\�+a�S9W�\'�\��@@�P?3\�W/�&K��ʺ$qp��\�N�����9>_\�w\"v��thqv�\� `&\�Σ{Z�\�E���\r�\�	H�\��)ꅼ\�\�\�ǉ>*�\�Hɒo�tDS6\�^\�tگ\�3�\��[�\n4�x\rY\�50K��\�d���񬽀\�eT�\'8���5`isj\�m��\�r�\�EM��\'\�}f\\\�>f\��yh�uĪ�\n����\\Ɛ�?֌ڷ=��%���\�sV#K@f9KL�\�\����\\R3���\r\� \�sz�mk}\�)軗h͹FZ��\�j=*y\�\�4�oWo-�\��\� %M�\�I�4\�唇\�\�9�X\'XK�\'-wg���\r�O\�l\�A�\����\�\�\�\�(v�*�\�[.F]�\\��\�\'IsH�52��r!�\�u\����\�\�ǡ r̅VvN�1\r\\2^hŉ���\�R�\�]T\�i�\�\�\�KK�e\�\�8��b#\�9\�*\�h\nڼ[Y$����\�H]D\�\�8,\�v\�5m�yb]�\�\�COp?MP!��{�zh,ᥜ\�&W\Z LS�(Sݟt\�\�Ŕp\�Š/��\��8�f1Mtn\r��S@Y_5l.h��\�\�Գ\�\�U�[1\���\�\�\�\�#c\�-h]\�1\�\�d\�. \�D\�0ZH*\�uy\�jIj�TOV+jʡ�E_Vr\�E#L�_е\�1Ң\Z] N�\�\�j8\��67\�LU�,z]�\n\��	$+G	6\�d\�<*�\�\'_}a�IJ�\�zDE�\"�,	\�LV\�\�\�\��D\�;s�\�\�\�\����\�sZ\� \�\�\�\�\����\�~?<\�ʒ#˳��\�\�Zw\�@\ZY\�Jum�99Ȍ&\�r\�\�\�P�\�sx�\�G+\�ya�KO@\�;O�apl�I�{�\\�\�y5�mc9!3�mD�ɲ\r5��e#1����IƬ��r�D���V�ց����VC<���Hg�0\"d�)��\�\�\��\��d\�\�s�\\��fy\���4�qV\�p�?V#\��n*\Z\���\��;PY\�*���{�t�\����A�j�%�\��eGI�\�m\�=#\�\�\�~(�Aƹ\r�]����\�9z\�dǚ\�j\��Q\�i$\�\\\�\�MJ\�h\�	�\�Ԃ;\"X\��ɖ�\�!C�GdR�@�\�\�02OY\�h���\�T\�F.\�j\\\�R}�8]`��\�C\�\�U\nJR\�~�&F\�\�\�\'C�h1	\�\']�s<\�\�`W����.)��j\�Tkv\�m}e\�)\�X�\�\�W��Ŀ,�p\n\��\�\nI\�f��\�\�2FD1%�o�NQz�ǃ\�\��R\Z㔂\�A\�+�\�IpT���\�ڃP\�S\��ƞ�3�Lk�I�fx\�\��D\�!	c4����������\�\�[\�\r�:�^쵚\�ٹ\�\�\�[*�8\�8�k��@��\�L-Y#�0\�IF���͡cɻ\�֞\�>�\�B9n%��{��T`�\�F�@i�(\��\�\�\�ںBC�\�I��,\'\�1���V-r��HdJ=��;L\�I#�\���K\�\�QuŨ�\�e���\�\����0�\Z���N�,�*�h�v\��,\�W\�\�O�#\�9-\�A�d�+E��`̔�2\�T�\�S\�۹�\�:\�<�J\�\�\r�\��0o_s]\�\���\�\�<X����8`\�\�.0�\�u[\�\"�>\�\�7�ZN.v����\�|�\�\0\�\ZW�\�!o\�}��+\�\�lF�R.�\�_XA�B�\� \�@޲\�\�7����dG���et�� \'i\�훔�\�ݕ뻶�\�P\�#�+Oي\��\����\\��e#�\�\�\"\�U0sI��͔sQ&��h�&w��\�]-+\�c�\�\�m\�\�[\�\�0�S9\�\�d��\�\�\�Ţ6�\0z�j}��\�&f����CB\�\��C��䤜d������bx\'Ԑ1j���v��\�u\�<xۄ\�\�1\�aeW\�_\��\�����YZ\�n\�\���v�K3\�$}�?�\�ɢ�(\rЊ��LJ\�[�P\��R{Z�W�\�\�\"n\�z>��e]l\�\�v�\�\�yz\�\�$C\�\�˅�\�G\���ݎQ\�nF�Q�)\��S�;\�K�\�m2\�l\�\����\�\�\��ym͚ǎ\�p;$E!\�\�Ӣ�Ltx\�,�*��L\���A\�~��a\�^z.�-\�j���3Y]2\�?\�L�Crc��$\r�\'S�e��m��c\�2x̰^\�ҡI��we\�*�z?_�P\�A\�\"�\�2&\��,�f���Ӳ\Z�\������}\�\Z�bV�\�\�\�>�.��8D%������Z�aQ�\�x6c Y���2\�\�\���\�!\�\�\�*�u\�bpCyQ�qRBԯ5��e�ae%!\��T\�\�n�:v\"}V\�.\�\rP�ؾ0�6]e6}E�a4{,���od7qk\�\�\�r`\��\��\�\\Qjہ�\�/\�Z}\�\�\r\�\�`B*^K�ZA\�b�\�aZ0h�\�\�l\��\�\���0*�_r�๯%Q\�l\�b.Mw\��Ž����WO>A��`$\r�s�?�x�\�m6�\��2\�\�\�r9��\��N�\0��t�/*xZ|�\� �\�0�\��\�;e�q�\��\n7+eP+�Ң\�E4�ؔ$Z�\�ME�\� \�;S\�\��׉s�\�־�\�>\�Ks\��z�\�l�\�\� |\�ϻj\�\�6�\���\�\�AN�`z\�\�:+\�k\�4k~\�Odt#s��2�#\�r\�Ҵ-*\rOB���\�X-(\��\�\�\�\n�+H\�Gշ��J�QAH�zA�CP�l�q��&!.��#D\�\�iު(#��\�?\�S���F,`�G6�7�\�i1ls�S��,v\�\��42\�y���\�\�;J�?+���O�\��\"}b��<��烓\�}\\�\�-8\�Y\�1W\�C[\�#\�NɓF?ez}\�	�\�\r���/\��e�c���� J ��\�\��Qzزq\�X\�j]�wa����{\�N\�H��f��.?xS�\�ǁ\���ԋK+Wo�x8,�\�Y�g\"iE-`!�d\��\���\�3H�iϧ\�JO)��@/\����\\婬\�|D#\��х\�J\�9g2�~&)\�f|�t+7��\��S�\�pa�*˹�I\�\��\�b>f�qK�\'\'�Sr�Z\'2Jh\�0�����$t�=\�<\�<��&)J��.�\�\�ipVԩ��\�\�`\��vF�\�d��������\�\�R��ɿr W,]\�&��\�X퟊��\n��ln��a�)Ѯ3�]\�l�p\�@c\�\�\Z�\�G:G\�{ڗ��\�\�tA�\�\�\�a󴼬v\�\�͜\�}��Pg\�\�\�J|Ú\�\�\�\�R��(�\�ʋ\�\�\"PY�\��\'�H)8\�ir�S\�rP�\�\�vԂl�I�-s�\�C&\�ߺ\����b��2�kѩ[�1e\�\�r\�V\�4��a�+�\�\'����\��\�D��^1&y\�:\�EP��݁M87\�(>Mj��U\�\�c�\�\�/\�wƒ�3��\�62Ds��-�Uzn�\��ia[Q���/Ν=�F��\�U\�lWA∲�.��ܴ ﺲO\�)�\"5a\�\��0�\�\�r�Ϻ6X-f\�\�/��MM8i	��\�`�\�\�$\�J�Y����TTFZ�\�A�2�7�����\�\�b<���c\�u8=\�E\�u�֌���\�\�*�\�a6qmB���\Z&\�3�]\�|!��4Ua����� \�\�\�*\��*·�\�ǏfdU\�\�Ը�\�\�ʹ\���\��\�5#�\����a�è\��c%\"\��$\�⩁\�ȫ\�&�\�f\�wK\�Y\�\n\�f�/Le\�\��\�6$��;��\�3G���\��\�\��4\�N�#�c]Rs�s幠�5\�<��̟8L[��!\�\�J/7<<\�\�\�u\�>��@5c��裸=�q�p�Rڎݙ\02m[t%i3G�٬G�\���\�p�@���a]�ϰ	�0�Ox\�՘�e5U�=\\>Z�hD�VN\�x���ʜ\�o��\"*\��\�� \�@\�\ZA\�-ø�g[�8�[;�\�Z���\���/)�M�vT\�\�\�P-im�\�.\�[�B�J\�h�GR0����цڙa��f\�\�/\�ph�\�\�Љ��\�\�«�+\�Ԇ\�/;C�ٻ��\�z\�\�$�\rW|N\�?�\�)z��\�)\�|PqO���!e�\�ؒ%\�\�\�ĮՖ\�SOY?Ѻ;���	�\��;�אT��Hg�Z]v0�\�\�,��u��U���R�O@Ȉ>���\�\�iw���GqbQ�n\�eg�\n\�\�\�Q\Z�\�&��r�.-4�\�d\�%\�\�\�T�>\�\�8-\�)�gNw�M\�X�\\��\�m3\�!�8?�8�iam+\�\�mC\�\�\0\n���\�\�#�0 �%K\�n\�[�m\�	�n�\�)\���s{4ek2 �u\n�R��v\�E��4\�E�.�LQ\�\�Ӆ��ʘ\�$�B�2�d\\H.mq�;eZ;H\�\�P�ᣒ�djG�}8�	5��}ff\\\�y���m�т�\�_S_\�I�H\�U\�\�]\0\�X\�\�-E�<3���\�u\�ޚ\�\�\�;�P\�5flv?��\�\��\'�Δhm�\�E)�W\�r\�Bb�\�RilK�\��3��8\��\�xR~f8��\�*,m�-��Q�w\�5\�e�O!�r��MO&\�ɩ\�\�:\\UL�j�#&��\�;,\�\�7��\�D�D���Q1s�E�ԯ\�g\�\�\�+�sC\�rU��P\��\�d\�ƚ}��\"e� \�)\�Gm\'�d�\0�\�\�\�;\��4�n\�\n\��*�\��1�`����(�>\�U�(20K�e���Ə\�B.��_�]V)�C\�V]c�*0����\�C_\���]9�\"9�)���\��@@0,ex�oG�d\�\��\�nL.({�\�Ou\�IP\�UI�\��?$\�}Q���0)0<\�\�C�\�ODC�Ż\�]4cS��h՛��̓���1-\�]\r��QI\�J����\�Ô|�:L\�$\�\'2�\�?m\�\�w�g\�1\rW\�{Aby��z)�0\�çva��@�4\��\�,�M\�*H}5�L�\�D�mM�\�\�\�I3�(-9\�V\��O3\�b@\�-\�\�\\4k�i\�`\�\�\�5� E\�\��$�\�Y��I\\�]EF}H���uL2\�F8�M\�}ډu9�]L�!\�z	[:Ƨ3,@1M�$\��)\�y\�L\�3\��/�>p\�@>\�prݎ15QZ���� 	�EkcSR\�\�s`�\� 7\��\�GW6�\�Ǻdooh��\�;\�\�\�.�VhOH\�\�\�xga\�\r�u��\�1}\�{x�1\�j�����j�\��Dywn�N�v�q>\�\n�wVPr��(��S^D���<Val@�M�\�\�з��/\��-��\�j\�D�ĸ��˘�ˁ���\�Շ��\rv\�V�bm�<P\���r���\Z��\�Hv,��ҧ6m?���[S�\0�5;�ͳ��L\�3&d`\�\�PĆ\n!b�B޳	�B�\��y\0�dv����w�L\�\r\�ϡ\\4v	9�P1\�У)2�\"�y�:��D������l�$:r�|Т�\�h�2`v\�b�҇\�S\Z\�=\��\�_�y��e�<��s�J\�s�!\�cv�i\� \�\�pc\�,7{gDV܁X`Q��t\�]��>��{\�\�\�\�3TUcFl��<\���m\���#\�	z>\��pkd�;�]\�\�Xg\���iA\�\�nt(\�I�8O\�Y�V靤e\��HCPC\'zQ�%�Hq\�\�<�\0i�\"�}1#n\�2FP\�V�ɝ��Ou�b��m\�0�(�\�B\n��#� v�_��d���K�	zknTC�\�\�R�f\�hA�1M�I`u\�Z��Ӊ�5f�d��\\9�\�<\�_�~�\���r\�Y�B\�\�\�K5�K�(lľf����\��x\�92�\�wF\�C��fzZؼBW\r\�?\n(K4L�����ٓ�\��,�U\�Ujs`�X��\�\�\�T\�\�`\�a+#�\� �\��\�8�\��g\�\�cD\�V�9\Z4�T@uP��`9��W*�\�\�j�s\���R\rĻ\�.�\n\�\0�\�fB脂�4\�\\\�\�s̍\n/\\-���~vW��L��W\�ɉ9\n\�[\�\�Q�d�2��:��\�t{Z�sEY6G\�6�D\0s ��\��!$=\�\���k\�S9\�\��.\\�\�)r��\�Գ\��1M\\�\�dI6ض^n\���\�����@�\��]k\�6�}T��NFɁ��\�[�\n\�Xd�\�cƟ]\�\r\�\�\�\�|n�-զw3\�@\�\�ׂ�??�ܟ�\�-��\�\�\�2�2(6#\"\���ݨ΢\�$d�M\'�	]�%i\�G`l�\�;\�5���\�ɫZ�==�\��\\\�G\�r@._Y�gG� Hq�\���\�\ro�@�\�r~e�\�Rdj;6\��-\�7;\�w;\�K\�\�HMdK��\�2l*\�P0*p\����uBص�LGdke+�:5�݇\�ʫOG��[|]-a\�Z�U>\�蔒��@&�7\�8��9\�!�W\Z\�et�](>�)F�\�\�\�\�w�ĕ\�4{\�Z�:��\�\�5\�.�A\�j-ܳ�b\�\�g��l4p\�;\0\n\�\�%@f\��[^W\�0c$	F!\�\�ګ8�e�\�j��\�t���ˎ��\�^Q�D,Mª[�V�/�Q-��\�:j�\'d��\�\�Fzl�=\��	dfl,�f8e�B@�O)�1Pbyo�\�\�ThOy\�b>{\"F�\�xd�\�Ș8�.�\�ث�F=t�ֱՓw����:�/����ǋ\�\�\�\�_\�4��ӍD�G@�\"EaYN`��\�֕\�\�E�A��\�\�\��*n^LD	\��\�`�U\�UJlw�� 3NO�I\�nEɬlb\�R\�#,#F\\3�\�k\�s��\��\�qF/qg\�I`Ӿ\�\�%慮σ4z�P\�@hg6q>\�c\'\�Ն\�\�c$�vrj\�ͥ!��G\�\�0$+\�9\�h\"`�6�u�.�G�\�uQ�\�\�ʌ	�(R�����֮P(24cc!\n4\�g�ÑQ�x�9/d\�Na�\�d:<\�c	;\�d}єVA�Z�cP�g�xD;\�̂Z\�\�+�\����\����\�#u��Ǝɔ+�\�\n\�GԸ\�d|\�\�\�\�?lF\���\�{$\�\0\�\���%Q%H�\�	�V\�	\�L_\")2\�\�u8\�1��~��CӃ�b\r\�@�\�-V\�\�=\�\�y\��Z;U�t�u\��\�μ	�~�\�\�G%T���&�^�ahM�&�\�\�Y�\�o\�T\�`G�\�S\�\��\�j�����K\�Za\�P�4Jp����}I��F��C3\�\��Em\�@e\��60��\�&���\�W�\��2\�5eu&г*��uɠ\�\�f7�\�\�h�\�VȦ\�l\�\ZW��)\�\�l��a\�R\�S��,�苂T�\�L\�_�ſ\�c\":7n\����\r��e�\�\�0:`swi\�ָd/\�Eu>K��WB;g�nC��*d��\�)~	W�\�`\�i��\n̹���\�SL\�}\Z\�g�\��n��\'\�$d\�ȿ�QL\�\�5Tp}\0+I�Y��,�k4k\�0�:.Wƕ��M�\�\�1���g�R�d�\'�X\�\��m\�4\�N)�A�B)9�\�\' ]�tajy+ѹ.>�b�\"�א\�\�(�t�O9�u�}\�*BzC�j����@\�kfK�\�\Z�#\�\0,p��g\�aq\�\�8�u\�\�\�g���ə*J��D)\�\�+\�\��e�B\�\�\Z@:I\�V�\'	��\�c|\�~ܞ%hh{b\�\�\�-v\�\�F\\W5��\�T`\�u@b���p\��\0o\�z\��\�\�|p\�9�~�No\�\�s\0r��⯍ࣺ\�gVU|�u\�x4r�ۣD�H��\\(�\"eJ�SG���Ne>d\�\�q�@z\�v.\�ހ�ُ/�S��o\�\�V\�6 \\��(֭�\�>����\�X[S_&v�\�=9hnxYb\�R�\�3�5��j�8�\�k\Z\nⷳ�Ƈ\�.쳻�I0\�c/\�9�\���A\�~�ǵ\�J\r��=9\�%\�\n\0i�J��sT�ޥp\�ti�R��Qd��59�n\�PL�\�\�>�?n\�nv�H(\r\���\�\�\n_��8,�V\"7z�g/Nt��X�Xt(�>�~W�>̥5O�h\�\�hebF�Ƥ\�\Zf\�0���\��r\�\�K\�\��\�]�?�\'�\�\�{���QQ��G}oDC\�j0�\�kr����\�b�>��\�\�\�\�\�G�%y\Z�\�\����L�[� [�\�54S>�7�+B� N�|��C@��:\r���\�\�$ly/\�4�\�\�X^\�(�\�\�;\�y%�R\�\�Y\�\�\�bh�-flCZ�Lу)X�\��\�Z!̔B9\�$d�o3o��\�I\\�66p\�(���s\�T�\�p&�\�\�uk\�\�\�@\"�\�ƴ�9q���L��+w��z?	����xNt\nÂy])`C��\�\�ΐ�i$n#�\�\�2�\�\�6\��ˬ$p��\"h�դ��e�RS�>�\�ٍ\\\Z\�ʌN1,�t	S6E�M\�9T���\�u�Df�\�\�\�\�8˻\�\�\�\�14�R�\�[4T,�P/�\�\�*k�@\�\�.c0��\�&�Aa�\��c\�Tx�n�\"j�̌GE0M;LnC\� d՝\�w\0�#7����\���?>`�\�$Ń��\r�mf\�\�\�\�(�(�(�bK!�$!N?ĳ%(Ȗ�3\�\\9x��%ˬ7\�\�\�\�W���/��E��\�s\�>Yn\�\�dc\�vf\0w&\"xO\�\�	�\�\�	\�%�D+�\"��\�\�1�w\�j\�\�\�]2r��9L�S\������\��uĢۺi�b��\�f�#H3BrgV\�x�-\�w�\�\�Ιn\�\�:,$%���F	\�בX\�y��\�\�vH\\!\�\�2A|L\\p��BW*�w�f5�\0تG\�|b{=2]�y�6g�L�\�\��TZ�P�N�?c4qKw�=��z��\�x\���\�:W�\�\�������\�\�8H	9b�4�H�\�1~\�\�a\�6,Ӝ\�[�\n�ir\�i�b�N\�J/<�|F����Χ+>Vѓ�4Ŏ\�\�\�\�@1�u�\�bS\�\��%O\��\�\�\�ӟq\'�򅻆\�p\�ً��|\�c��,G�\��ڎ��<\�OA�\�\�\0c��\�P��F1��P\�\�DX�L6���xh�\�\�,�g\�C\�\�y�\�R\�-\\\��<\'\�dh^�P�v>d@\�\�`z\�&�\�j~��C1ˍ�p�ʢa\�?b��6��Y�\�rw�Ơk#}Aߐ\�^]jҲ�`�U\"\�|����\"�l2޹�R�\�\�>��\�\�\\\�0\0a�\�\�\�si\�bۆ�-gEU\�L�&1CL�K@\�k���\�\�\�\'לe���s�����8JS2��1�tD�\�C\�\�&�87��\�%m[��^���ٓ����u��u����\�iRX���\�\�N�Cv@\�A�f\�\�z��X�\�kI�1)W3�\�*�\Z�g!���\�@sR\�p�m�\�k-Ñţ\�k{\r�m��\n�ng\�˙u%�\��Я���6�\�u2\�\�\�ɛ\�A\�\�\����&m���w\�Ą��uJ_\����@\�7�\�V4\�&!�\��/\�\��\Z����\�֓\�k�\�\Z\��<\�#-)\�V\��+�;(O�FP\0k\�\�����\'B�]rL��yo�}\�\n\r\�B,\�t\�\�\�Iড�K״\\��\�C\�@\�\�!\�9�Q\�\�\��+�p\�\��\�2\��\�ɕ�\�Šjk\�A�\�ZS\�\�\�X)\�/��ɲ\�Ч\'\�t\���\�n��\�\���a\�\�Z�P\�\Z���\�3`\�z�5ACFE\�G1\�4e)gF�G[T��L8MB��\�$�\�3*�F��)\�C3�H��\�\�֎\�b�fEu?\�\��qdt	\�̷l���2\�չ�\�H:\r0l_\�g��h	���P�(��\Zq\�L�e6Aפ,\�\�Y&\�j@V_\��#\�뽓��<Pp��=�p\��p\n\"�+Q[�\�X�X\�t�N�\�\� \�r\�kBTX��ÿ��\��!\�S>(\�4WM�j�\"Í�\�T.�\�l\�,S\�\�K\���ɤ+\��\�P}�@�4�\�\�\�\�\�)�\�\�ǤP;4@\�\��qd\�\�\"Rր\�\'`�/\"\�\�\��Zgk\���\�z�G����؎����I\�ӳU^R+q�̫\�J\�*\��\�~szk�\�ߺ�+��F\�\�R\����PO�!*K��\�]�\����\�H�U\Z��\�\�=�t�1�mF\�C\�g\�\��\0�C5oc39��	C(�QX74(\�o{\�cȘ�I@-ʪ�Z��M�[X\�Z u	7\"f�բ<%���\�\�T�D�3c�vO16\��5����\�\�	w�J߶\�i\�\�k�\�Y�jk`|\�������6N�&/�\�ϫ��\�<�\�\�~�\�\"\\8���p\�	�cD�{p,\��\�\�#[\�5�\�x9A\�--\�1E�\�u\�7K\�7\�9>\�ԕ\�\�\'M4l�z;8\�=�X9ʄK���\�(\�=B#���+\"{,�\�{�;�6��\�	\�T\�Ɩ���r�D\�wY��ђ\�j�vhf\�\�\�+\0J�I촘\�\�\�TE\�d���\�Ñ\�\�\n��\"\�	\r�D{!���:\�Ṃ\�~>iV��\�Oy\�T��\�ˈ\n\�����qݍ�8��ua)\0?U\�P�bO�\�\���+dG\na�\�\�ieX\�Զ\������F򚏫φS[��e\�\�caz�W<V�����\��#y>�\�\�ߛ>�O ʍ;�\"�cߕ|\�t�FD�\�-8\�GޛR^h1�G]\�\�\�\\nW�8=u�\��X�ڋ�\�4\�#\�/`\�k&݃g��\��\�s�D\0S\�5\�P�G.,���\�1\�q�\�	(\'��4�E�s\�#�\�\�\�\�-2\�t޽Q��b+�{T\�3�-r蜔l�y�\��\\M>�ƻى/iHU-8`\�\�\�`\ZD~�!��O\�n�{ܩ\�Wk8���R0\�<��L�:\r\\\�K�bB�\�9�s\�\��r\�\�\0\�|\�\�\Z@��I��\�봋�\�\�g.S�i���\� ۞w�6�u%�5\�?g.Th\�Ap\�+c\�O\�]\�S�X\�\�m\�\r\�,$\�\�+�\�NDn�L�U��9�͛zN�\n�i\�l\�S��_DJo�E&LFA2���\�Ƴ\'Di�8�BF�D�o\��Y_Wj\�Z�ڜ\�\�\�`\�v�Ǵ\�=�\�\�\�\�K�\�tF\�?�\�����\��\�#��J��>)�-=_=)w\�\���\�A\�\�e\�Z�\����F��`G=�9EM��\�\�>B����\��Ӭ�O�\�\�r�B0�B\�\n�\���\n\�B�D0�)\�H\�\��ʫ,(]2S�W\�U�`��5��ז�u?��陼_\���\�n\�\�}	4\�\�\�_\�\�#˙\�\� ^[\��\r\"\�yL\�\�Z�wW0\�\�e��\Z�l�e�^}r!S\0�\�u\n\�p��we_\�j�$S��\�2j\�$k\��ќ\�[ܓA\��\�1P]e\�x\�\�AM\�w�*���\�+\�\�\�\�\��\�\�]\�e�s\�P\�\�R<\�m%H�A��MG`�O\�-.\�h�L�PK�\�\�4�٪��&\"\�pBT*�Z�\�1��.�x�\Z\�Q\�VHu�*+�ҐV�O*��\�7ɻ\�\��v�Łpp	�/�\�d�i4�z�\�\�j8\�/^\�\�(\�-�~\�*�\�SbK(�j<&\�\�\�\�Z�@\�2�\�2�å!�d\"\n�56}6��\�\n���\�\�,A^e\�7+\�M���G�,nK$�P�ZX۔\�;�\�f��>�\�)�an�N\�\�*)O\�{\�l֡g�\�[��vEt�ػ1<�^�7\�\�:\�\�{AQ\�\�]%El5\�7�-\�,�ˇM5\�Z\�K\��\0p�;�\�7Ʌ��\�E��\�l/�iD5�\�\�5�\"0\n�e#\�\�O���`\�4G@DOv�\�%6�ҲU�/��A\���_\�V]�*Z��I��=�\��ό\�g���C\�}\�\�M]Y܄y\�<\�\"\�e�IgS\��o6Gjg\�a\�`\����jMX\�\�\�\�|�\�\�bD\�\"\�\�s\�ّ��Z\�]f��{\�Y\�>\�HD`�^M{.W�?(P��г �\�3b��c}=�f�H�F(\�F|Pd�\�9h?\�Q��S�\�	3qg$����f\�$\�u(�QP��4hX\�\�ϫA�*���\�\�\�J\�DczwL\���\'8�\�m|L>�yF\��2\�\\���zN}orn_�\�聃\�`�!\�.�3�\�k�$\�\rc,&3k� �\�34�0�\�\�\�\���ϛ��\�FJ��7���]M[�)/be�II�\�\"\�\�\�\��\�\�u\���j�\�=�.�פ�B\�\�e\�\�5b\�^(�\�\�@ªϣ\�H\�8�\�o\�ސ��=c�\\\�j�N��ބ�@4���{\�\�\��x �\\SW\�\��#��\��\�\�\��M:�!���䒺�+oa\�\�K\�x�\�TqV`�e\����\��\��ëd4�\�ٷ\�\�:j�,�E�QV?�Y˧|\�.�V(}a\�u�CBaB�,6\��\0bm�PP�D37 �\�\r2L\�R\�\�[\�}\�)\���*C���\��\'EW\�G��\�*��\"ʜ��y�6|J/]���|-]sj\'��U1>v鐘\�\�|��nȈ�)X� Z�j\�4b�Y*\�¦[�\�k�\�\��\"*G���,Ҝ���P�/0���z6,񊧍\��gx�8\�\�>:�\�\��; \�\0#\�,\��\��Ư�SD\�K|\�\�&\���*�i^\'A=i_��\Z�\�{�m��*\�5G�Ҷ\�\n\rsKb��\��X���\�3`:ԧ��Ă\�\�-k�dh(�\�\�>\�u�\�tg?�\�\�~�\�&�W\� ʵ\�h񼉎\�o�*�V^\0�Z&<\�O-�\�`-~�r\n\�t�\�}\��8���6?�\\\�8\�\��&{@���W�\�-8�B\�h�]UP\�\�\'$4�����Y�\�U�\�	�-i3\�\�a���{�\�Z͠\�&[/�oR��ܖ\n�\���\�@�\�kqP׊��ڵD\�=̫�\�\�\�7����\�=|�\�<�>r�\�\�!b2\�_�*�&Q�U\�(3�\�KD\�/M\�&�cN��H~\�\�\�~��<\���\�\\0\�O\�jB#kRb�\�\�\����-\�\�8�!�\�WҞ\�sEr2�\�Lы,��\�L�\�U>�:\�\"\�X\�\�2�\�m�;\����R\'c�r\��ϟ\n}g\�apz.u��b2\�W\�@\�\��<�u\� t�/\08l�s��CL��gh�\�\�7\�\nY�]�-�\�k\�:!������\�K|zN�\�b~J\�\�\�\"�\�\n|#\n6��8W�q��\�^|Xb$h�{9\�o\�9~p��\�=؇\�|G.v�\�\�\�/߉��\�\�\�E�#���\�W�\�qaH\�\�^����1�\08`�\�W�ϡy\�|�Nv2Qw�g�\"�\�\�\�o:�\���8��/=HT�\��\�ȁQۀ3H\r�\�g�v~iR�\�/؋�Ri�\�(O��\��0AV\�\���uh-A�\�kud�8�\�\�=5\�\�\��5�\�[$�z\nv雹�� _~\�\�\�W�\�\��\�\�\�:EE�2Q�\�+ߠs{��[\�`+%\�*j�\��\�\�\�*�\�#ԭ��=6n-�\�j\�k	�\n#(�\���O ��xp\�\�\�;\�k\�\'\�\��\"E�[�K�\�Ifyx�-\�a��^\�\�\�\�\�L�@\�\�h;ʶ\�!;�y\�\�\re��Ș~\�)�ރ�{�:Ό4�\�NI\n\�_pHI/\�(2(\� 8l�;\�每��~xG	z1\�{n�	��~[g5�\�\��-;�t�\�\�6\���tu�\�}h ��Y\r\�\�(��;m6��Ѷ\�v��\�\�K�]\�E\�\0_$7\�jf���]�\�g>hd\�$b�t\���\�CQ�3���|\��C\Zp�x\�\Z傖\�e\�\�\�V\�2���\�\�?ǉ\\��rP��\�\�僭�ﱞ�Y��\�D�N\�X�+k\�&Ke\���w\��26��H;�6s�(�*�7\r�\�r\'�����d풪\�,c3CT\�;�\�*�T�\�Q��\�\�/���G�\�\�\�-T��\n�\�\Z\�\���fE;v�q|�,w,��8K!�\"��\nc7جv�\�\�ѧ\";F2�*\�\�|\�{\�\�#\�i;|�Vp\0B�?��owR􏯒�H_\�s\�\�=�z\�Lc���)[b.[r�?\�\�ݗL\r��c��`5A\�[$;>`x�D\�)\��R��\'����=��l~�f��-�\�+}eKu�s8��_��0H���\�E0�\�zT�y*Rh��H���d�y\�\0L�*�\�:\�\�񄦌�8�+7�d\�\�47�\�i\�?\���=W�E����a�\�&@\r\�*�w�\�\�)fC�<\�-�ֶ#\�N,�#\��Rp�~�\�\�t,c\�R�\�\�\��\n�\�q�X���)&UE(qP\�\\�g�M�[Շ�]�w6Gl����?Z|\�,�%\��uw\�Ǌo\�Tǹsj9��,\Zm\�\�dk�j\�:�=\�I�\�\�=� �<\�-?�\�nd&�\�1�1\�\�\�M��Z\�*L�)9�g\�\�\�EAN��h�\�j��)\�\�\�2~Q��3\�(�+��\�\��ǒC�\�N�˔���˅��$�2\�YV\�\�h0.���S\�-g_D\�rE	<f�B�mF�\�\�a{\\�\nnÐ;��\�.\��\�|�h\����)�Լd\�3%j���\�{�#\n\�\�Λ��`\�|$\�����~�\��~SU�\�և*\�ÿ��K��\�|W\\\�\�c3�\�J\Z�4bs�\�+�\�\�e�M�\�S!�G\�H\�H{ \'(p�HdD/\�[x\�X�7e�\0\�s5Y�z*ne\\tB\�\�\�c��m���f۴�\�~�\�\�\�WUUL\�T tƟ �\�=\��\�t���e8TS�,��J\�bm`M\�g}W_8!MjVή�x?\Z�r03\�\�\�\� \�xJ\�\� +�>��.j\�B\�1w^s 5��)�$J�&�\"�:]�M\�0��\�A\�\�8\0$��[\�\�\�bʺa\��T �$�Y�\��A~cv�D\�\�\�+b�5�M{5^Hr\�\��Q��jq�A��j�z\"\�8\��h�GcNI\�e`\�\�L�J@�bV��<�7U=8\�Ⱦ�m�\�^mP�c\����o�~z˴�\�گ\���\�Y\�T\�\'�z˺�:w\�\��`V��\�\�;\�#���\�{�l��\��\�\�ڳ]m�p�P,�&ROVۏ�`\��j]�-�A>�W\�S\�\�TD\�7١\�\�Йh1�nP`�\'m\�2�\�!�5Wc!<lΰ\�\r3{A\Z��s~�_����k<c��\�Om*4iq4\�=�9��%�\�\�\�u\�6>�Dڅ�Ω�\�h}j\�+�h���\�h]\�7�\�c\���\��|aW=\�h�^v\�T[C�@��y2�\��y\�ӷ\�\�\�@*��0\�\��\�\��0@\��\�c\�\�ĝ8��J�1��-�\�2\�\�\'<\�c�\� \n�\�\�~uD\�G�8K\�9ɬ\�\�<\�\�4���\n�:y[ˣT[]\�`��\�>`=J���Rm�i��\�dL����E�4PA\�\�Xs?׹�m�)��|T~\�Y\�\0\�\�\�\�\�[6\�\�Y*\�\�k�\�ϱ\0�\�\�;\�/H�3jƜ�$�Hh~�\'wCr�1���\�<EI\�T\�\�\�\�\�\�(G���\�M}��%\���_��\�}Ƨ�<�\�i�\�f\�D a�9�*������0\Z\�J\�\�b�QV�����>��\�\�/�Gw9DȂ\�\���R����\�\�ƈN\�\�F��\�OV�DOo(8F\�HS�%<N\�YbdM΁��\�\�\�\��P7q[�bl�V�\�\�Ӯ&۰@��8\�\�h\��\�\��o��\�݌ڮ�\�G\��+\�\�\�\��l��ƢQ)�\0q/ؽf�Ѭ�ZKJ��\���\�\�\Z���Ww\�ѵ\�N�Zq<\�Ʌ���\�\�<j\�]E\�\�2\�	\�oX\�\"\�\�����5X\�}�\�\�\�s\�^΄ۑ����%%pFs\�6I\�`\�\�r\�4K\�W�>y�ʄI\"\����R0�T9a<�\�\�\�9\rr�\�D5\�\�$\�\�\\k\��L�}O\�\�\�\�Z\�,bL�10\n�\�Ie�Ph�\�+�]� �&\�^lI��U��Z\�\�E\n�����KS\�D\�y����Џ%N�4�\�\�\�K�\�T>\�\�Qs�X7\�\�$ڋ��\�\n\�\����)P)脬*������I�8=\�&MN\�\��3�\�k3����7ɜj.��P�\�(\�5\�]cqŐc�#.\0�\�lPg\�\�\�\�\�\�q\\̹�\r�5w�\ni�_\���c[]Q�\�\n\�\�\�\"2��%�S�i\���s�`�\��j\\\�ié��2c\�W�sUR]\� �I\�v���\�\�W\�]*\�\�X���\�\�#b��gp,x=�;�1\�ɜ�w��$B�}�Mc��;�\�w7`\�Dl�\�f,�\�;E\�fh��ާ��}\�$<�A���bĪc\�\�\'���T\�:\�8V��f\�\�N\�0m[�XKQ�23\�u�\�\�{u̗9�0Jx8���\�\'�d�\�ެ3ͳ�|�վ�2�\�~�\�]�1�\�3�a�m�.�.�\�|Q\�,\�FFQ�~\�\�\��9\�`\0��\n�\�P�e�m�\�\"2�\�]���AAxZ�\�\��\����ʝ\�xԕS�>\��lݚ�@y�\�zy3q0祎�A\�\��\�\�w��ẵ�E\�a\�\�*o\0���L5ӊ�3K;��B�\�\�SCLCA[,緽6S \�~u\�\�H�\�&�\�\�2C��9\�d�MZ\�̚\�u\�\�K\�cA�|f\�\�M\�B��N\�O\�W��J\�\�\�`�\�r<\�\�����q\�\����ӡ\�\nt#�8&Nh\Z\�L\�\�=\�Qe.g\�L\�-��K:ܱ�\�Zo\'��\�-�q��\�p\��\�Β�L�u0OO�Ɲ\�9�)���\�\�ſ\Z�C)\�{�\��	\�\�X�h���ϧ�r\Z\0���<]��W13���|�~�\���\�\�ju\�媗7\'SJ�\�\���)���b�_����fkp�B��\�p%k\�\�u5�C\�-ڷMK�R}�\�oXN�5�������\�\�F�\�\�\����j\�	\�!y\�\�D\�\�~�q�o.Xҧ�\�\�\�\"5�\�K\�Z\�\��\�y1��q\�l�\�7\�\�<C\\�*��\��4�⛗�K�|\�?��\�)G\�2\�~�\��\�\���͔F�y�\�=D�װ\�;�}\���U9\�~���0\�Q\�S\�oz=�\Z&\�|\�C��-6Z\�\�{�\�B�p��m�}�v�C\�\�s&S�|�I~1�6�t6Ah\�j\��\�\Z�f��+�z�r*��?�i\'\�I��y�\�o=/�\�;c6�<�\� �	|��W߄\�3�\"�OpJ�yTj\�l/\�!#�)͍z�q\�\�՗\�\�\��\�%X��*:\�VM1h�\�\���P��G��\���=d\����V��V�\�ͭ\�q\�,=����g\�3gm�L%�Tu��q\��xu(T� -��\�\�[�T�\��;\�d�U,A��\�\�e��\�qM\�\"U\�uf�b֙�\�\�`>��\�h^|�\�\n�\�\��Ȯ��ݪĴ�\n��Y��1��\�A$�\��˧��\���>�o�\��)Ȇ;\�\�Q\Z|K�\�y�\�\��p�\�Lɬ`!d-�:\�\�9aΒ\��X|��-�\�_z�t\n\�\�f\�\�G,\�(6�P��4��!]��?x�i\'K�M�H�2\�n\�\�\�\�\�oX\�R\�97\r��\�\�9D\�ҿ!m*c�\�a}\�!��s�!u\�E\�t�\�w[\�#\�9ɵ1#(\�i)��\�[\�]\�\�/�\�\Z�\�Y.�C�|���ى�eޢ�Y\��\r�Hb\\��\�\�*LpyV\�<�\�ԗy\�u4����L�\�\�il�O���=�>��\�\�\�\�Q_\Zŝ%wi\�����Z�\�~i�\�\�R���\�y�U\�u1q�4\�?p\�e\�\�q�\0æ\�f\�u؅��*�q%���̵H\�\�j{�҉�r\�S��%?\��h_1eo�+\�eo\�s\�0޹}\�\�\�\�jϕ��=�~%xw�*�y�aTA�u�\�vI_\\��b0m	\�\�	;Dk��\�x&{�\Zդ8��g%�+�sJ\�^\�e�b\�qr�\��\�X���\�J�\�Z\n�s\��\�\r���b`z̭�� �O\�:Ul\�\�\�R\��\Z�f��\�y8�J�=v�P�S\�h;ݚ��3�\�\Z>!������\�i�d�5�MFM�H\Z�\�C}q\�\�ѽ�>_;K\�r\�sv�{�\��\�nC0m�cd�\�om�L��\�\��\Z\�(��&:\� 8��\r\0�f\�\�4�%�Bޣw��e�z��D;#�\���\�N�LY�\�Y\�H\�67\"�`f5wG}Ɏ\�{\�\�0GZ�=���\�\�⟠� G<�>\�݋&\n9<�\�\�r��\�(�\�f�W�cLF\�l4�\�Q!\�\�l,\�Q�\�G\\��ģ\�PN\���[+�W�6�\�\�|:K�\�?(�Mk\�Q�\�v\"�\��L�\�\��P8U�N\�\�>j2pg\�\nU\0D\\w3\�=\��\�\�B\�ƍG\�f7�\n%n3:\�\�\��\�L��,�\�\�\�+2L۹���jIl\n7|C\�Ax<������s��:I9/IV\�~\�Yj�\�U\Z�({\��\�m\�liF\�\�9C�p����\�$����$E\�w���\�$�\�J7=a��$\�M\�x��R\'/��_�e��,\\��QmC�/$\�\�*�U\�\�=)|\�h\�\�+\���wՎ�\�\��\\\�\�0h�n\�	�Gm��A>����jByđ\�\�9C`��ݪt��	`�x��xd#�	;\�l\��<�3��Ju7�h\'�L�نJ��\�\�Y)�D�Mg\�ɿ���\�3���� v�/\�B+i���>�j�Y|6�dcӎ|oS3\�(|n\��1�B)H]���\0�W\��\�m���$�lʹ!�O\0\�\�=\�Mr[)hL��\0ڐ\�6XZ�f�\�J���\�%�\�\�\�\��}��7߈4\"\��0����⣤��t\�\�?�\�\�?�\�\'?�\�\'��\�\�ۋ\�jj�˧�����}��\�g�ɣ+�\��n�Q�X�7#Xk�\���t\���K�\�7�\�7�\�1幟�\�>��\�o\�g\�ӳ�}\�kس\�\��_�\�)NG\��)�x�]���t�\�\�[�Ozo:\��\��\�\�\�y\'N\�\��\�\��\���ݏ�yI\�\�\�\�\0d\�}?\�\�#ﾑ�\�q2m!\n\�}\�\�?I?�\�wg(b��\�22n\��\�#\�\�\�\���\�\�\0���k\���\�\�\����N�\�\�\�`4\�F�+#!�\�|�\\Q=\�\��\��֧q\r\�พ\��\�\�w\�߾�O0\��\�\��\�\�\�\�OUk?b�\�}e�?�\�-7�K\�Ĺ�\�yn>=\�\�6�c5?����?ڦc\'-V?N��\���\�\����\�O\0���u��C���\�\��x]o\�o~	:��e~\�t\�\�O�\�Y��<\�١G4��~\�\���\�\0S\���\�ͧo~�_�?\��?\�P\��\�r�\��|�\�@\�\���\�dj�J\�\�g\����\�\�-~\��j,X\�t.\�\�\�7o>\�aZ��2\�;���J�\�%���v\�ғ���U��\�z\�\�K�\�\�\��d���|YR\�y��/�\�/\�wj�\�\�\��\�\�ԧX:Y�7�~�~c�z\�iQM���K�\�1 ٷ\�,,ezkG��\��I�\�=\�ٿa\�&<�\��`\�\��}�ho>}�~�b\�}\��P�\���\��`?\�\�\�ڿ	�s{�_�\�_�2}�\r��m\�\��\�\r�^���\�_��w�\�\�p�\�\�\��]\�x�<o?��\�\�P���\��\��\�\r��\�\�\�6-t�\�\�q\�A�[~��x�\'W/�\�f\0a�pC?^�\��/WoLFDČ \�Hz�۵ٶ�\��UpS�\�f��\�\�\�K�\�,�9�5\�~rs���߃~�#o�K���w�OwH�\�\�}o~\�ʽI�\�\����X�qJ��\�\�\�\�0\�(��g��\�\�\�\�\�l\r�\�\�#�w���y�\�9�\�Ƕ\�hjmү~d\'\�g\�\�g\�Q�\�\�\�\r?��\�q\�~\�Vﻻ+\�|�\'����q\�\"��}\�R�.V\�{���\�	\�\�p��;\�c�!}\�7p�ȴ�|��\�G�n�\��\�\�O~\�\�o�\�\��\�\��\�iӮHL��\�[,\�7���\�\�d����ؙ�,\�P�ߦ��\�\�삆\�g\�����\�1\����\�\�\'?8�m�֯\�w�7�vsJ�ʿ��߻\�oR\n\�/�\�|xX\�{/\�o\�\�\'?�\�:-���;\�s?k^>G֣�}z}P\�\�\�\�G��\\о|��\��\���\�.Ι޽~s��{�\����#��\�7�|�=X�\����i\�\�\���&�9��,��u���O9�\�s=\�\�Pۥ_�\�x\�\�\�8%�\�\�\�vV~���\���\�bzK\�@�\�龦��\�\�\�F\��L\�|?I�\�\�\\�!�]?�\�\�Ϳ�y�\0\";}','20210901214136'),('my_wiki:pcache:idoptions:1','}��n\�0�\�%g-�\r�#	�m�1\�L\�Qki\�.�!\�}�k�q\�)\�\�\�ɟ���p�����g|g\�^��5���Bk�3*H\���/��\n��&\�e�o\�Wt>��li\�WL\��N\��\r\�̦�\��2��R|F\�+Z\�ݸ\nҀ��\�\�\�\�ݪ\�O\�\�#\'AM|Ά\�ƌ\�ײ\�\�\Z�r-�Gέ\�Z��\�\Z\�\�H8�\�9�u\�$\�Ѝ\�ʡa\�b]���&=5]\�\�\�\�<�T7\�5�4\�P��J\��(jؒ�Ў\�F\�8\Z\�\�n܏\�z��\�\�\�\�i\��\�Q+\�;\\�\�\�\�Q=�\0','20210901214153'),('my_wiki:pcache:idoptions:2',']�Ko�@���\�x)B\�#m�Hi�\�\�9�+�Y탒F�\�m���o\�\��I�	�@�\�҇%���\�؂�\01�\ZکV�=\�\�8\�x\n�\�a\�e\�%��o��E\�\�I\�;\�\�}\Z4�|$\�\�;4�r\����ؑ�Ē^\�\�ξ=��	�\�ʮT*;%̻q�\�8z2vL���Mw*\r�ت�\�\�\�\�s9U����/��l\�./�\�X\�4\�Q\�\"ۤa���jǸ�qfIGI�n`\�ԫ\�\�V�H8���\�\��ۼ\�\�','20210901213446'),('my_wiki:pcache:idoptions:3',']�\�N\�@�\�\�\�\�C�j9�*�J9W&\�+%�\�\�	)Uߝmh�\�d雱=\�*\�s(\�3�3\�W\'��\�\0d񣡥i��\�u^@�\�)�ǅ��^ӛ��+Z�/���\�����C�\�\�\�\�}M�D[\�X�\�0V\�o��gb�\�\�\�)K\�\�Jy9o\���\�t�\�\�Ȳhj\�z[�JN\�.�O��j��#(�\�QHn�\�<��\�3[�6�4N�x�%i�\�\�\�\�s��Рfld\�h\��G��','20210901213523'),('my_wiki:pcache:idoptions:4',']�OO�@ſ˜9\�V�GԤIUR\�\�\���\�fg�M��m{�\�\�\�̼GY�\�gp�BX\�\�\�ͰԊ ;*�oq-;\�4\�2dlЉa�\�\�U�.�\�ū�0\�N\�}\Z�P\�#\Znf\�\�\�\�k�j\'\�R1\�OQ\�]pb�\�\�\"5��fXI\Z\�\�/)\��GK>����<�nT*�=N\�\��S\�\�|�;{��0e+�~�)�\\�\r�:\� K��0<��\�|Z�\�8\n\�$��\�n�\�Y\�`/\�\�+�}��w\���y��','20210901213548'),('my_wiki:pcache:idoptions:5',']�OO�@ſ˜9\�\�(�#jҤ*�\�\�L\�)L\�fw�֦\�݅�֞6��\�v\�sY����@\�\�ӑz7v���4\�Zs˲!\�Y�LlO�x\\\�\�}\�7]Ѣx\�\�]�\�}>\Z\�ꉌ\��\�\Zu\�c\��k!{��^ɹ+��vO�&T�+�P\�nl�w>�\�?Y\�\�\�\�[�\�t�\�ѐv<дݾ\���O{ϗES6\�擗\0r,k\�{؞ K\�\�\�pf[n}]�\�8\n\�$��\�!�`74\�x{�|(���\���/y�\�','20210901213721'),('my_wiki:pcache:idoptions:6',']�KO\�@���\�9\�PX��J�RΕ�uK\�f��\�R\����(=Y�fl\�X�幀3�h,}Z�\�\�q�,�3�\�}Kk\�\�mH\�Ɓp\�SW�j����+Z�o���\�\���\�G�J>�v\�\���\�\ZU\�����ʑ9`E�d\�W�ۓi%�\�.T�}\�R.���\r\�o\�-�\�t�\�Q��<\�\�ݼxU�է��\�ˠ�Z�\�\�KV\r�>lN \���8�ٖ�\�8M\�<K\�$˓fqC��W\�C;wҴ\�\�<�\0','20210901213811'),('my_wiki:pcache:idoptions:7',']�Ao\�0���\�=4-*(;v��\�X\�\�y�)�\�4Jܮ\�ߗv�1N��\�l�\�e�\�%��@\�\�ݓz��[\�A��~Դҍ\�\r\�\�1HvE\�\�4e\�)z\�_tC�b\�*\�\�\�\�?�4X4\�,��\�U\�+4U�\�\�\rm�\�Kz!\�o�\�~̒�A7FO·�w�V\�d�Si�d�\�ij\�;S�%�fWϧC[\�\��8G�cy��\\�#\�E6�\�\�\�&�$ND�HE\"f\"\�\�\"n�\�\�\�)D;>Z\��\�\��','20210901214136');
/*!40000 ALTER TABLE `objectcache` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oldimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oldimage` (
  `oi_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_archive_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_size` int(10) unsigned NOT NULL DEFAULT 0,
  `oi_width` int(11) NOT NULL DEFAULT 0,
  `oi_height` int(11) NOT NULL DEFAULT 0,
  `oi_bits` int(11) NOT NULL DEFAULT 0,
  `oi_description_id` bigint(20) unsigned NOT NULL,
  `oi_actor` bigint(20) unsigned NOT NULL,
  `oi_timestamp` binary(14) NOT NULL,
  `oi_metadata` mediumblob NOT NULL,
  `oi_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `oi_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') NOT NULL DEFAULT 'unknown',
  `oi_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `oi_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `oi_sha1` varbinary(32) NOT NULL DEFAULT '',
  KEY `oi_actor_timestamp` (`oi_actor`,`oi_timestamp`),
  KEY `oi_name_timestamp` (`oi_name`,`oi_timestamp`),
  KEY `oi_name_archive_name` (`oi_name`,`oi_archive_name`(14)),
  KEY `oi_sha1` (`oi_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oldimage` WRITE;
/*!40000 ALTER TABLE `oldimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `oldimage` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_namespace` int(11) NOT NULL,
  `page_title` varbinary(255) NOT NULL,
  `page_restrictions` tinyblob DEFAULT NULL,
  `page_is_redirect` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `page_is_new` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `page_random` double unsigned NOT NULL,
  `page_touched` binary(14) NOT NULL,
  `page_links_updated` varbinary(14) DEFAULT NULL,
  `page_latest` int(10) unsigned NOT NULL,
  `page_len` int(10) unsigned NOT NULL,
  `page_content_model` varbinary(32) DEFAULT NULL,
  `page_lang` varbinary(35) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name_title` (`page_namespace`,`page_title`),
  KEY `page_random` (`page_random`),
  KEY `page_len` (`page_len`),
  KEY `page_redirect_namespace_len` (`page_is_redirect`,`page_namespace`,`page_len`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES (1,0,'Main_Page','',0,0,0.676401559977,'20210831214113','20210831213702',7,902,'wikitext',NULL),(2,0,'Pagey','',0,1,0.885304396024,'20210831213446','20210831213446',4,3562,'wikitext',NULL),(3,2,'Bloop','',0,1,0.209494813723,'20210831213523','20210831213523',5,104,'wikitext',NULL),(4,3,'Bloop','',0,1,0.167038360961,'20210831213548','20210831213548',6,100,'wikitext',NULL),(5,0,'This','',0,1,0.936099395193,'20210831213721','20210831213721',8,3562,'wikitext',NULL),(6,0,'That','',0,1,0.65743298212,'20210831213811','20210831213811',9,3565,'wikitext',NULL),(7,0,'Dream','',0,0,0.296878780343,'20210831214136','20210831214136',11,243670,'wikitext',NULL);
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `page_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_props` (
  `pp_page` int(11) NOT NULL,
  `pp_propname` varbinary(60) NOT NULL,
  `pp_value` blob NOT NULL,
  `pp_sortkey` float DEFAULT NULL,
  PRIMARY KEY (`pp_page`,`pp_propname`),
  UNIQUE KEY `pp_propname_page` (`pp_propname`,`pp_page`),
  UNIQUE KEY `pp_propname_sortkey_page` (`pp_propname`,`pp_sortkey`,`pp_page`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `page_props` WRITE;
/*!40000 ALTER TABLE `page_props` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_props` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `page_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_restrictions` (
  `pr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pr_page` int(11) NOT NULL,
  `pr_type` varbinary(60) NOT NULL,
  `pr_level` varbinary(60) NOT NULL,
  `pr_cascade` tinyint(4) NOT NULL,
  `pr_user` int(10) unsigned DEFAULT NULL,
  `pr_expiry` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`pr_id`),
  UNIQUE KEY `pr_pagetype` (`pr_page`,`pr_type`),
  KEY `pr_typelevel` (`pr_type`,`pr_level`),
  KEY `pr_level` (`pr_level`),
  KEY `pr_cascade` (`pr_cascade`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `page_restrictions` WRITE;
/*!40000 ALTER TABLE `page_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_restrictions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `pagelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagelinks` (
  `pl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `pl_namespace` int(11) NOT NULL DEFAULT 0,
  `pl_title` varbinary(255) NOT NULL DEFAULT '',
  `pl_from_namespace` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`pl_from`,`pl_namespace`,`pl_title`),
  KEY `pl_namespace` (`pl_namespace`,`pl_title`,`pl_from`),
  KEY `pl_backlinks_namespace` (`pl_from_namespace`,`pl_namespace`,`pl_title`,`pl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `pagelinks` WRITE;
/*!40000 ALTER TABLE `pagelinks` DISABLE KEYS */;
INSERT INTO `pagelinks` VALUES (1,0,'Dream',0),(1,0,'Pagey',0),(1,0,'That',0),(1,0,'This',0),(4,2,'Bloop',3);
/*!40000 ALTER TABLE `pagelinks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `protected_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protected_titles` (
  `pt_namespace` int(11) NOT NULL,
  `pt_title` varbinary(255) NOT NULL,
  `pt_user` int(10) unsigned NOT NULL,
  `pt_reason_id` bigint(20) unsigned NOT NULL,
  `pt_timestamp` binary(14) NOT NULL,
  `pt_expiry` varbinary(14) NOT NULL,
  `pt_create_perm` varbinary(60) NOT NULL,
  PRIMARY KEY (`pt_namespace`,`pt_title`),
  KEY `pt_timestamp` (`pt_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `protected_titles` WRITE;
/*!40000 ALTER TABLE `protected_titles` DISABLE KEYS */;
/*!40000 ALTER TABLE `protected_titles` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `querycache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycache` (
  `qc_type` varbinary(32) NOT NULL,
  `qc_value` int(10) unsigned NOT NULL DEFAULT 0,
  `qc_namespace` int(11) NOT NULL DEFAULT 0,
  `qc_title` varbinary(255) NOT NULL DEFAULT '',
  KEY `qc_type` (`qc_type`,`qc_value`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `querycache` WRITE;
/*!40000 ALTER TABLE `querycache` DISABLE KEYS */;
/*!40000 ALTER TABLE `querycache` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `querycache_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycache_info` (
  `qci_type` varbinary(32) NOT NULL DEFAULT '',
  `qci_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  PRIMARY KEY (`qci_type`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `querycache_info` WRITE;
/*!40000 ALTER TABLE `querycache_info` DISABLE KEYS */;
INSERT INTO `querycache_info` VALUES ('activeusers','20210831214157');
/*!40000 ALTER TABLE `querycache_info` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `querycachetwo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycachetwo` (
  `qcc_type` varbinary(32) NOT NULL,
  `qcc_value` int(10) unsigned NOT NULL DEFAULT 0,
  `qcc_namespace` int(11) NOT NULL DEFAULT 0,
  `qcc_title` varbinary(255) NOT NULL DEFAULT '',
  `qcc_namespacetwo` int(11) NOT NULL DEFAULT 0,
  `qcc_titletwo` varbinary(255) NOT NULL DEFAULT '',
  KEY `qcc_type` (`qcc_type`,`qcc_value`),
  KEY `qcc_title` (`qcc_type`,`qcc_namespace`,`qcc_title`),
  KEY `qcc_titletwo` (`qcc_type`,`qcc_namespacetwo`,`qcc_titletwo`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `querycachetwo` WRITE;
/*!40000 ALTER TABLE `querycachetwo` DISABLE KEYS */;
INSERT INTO `querycachetwo` VALUES ('activeusers',1630445651,2,'Bloop',0,'');
/*!40000 ALTER TABLE `querycachetwo` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `recentchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recentchanges` (
  `rc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rc_timestamp` binary(14) NOT NULL,
  `rc_actor` bigint(20) unsigned NOT NULL,
  `rc_namespace` int(11) NOT NULL DEFAULT 0,
  `rc_title` varbinary(255) NOT NULL DEFAULT '',
  `rc_comment_id` bigint(20) unsigned NOT NULL,
  `rc_minor` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_bot` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_new` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_cur_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_this_oldid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_last_oldid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_source` varbinary(16) NOT NULL DEFAULT '',
  `rc_patrolled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_ip` varbinary(40) NOT NULL DEFAULT '',
  `rc_old_len` int(11) DEFAULT NULL,
  `rc_new_len` int(11) DEFAULT NULL,
  `rc_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_logid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_log_type` varbinary(255) DEFAULT NULL,
  `rc_log_action` varbinary(255) DEFAULT NULL,
  `rc_params` blob DEFAULT NULL,
  PRIMARY KEY (`rc_id`),
  KEY `rc_timestamp` (`rc_timestamp`),
  KEY `rc_namespace_title_timestamp` (`rc_namespace`,`rc_title`,`rc_timestamp`),
  KEY `rc_cur_id` (`rc_cur_id`),
  KEY `rc_new_name_timestamp` (`rc_new`,`rc_namespace`,`rc_timestamp`),
  KEY `rc_ip` (`rc_ip`),
  KEY `rc_ns_actor` (`rc_namespace`,`rc_actor`),
  KEY `rc_actor` (`rc_actor`,`rc_timestamp`),
  KEY `rc_name_type_patrolled_timestamp` (`rc_namespace`,`rc_type`,`rc_patrolled`,`rc_timestamp`),
  KEY `rc_this_oldid` (`rc_this_oldid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `recentchanges` WRITE;
/*!40000 ALTER TABLE `recentchanges` DISABLE KEYS */;
INSERT INTO `recentchanges` VALUES (1,'20210831213244',3,2,'Bloop',1,0,0,0,0,0,0,3,'mw.log',2,'172.20.0.1',NULL,NULL,0,2,'newusers','create','a:1:{s:9:\"4::userid\";i:3;}'),(2,'20210831213411',3,0,'Main_Page',2,0,0,0,1,2,1,0,'mw.edit',0,'172.20.0.1',735,787,0,0,NULL,'',''),(3,'20210831213435',3,0,'Main_Page',3,0,0,0,1,3,2,0,'mw.edit',0,'172.20.0.1',787,813,0,0,NULL,'',''),(4,'20210831213446',3,0,'Pagey',4,0,0,1,2,4,0,1,'mw.new',0,'172.20.0.1',0,3562,0,0,NULL,'',''),(5,'20210831213523',3,2,'Bloop',5,0,0,1,3,5,0,1,'mw.new',0,'172.20.0.1',0,104,0,0,NULL,'',''),(6,'20210831213548',3,3,'Bloop',6,0,0,1,4,6,0,1,'mw.new',0,'172.20.0.1',0,100,0,0,NULL,'',''),(7,'20210831213702',3,0,'Main_Page',7,0,0,0,1,7,3,0,'mw.edit',0,'172.20.0.1',813,902,0,0,NULL,'',''),(8,'20210831213721',3,0,'This',8,0,0,1,5,8,0,1,'mw.new',0,'172.20.0.1',0,3562,0,0,NULL,'',''),(9,'20210831213811',3,0,'That',8,0,0,1,6,9,0,1,'mw.new',0,'172.20.0.1',0,3565,0,0,NULL,'',''),(10,'20210831214106',3,0,'Dream',9,0,0,1,7,10,0,1,'mw.new',0,'172.20.0.1',0,243664,0,0,NULL,'',''),(11,'20210831214136',3,0,'Dream',10,0,0,0,7,11,10,0,'mw.edit',0,'172.20.0.1',243664,243670,0,0,NULL,'','');
/*!40000 ALTER TABLE `recentchanges` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `redirect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redirect` (
  `rd_from` int(10) unsigned NOT NULL DEFAULT 0,
  `rd_namespace` int(11) NOT NULL DEFAULT 0,
  `rd_title` varbinary(255) NOT NULL DEFAULT '',
  `rd_interwiki` varbinary(32) DEFAULT NULL,
  `rd_fragment` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`rd_from`),
  KEY `rd_ns_title` (`rd_namespace`,`rd_title`,`rd_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `redirect` WRITE;
/*!40000 ALTER TABLE `redirect` DISABLE KEYS */;
/*!40000 ALTER TABLE `redirect` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision` (
  `rev_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rev_page` int(10) unsigned NOT NULL,
  `rev_comment_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `rev_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `rev_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `rev_minor_edit` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rev_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rev_len` int(10) unsigned DEFAULT NULL,
  `rev_parent_id` int(10) unsigned DEFAULT NULL,
  `rev_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`rev_id`),
  KEY `rev_page_id` (`rev_page`,`rev_id`),
  KEY `rev_timestamp` (`rev_timestamp`),
  KEY `page_timestamp` (`rev_page`,`rev_timestamp`),
  KEY `rev_actor_timestamp` (`rev_actor`,`rev_timestamp`,`rev_id`),
  KEY `rev_page_actor_timestamp` (`rev_page`,`rev_actor`,`rev_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=binary MAX_ROWS=10000000 AVG_ROW_LENGTH=1024;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `revision` WRITE;
/*!40000 ALTER TABLE `revision` DISABLE KEYS */;
INSERT INTO `revision` VALUES (1,1,0,0,'20210824004502',0,0,735,0,'a5wehuldd0go2uniagwvx66n6c80irq'),(2,1,0,0,'20210831213411',0,0,787,1,'bok5cuuh2h8wsp0affimzzf2gngb4fa'),(3,1,0,0,'20210831213435',0,0,813,2,'8t7lujzsm3xvuydax2eo7k9353rz4rx'),(4,2,0,0,'20210831213446',0,0,3562,0,'pdqyyeritxtudwtt0b8lt9dxuoo7ugt'),(5,3,0,0,'20210831213523',0,0,104,0,'qjsqmz5zezgmwshr8ac6fxxu2zl5023'),(6,4,0,0,'20210831213548',0,0,100,0,'eu29ykb52423mkxzokewv5q4h5afdlx'),(7,1,0,0,'20210831213702',0,0,902,3,'qo2uals4a3efxo3psxhqvj9hxivuw9w'),(8,5,0,0,'20210831213721',0,0,3562,0,'e0bslqbimp8p4ik0rbnpgnh9dqnkgzp'),(9,6,0,0,'20210831213811',0,0,3565,0,'30k8yoyy4fdd9nzur6vhpwwzh4wk950'),(10,7,0,0,'20210831214106',0,0,243664,0,'lzwb9l8eyo5m4p2o1zyacwa3uhnzwmj'),(11,7,0,0,'20210831214136',0,0,243670,10,'87f65c84275ilbhx5ig3neu6yrh7g2u');
/*!40000 ALTER TABLE `revision` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `revision_actor_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision_actor_temp` (
  `revactor_rev` int(10) unsigned NOT NULL,
  `revactor_actor` bigint(20) unsigned NOT NULL,
  `revactor_timestamp` binary(14) NOT NULL,
  `revactor_page` int(10) unsigned NOT NULL,
  PRIMARY KEY (`revactor_rev`,`revactor_actor`),
  UNIQUE KEY `revactor_rev` (`revactor_rev`),
  KEY `actor_timestamp` (`revactor_actor`,`revactor_timestamp`),
  KEY `page_actor_timestamp` (`revactor_page`,`revactor_actor`,`revactor_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `revision_actor_temp` WRITE;
/*!40000 ALTER TABLE `revision_actor_temp` DISABLE KEYS */;
INSERT INTO `revision_actor_temp` VALUES (1,2,'20210824004502',1),(2,3,'20210831213411',1),(3,3,'20210831213435',1),(7,3,'20210831213702',1),(4,3,'20210831213446',2),(5,3,'20210831213523',3),(6,3,'20210831213548',4),(8,3,'20210831213721',5),(9,3,'20210831213811',6),(10,3,'20210831214106',7),(11,3,'20210831214136',7);
/*!40000 ALTER TABLE `revision_actor_temp` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `revision_comment_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision_comment_temp` (
  `revcomment_rev` int(10) unsigned NOT NULL,
  `revcomment_comment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`revcomment_rev`,`revcomment_comment_id`),
  UNIQUE KEY `revcomment_rev` (`revcomment_rev`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `revision_comment_temp` WRITE;
/*!40000 ALTER TABLE `revision_comment_temp` DISABLE KEYS */;
INSERT INTO `revision_comment_temp` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,8),(10,9),(11,10);
/*!40000 ALTER TABLE `revision_comment_temp` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `site_identifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_identifiers` (
  `si_type` varbinary(32) NOT NULL,
  `si_key` varbinary(32) NOT NULL,
  `si_site` int(10) unsigned NOT NULL,
  PRIMARY KEY (`si_type`,`si_key`),
  KEY `si_site` (`si_site`),
  KEY `si_key` (`si_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `site_identifiers` WRITE;
/*!40000 ALTER TABLE `site_identifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_identifiers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `site_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_stats` (
  `ss_row_id` int(10) unsigned NOT NULL,
  `ss_total_edits` bigint(20) unsigned DEFAULT NULL,
  `ss_good_articles` bigint(20) unsigned DEFAULT NULL,
  `ss_total_pages` bigint(20) unsigned DEFAULT NULL,
  `ss_users` bigint(20) unsigned DEFAULT NULL,
  `ss_active_users` bigint(20) unsigned DEFAULT NULL,
  `ss_images` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`ss_row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `site_stats` WRITE;
/*!40000 ALTER TABLE `site_stats` DISABLE KEYS */;
INSERT INTO `site_stats` VALUES (1,10,1,6,2,0,0);
/*!40000 ALTER TABLE `site_stats` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `site_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_global_key` varbinary(64) NOT NULL,
  `site_type` varbinary(32) NOT NULL,
  `site_group` varbinary(32) NOT NULL,
  `site_source` varbinary(32) NOT NULL,
  `site_language` varbinary(35) NOT NULL,
  `site_protocol` varbinary(32) NOT NULL,
  `site_domain` varbinary(255) NOT NULL,
  `site_data` blob NOT NULL,
  `site_forward` tinyint(1) NOT NULL,
  `site_config` blob NOT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `site_global_key` (`site_global_key`),
  KEY `site_type` (`site_type`),
  KEY `site_group` (`site_group`),
  KEY `site_source` (`site_source`),
  KEY `site_language` (`site_language`),
  KEY `site_protocol` (`site_protocol`),
  KEY `site_domain` (`site_domain`),
  KEY `site_forward` (`site_forward`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `slot_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slot_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varbinary(64) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `slot_roles` WRITE;
/*!40000 ALTER TABLE `slot_roles` DISABLE KEYS */;
INSERT INTO `slot_roles` VALUES (1,'main');
/*!40000 ALTER TABLE `slot_roles` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slots` (
  `slot_revision_id` bigint(20) unsigned NOT NULL,
  `slot_role_id` smallint(5) unsigned NOT NULL,
  `slot_content_id` bigint(20) unsigned NOT NULL,
  `slot_origin` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`slot_revision_id`,`slot_role_id`),
  KEY `slot_revision_origin_role` (`slot_revision_id`,`slot_origin`,`slot_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `slots` WRITE;
/*!40000 ALTER TABLE `slots` DISABLE KEYS */;
INSERT INTO `slots` VALUES (1,1,1,1),(2,1,2,2),(3,1,3,3),(4,1,4,4),(5,1,5,5),(6,1,6,6),(7,1,7,7),(8,1,8,8),(9,1,9,9),(10,1,10,10),(11,1,11,11);
/*!40000 ALTER TABLE `slots` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `templatelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatelinks` (
  `tl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `tl_namespace` int(11) NOT NULL DEFAULT 0,
  `tl_title` varbinary(255) NOT NULL DEFAULT '',
  `tl_from_namespace` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tl_from`,`tl_namespace`,`tl_title`),
  KEY `tl_namespace` (`tl_namespace`,`tl_title`,`tl_from`),
  KEY `tl_backlinks_namespace` (`tl_from_namespace`,`tl_namespace`,`tl_title`,`tl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `templatelinks` WRITE;
/*!40000 ALTER TABLE `templatelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatelinks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `updatelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updatelog` (
  `ul_key` varbinary(255) NOT NULL,
  `ul_value` blob DEFAULT NULL,
  PRIMARY KEY (`ul_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `updatelog` WRITE;
/*!40000 ALTER TABLE `updatelog` DISABLE KEYS */;
INSERT INTO `updatelog` VALUES ('PingBack','8d27bccb327d1cb2cdb2e42ac201277f'),('Pingback-1.36.1','1629766486'),('filearchive-fa_major_mime-patch-fa_major_mime-chemical.sql',NULL),('image-img_major_mime-patch-img_major_mime-chemical.sql',NULL),('oldimage-oi_major_mime-patch-oi_major_mime-chemical.sql',NULL),('user_former_groups-ufg_group-patch-ufg_group-length-increase-255.sql',NULL),('user_groups-ug_group-patch-ug_group-length-increase-255.sql',NULL),('user_properties-up_property-patch-up_property.sql',NULL);
/*!40000 ALTER TABLE `updatelog` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `uploadstash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uploadstash` (
  `us_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `us_user` int(10) unsigned NOT NULL,
  `us_key` varbinary(255) NOT NULL,
  `us_orig_path` varbinary(255) NOT NULL,
  `us_path` varbinary(255) NOT NULL,
  `us_source_type` varbinary(50) DEFAULT NULL,
  `us_timestamp` binary(14) NOT NULL,
  `us_status` varbinary(50) NOT NULL,
  `us_chunk_inx` int(10) unsigned DEFAULT NULL,
  `us_props` blob DEFAULT NULL,
  `us_size` int(10) unsigned NOT NULL,
  `us_sha1` varbinary(31) NOT NULL,
  `us_mime` varbinary(255) DEFAULT NULL,
  `us_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `us_image_width` int(10) unsigned DEFAULT NULL,
  `us_image_height` int(10) unsigned DEFAULT NULL,
  `us_image_bits` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`us_id`),
  UNIQUE KEY `us_key` (`us_key`),
  KEY `us_user` (`us_user`),
  KEY `us_timestamp` (`us_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `uploadstash` WRITE;
/*!40000 ALTER TABLE `uploadstash` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploadstash` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varbinary(255) NOT NULL DEFAULT '',
  `user_real_name` varbinary(255) NOT NULL DEFAULT '',
  `user_password` tinyblob NOT NULL,
  `user_newpassword` tinyblob NOT NULL,
  `user_newpass_time` binary(14) DEFAULT NULL,
  `user_email` tinyblob NOT NULL,
  `user_touched` binary(14) NOT NULL,
  `user_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_email_authenticated` binary(14) DEFAULT NULL,
  `user_email_token` binary(32) DEFAULT NULL,
  `user_email_token_expires` binary(14) DEFAULT NULL,
  `user_registration` binary(14) DEFAULT NULL,
  `user_editcount` int(11) DEFAULT NULL,
  `user_password_expires` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `user_email_token` (`user_email_token`),
  KEY `user_email` (`user_email`(50))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Flip','',':pbkdf2:sha512:30000:64:cDZiOQPvSbB4Cr3EZSSFgA==:zH+8tU8dtioKPBoMSLWNqd5ymaxBLoZ6vSgfjWNmmY7r2yyJfV9/wmwWoGMye/evRVAKJy02PMkPTW36Gf17wQ==','',NULL,'brooke@badgerfaction.com','20210824004503','1c821942de8ae2bb0b344c3f5fed9ef2',NULL,NULL,NULL,'20210824004502',0,NULL),(2,'MediaWiki default','','','',NULL,'','20210824004502','*** INVALID ***\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,NULL,NULL,'20210824004502',0,NULL),(3,'Bloop','Blooper',':pbkdf2:sha512:30000:64:q61gfs6xm3aAXffN0pROhw==:Z2UykvY5je9Qe+pe+CKzPARbgDieFBmhF2HBnM6WZInppTivQAzJj3h03iCFxBN59U80y60V3bciUFFm6zeHnA==','',NULL,'','20210831213245','dc292dc03acaf688eb4d2b0089d0cb0c',NULL,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,'20210831213244',10,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_former_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_former_groups` (
  `ufg_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ufg_group` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ufg_user`,`ufg_group`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_former_groups` WRITE;
/*!40000 ALTER TABLE `user_former_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_former_groups` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `ug_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ug_group` varbinary(255) NOT NULL DEFAULT '',
  `ug_expiry` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`ug_user`,`ug_group`),
  KEY `ug_group` (`ug_group`),
  KEY `ug_expiry` (`ug_expiry`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` VALUES (1,'bureaucrat',NULL),(1,'interface-admin',NULL),(1,'sysop',NULL);
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_newtalk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_newtalk` (
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `user_ip` varbinary(40) NOT NULL DEFAULT '',
  `user_last_timestamp` binary(14) DEFAULT NULL,
  KEY `un_user_id` (`user_id`),
  KEY `un_user_ip` (`user_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_newtalk` WRITE;
/*!40000 ALTER TABLE `user_newtalk` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_newtalk` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_properties` (
  `up_user` int(10) unsigned NOT NULL,
  `up_property` varbinary(255) NOT NULL,
  `up_value` blob DEFAULT NULL,
  PRIMARY KEY (`up_user`,`up_property`),
  KEY `up_property` (`up_property`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_properties` WRITE;
/*!40000 ALTER TABLE `user_properties` DISABLE KEYS */;
INSERT INTO `user_properties` VALUES (3,'VectorSkinVersion','1');
/*!40000 ALTER TABLE `user_properties` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchlist` (
  `wl_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wl_user` int(10) unsigned NOT NULL,
  `wl_namespace` int(11) NOT NULL DEFAULT 0,
  `wl_title` varbinary(255) NOT NULL DEFAULT '',
  `wl_notificationtimestamp` binary(14) DEFAULT NULL,
  PRIMARY KEY (`wl_id`),
  UNIQUE KEY `wl_user` (`wl_user`,`wl_namespace`,`wl_title`),
  KEY `wl_namespace_title` (`wl_namespace`,`wl_title`),
  KEY `wl_user_notificationtimestamp` (`wl_user`,`wl_notificationtimestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `watchlist` WRITE;
/*!40000 ALTER TABLE `watchlist` DISABLE KEYS */;
INSERT INTO `watchlist` VALUES (1,3,2,'Bloop',NULL),(2,3,3,'Bloop',NULL),(3,3,0,'Main_Page',NULL),(4,3,1,'Main_Page',NULL),(5,3,0,'Pagey',NULL),(6,3,1,'Pagey',NULL),(7,3,0,'This',NULL),(8,3,1,'This',NULL),(9,3,0,'That',NULL),(10,3,1,'That',NULL),(11,3,0,'Dream',NULL),(12,3,1,'Dream',NULL);
/*!40000 ALTER TABLE `watchlist` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `watchlist_expiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchlist_expiry` (
  `we_item` int(10) unsigned NOT NULL,
  `we_expiry` binary(14) NOT NULL,
  PRIMARY KEY (`we_item`),
  KEY `we_expiry` (`we_expiry`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `watchlist_expiry` WRITE;
/*!40000 ALTER TABLE `watchlist_expiry` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchlist_expiry` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
