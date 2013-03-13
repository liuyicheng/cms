-- phpMyAdmin SQL Dump
-- version 3.5.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2013 年 03 月 13 日 12:15
-- 服务器版本: 5.5.29-0ubuntu0.12.04.2
-- PHP 版本: 5.3.10-1ubuntu3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `cms`
--

-- --------------------------------------------------------

--
-- 表的结构 `cms_code`
--

CREATE TABLE IF NOT EXISTS `cms_code` (
  `code_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code_title` varchar(50) NOT NULL,
  `code_projectid` int(10) unsigned NOT NULL,
  `code_type` varchar(20) NOT NULL,
  `code_summary` varchar(140) NOT NULL,
  `code_location` varchar(60) NOT NULL,
  `code_addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `code_updatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `code_userid` int(10) unsigned NOT NULL,
  `code_source` text NOT NULL,
  `code_description` text NOT NULL,
  `code_examples` text NOT NULL,
  `code_status` int(10) NOT NULL DEFAULT '1' COMMENT '1表示可用，0表示停用',
  PRIMARY KEY (`code_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `cms_code`
--

INSERT INTO `cms_code` (`code_ID`, `code_title`, `code_projectid`, `code_type`, `code_summary`, `code_location`, `code_addtime`, `code_updatetime`, `code_userid`, `code_source`, `code_description`, `code_examples`, `code_status`) VALUES
(1, 'example', 1, 'javascript', 'This is an example', '/example.js', '2013-03-08 06:45:11', '2013-03-09 16:00:00', 1, '/**\n * This is an example\n */\nfunction example(somewords) {\n    alert(somewords);\n    console.log(somewords);\n}', '这是一个代码示例，这里写个简短的介绍。', '<body>\n<script>\nexample(''Hello World!'');\n</script>\n</body>', 1),
(2, 'example2', 1, 'php', 'This is an example', '/example.php', '2013-03-08 06:45:11', '2013-03-09 16:00:00', 1, '/**\r\n * This is an example2\r\n */\r\nfunction example2(somewords) {\r\n    echo(somewords);\r\n    return somewords;\r\n}', '这是一个代码示例，这里写个简短的介绍。', '<?php\r\nexample(''Hello World!'');\r\n?>', 1);

-- --------------------------------------------------------

--
-- 表的结构 `cms_comment`
--

CREATE TABLE IF NOT EXISTS `cms_comment` (
  `comment_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comment_codeid` int(10) unsigned NOT NULL,
  `comment_userid` int(10) unsigned NOT NULL,
  `comment_type` int(1) NOT NULL,
  `comment_content` text NOT NULL,
  PRIMARY KEY (`comment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `cms_project`
--

CREATE TABLE IF NOT EXISTS `cms_project` (
  `project_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_title` varchar(50) NOT NULL,
  `project_description` text NOT NULL,
  PRIMARY KEY (`project_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `cms_project`
--

INSERT INTO `cms_project` (`project_ID`, `project_title`, `project_description`) VALUES
(1, 'project', 'project description');

-- --------------------------------------------------------

--
-- 表的结构 `cms_user`
--

CREATE TABLE IF NOT EXISTS `cms_user` (
  `user_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account` varchar(50) NOT NULL,
  `user_password` varchar(64) NOT NULL,
  `user_nickname` varchar(50) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_phonenum` varchar(20) NOT NULL,
  `user_registered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_status` int(10) NOT NULL DEFAULT '1' COMMENT '1表示可用，0表示停用',
  PRIMARY KEY (`user_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `cms_user`
--

INSERT INTO `cms_user` (`user_ID`, `user_account`, `user_password`, `user_nickname`, `user_email`, `user_phonenum`, `user_registered`, `user_status`) VALUES
(1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin', 'admin@admin.admin', '12345678901', '2013-03-05 06:18:34', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
