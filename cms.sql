-- phpMyAdmin SQL Dump
-- version 3.5.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 30, 2013 at 05:41 PM
-- Server version: 5.5.29-0ubuntu0.12.04.2
-- PHP Version: 5.3.10-1ubuntu3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cms`
--

-- --------------------------------------------------------

--
-- Table structure for table `cms_code`
--

CREATE TABLE IF NOT EXISTS `cms_code` (
  `code_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code_title` varchar(50) NOT NULL,
  `code_project` varchar(20) NOT NULL,
  `code_language` varchar(20) NOT NULL,
  `code_summary` varchar(140) NOT NULL,
  `code_location` varchar(60) NOT NULL,
  `code_addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `code_updatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `code_author` varchar(50) NOT NULL,
  `code_source` longtext NOT NULL,
  `code_description` longtext NOT NULL,
  PRIMARY KEY (`code_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- Dumping data for table `cms_code`
--

INSERT INTO `cms_code` (`code_ID`, `code_title`, `code_project`, `code_language`, `code_summary`, `code_location`, `code_addtime`, `code_updatetime`, `code_author`, `code_source`, `code_description`) VALUES
(24, 'Mysql2', 'cms', 'php', '数据库语句封装', 'cms/class/class-mysql.php', '2013-03-22 14:11:36', '2013-03-22 14:12:50', '流浪小猫', '<?php\r\n/**\r\n * 类名: Mysql\r\n * 功能: 数据库语句封装\r\n * 属性: $server, $user, $password, $database, $charset, $link\r\n * 方法: connet, query, fetcharray, fetchall, numrows, numfields, affectedrows, version, insertid, close, error\r\n * 说明: 数据库连接，查询等操作\r\n */\r\nclass Mysql {\r\n    private $server;    // 服务器名\r\n    private $user;      // 数据库用户名\r\n    private $password;  // 数据库密码\r\n    private $database;  // 数据库名\r\n    private $charset;   // 数据库编码,默认为utf8\r\n    private $link;      // mysql连接标识符\r\n    /**\r\n     * 方法: __construct\r\n     * 功能: 构造函数\r\n     * 参数: $server, $user, $password, $database, $charset\r\n     * 说明: 实例化时自动连接数据库\r\n     */\r\n    public function __construct($server, $user, $password, $database, $charset = ''utf8'') {\r\n        $this->server = $server;\r\n        $this->user = $user;\r\n        $this->password = $password;\r\n        $this->database = $database;\r\n        $this->charset = $charset;\r\n        $this->connect();\r\n    }\r\n    /**\r\n     * 方法: connect\r\n     * 功能: 连接数据库\r\n     * 参数: 无\r\n     * 说明: 连接mysql服务器,连接数据库,设置字符编码\r\n     */\r\n    private function connect() {\r\n        $this->link = mysql_connect($this->server, $this->user, $this->password) or die($this->error("数据库服务器连接出错!"));\r\n        mysql_select_db($this->database, $this->link) or die($this->error("数据库连接出错!"));\r\n        mysql_query("set names ''$this->charset''");\r\n    }\r\n    /**\r\n     * 方法: query\r\n     * 功能: 执行sql\r\n     * 参数: $sql\r\n     * 说明: 对传过来的sql语句执行,并返回结果$result资源标识符\r\n     */\r\n    public function query($sql) {\r\n        $result = mysql_query($sql, $this->link);\r\n        if ( !$result ) {\r\n            $this->error($sql . "语句执行失败!");\r\n            return false;\r\n        } else {\r\n            return $result;\r\n        }\r\n    }\r\n    /**\r\n     * 方法: fetcharray\r\n     * 功能: 从结果集中取一行做为数组\r\n     * 参数: $result资源标识符\r\n     * 说明: 需要提供sql语句执行返回的资源标识符\r\n     */\r\n    public function fetcharray($result) {\r\n        return mysql_fetch_array($result);\r\n    }\r\n    /**\r\n     * 方法: fetchall\r\n     * 功能: 从结果集中取出所有记录做为二维数组$arr\r\n     * 参数: $result资源标识符\r\n     * 说明: 循环取所有记录保存为$arr\r\n     */\r\n    public function fetchall($result) {\r\n        $arr = array ();\r\n        while ( $row = mysql_fetch_array($result) ) {\r\n            $arr[] = $row;\r\n        }\r\n        mysql_free_result($result);\r\n        return $arr;\r\n    }\r\n    /**\r\n     * 方法: numrows\r\n     * 功能: 统计结果集中记录数\r\n     * 参数: $result资源标识符\r\n     * 说明: 统计行数\r\n     */\r\n    public function numrows($result) {\r\n        return mysql_num_rows($result);\r\n    }\r\n    /**\r\n     * 方法: numfields\r\n     * 功能: 统计结果集中字段数\r\n     * 参数: $result资源标识符\r\n     * 说明: 统计字段数\r\n     */\r\n    public function numfields($result) {\r\n        return mysql_num_fields($result);\r\n    }\r\n    /**\r\n     * 方法: affectedrows\r\n     * 功能: 取得前一次mysql操作所影响的记录行数\r\n     * 参数: 无\r\n     * 说明: 取得前一次mysql操作所影响的记录行数\r\n     */\r\n    public function affectedrows() {\r\n        return mysql_affected_rows($this->link);\r\n    }\r\n    /**\r\n     * 方法: version\r\n     * 功能: 取得mysql版本\r\n     * 参数: 无\r\n     * 说明: 取得当前数据库服务器mysql的版本\r\n     */\r\n    public function version() {\r\n        return mysql_get_server_info();\r\n    }\r\n    /**\r\n     * 方法: insertid\r\n     * 功能: 取得上一步insert操作产生的id\r\n     * 参数: 无\r\n     * 说明: 取得上一步insert操作产生的自增字段id\r\n     */\r\n    public function insertid() {\r\n        return mysql_insert_id($this->link);\r\n    }\r\n    /**\r\n     * 方法: close\r\n     * 功能: 关闭连接\r\n     * 参数: 无\r\n     * 说明: 关闭非永久数据库连接\r\n     */\r\n    private function close() {\r\n        mysql_close($this->link);\r\n    }\r\n    /**\r\n     * 方法: error\r\n     * 功能: 提示错误\r\n     * 参数: $err_msg\r\n     * 说明: 对给出的错误提示内容给予echo\r\n     */\r\n    private function error($err_msg = "") {\r\n        if ( $err_msg == "" ) {\r\n            echo "errno: " . mysql_errno . "</br>";\r\n            echo "error: " . mysql_error . "</br>";\r\n        } else {\r\n            echo $err_msg;\r\n        }\r\n    }\r\n    /**\r\n     * 方法: __destruct\r\n     * 功能: 析构函数\r\n     * 参数: 无\r\n     * 说明: 释放类,关闭连接\r\n     */\r\n    public function __destruct() {\r\n        $this->close();\r\n    }\r\n}\r\n?>', '<h5>Mysql数据库语句封装</h5>                                                                                               \r\n<p>这个类的作用是将mysql语句进行封装，方便使用，详细如下：</p>\r\n<p>属性：$server, $user, $password, $database, $charset, $link</p>\r\n<p>方法: connet, query, fetcharray, fetchall, numrows, numfields, affectedrows, version, insertid, close, error</p>\r\n<h6>方法：query</h6>\r\n<p>功能: 执行sql语句</p>\r\n<p>参数: $sql</p> \r\n<p>说明: 对传过来的sql语句执行,并返回结果$result资源标识符</p>\r\n<h6>方法: fetcharray</h6> \r\n<p>功能: 从结果集中取一行做为数组</p>\r\n<p>参数: $result资源标识符</p> \r\n<p>说明: 需要提供sql语句执行返回的资源标识符</p>\r\n<h6>方法: fetchall</h6> \r\n<p>功能: 从结果集中取出所有记录做为二维数组$arr</p>\r\n<p>参数: $result资源标识符</p> \r\n<p>说明: 循环取所有记录保存为$arr</p>\r\n<h6>使用例子：</h6>\r\n<pre>&lt;?php \r\n    $mysql = new Mysql("localhost", "root", "123456", "cms");\r\n    // 建立到cms数据库的连接\r\n    $result = $mysql-&gt;query("select * from cms_user");\r\n    // 执行sql语句\r\n    $array = $mysql-&gt;fetchall($result);\r\n    // 将结果集转为二维数组\r\n?&gt;</pre>'),
(28, '.html2()', 'jquery', 'jquery', '获取html内容', 'jquery-1.8.3.js', '2013-03-22 17:28:43', '2013-03-23 14:12:50', '管理员', '', '<h5>.html()</h5>\r\n<p>返回： String</p>\r\n<p>从匹配的第一个元素中获取HTML内容。</p>\r\n<p>这个方法对 XML 文档无效。</p>\r\n<p>在一个 HTML 文档中, 我们可以使用.html()方法来获取任意一个元素的内容。 如果选择器匹配多于一个的元素，那么只有第一个匹配元素的 HTML 内容会被获取。 考虑下面的代码：</p>\r\n<pre>$(''div.demo-container'').html();</pre>\r\n<p>下文的获取的&lt;div&gt;的内容，必定是在文档中的第一个class=&quot;demo-container&quot;的div中获取的：</p>\r\n<pre>&lt;div class="demo-container"&gt;\r\n    &lt;div class="demo-box"&gt;Demonstration Box&lt;/div&gt;\r\n&lt;/div&gt;</pre>\r\n<p>结果如下:</p>\r\n<pre>&lt;div class="demo-box"&gt;Demonstration Box&lt;/div&gt;</pre>\r\n<h6>举例：</h6>\r\n<p>点击段落将HTML转化为文本</p>\r\n<pre>&lt;!DOCTYPE html&gt;\r\n&lt;html&gt;\r\n&lt;head&gt;\r\n&lt;style&gt;\r\n    p { margin:8px; font-size:20px; color:blue; cursor:pointer; }\r\n    b { text-decoration:underline; }\r\n    button { cursor:pointer; }\r\n&lt;/style&gt;\r\n&lt;script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"&gt;&lt;/script&gt;\r\n&lt;/head&gt;\r\n&lt;body&gt;\r\n&lt;p&gt;\r\n    &lt;b&gt;Click&lt;/b&gt; to change the &lt;span id="tag"&gt;html&lt;/span&gt;\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n    to a &lt;span id="text"&gt;text&lt;/span&gt; node.\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n    This\r\n    &lt;button name="nada"&gt;button&lt;/button&gt; does nothing.\r\n&lt;/p&gt;\r\n&lt;script&gt;\r\n$("p").click(function () {\r\n    var htmlStr = $(this).html();\r\n    $(this).text(htmlStr);\r\n});\r\n&lt;/script&gt;\r\n&lt;/body&gt;\r\n&lt;/html&gt;</pre>'),
(29, 'css派生选择器2', 'css', 'css', 'css派生选择器', '', '2013-03-23 06:11:43', '2013-03-24 14:12:50', '管理员', '', '<h5>\r\n    派生选择器<br />\r\n</h5>\r\n<h6>\r\n    通过依据元素在其位置的上下文关系来定义样式，你可以使标记更加简洁。<br />\r\n</h6>\r\n<p>\r\n    在 CSS1 中，通过这种方式来应用规则的选择器被称为上下文选择器 (contextual selectors)，这是由于它们依赖于上下文关系来应用或者避免某项规则。在 CSS2 中，它们称为派生选择器，但是无论你如何称呼它们，它们的作用都是相同的。\r\n</p>\r\n<p>\r\n    派生选择器允许你根据文档的上下文关系来确定某个标签的样式。通过合理地使用派生选择器，我们可以使 HTML 代码变得更加整洁。\r\n</p>\r\n<p>\r\n    比方说，你希望列表中的 strong 元素变为斜体字，而不是通常的粗体字，可以这样定义一个派生选择器：\r\n</p>\r\n<pre>\r\n    li strong {\r\n    font-style: italic;\r\n    font-weight: normal;\r\n}\r\n</pre>\r\n<pre>\r\n    &lt;p&gt;&lt;strong&gt;我是粗体字，不是斜体字，因为我不在列表当中，所以这个规则对我不起作用&lt;/strong&gt;&lt;/p&gt;\r\n&lt;ol&gt;\r\n&lt;li&gt;&lt;strong&gt;我是斜体字。这是因为 strong 元素位于 li 元素内。&lt;/strong&gt;&lt;/li&gt;\r\n&lt;li&gt;我是正常的字体。&lt;/li&gt;\r\n&lt;/ol&gt;\r\n</pre>\r\n<p>在上面的例子中，只有 li 元素中的 strong 元素的样式为斜体字，无需为 strong 元素定义特别的 class 或 id，代码更加简洁。</p>'),
(30, 'Mysql', 'cms', 'php', '数据库语句封装', 'cms/class/class-mysql.php', '2013-03-22 14:11:36', '2013-03-25 14:12:50', '流浪小猫', '<?php\r\n/**\r\n * 类名: Mysql\r\n * 功能: 数据库语句封装\r\n * 属性: $server, $user, $password, $database, $charset, $link\r\n * 方法: connet, query, fetcharray, fetchall, numrows, numfields, affectedrows, version, insertid, close, error\r\n * 说明: 数据库连接，查询等操作\r\n */\r\nclass Mysql {\r\n    private $server;    // 服务器名\r\n    private $user;      // 数据库用户名\r\n    private $password;  // 数据库密码\r\n    private $database;  // 数据库名\r\n    private $charset;   // 数据库编码,默认为utf8\r\n    private $link;      // mysql连接标识符\r\n    /**\r\n     * 方法: __construct\r\n     * 功能: 构造函数\r\n     * 参数: $server, $user, $password, $database, $charset\r\n     * 说明: 实例化时自动连接数据库\r\n     */\r\n    public function __construct($server, $user, $password, $database, $charset = ''utf8'') {\r\n        $this->server = $server;\r\n        $this->user = $user;\r\n        $this->password = $password;\r\n        $this->database = $database;\r\n        $this->charset = $charset;\r\n        $this->connect();\r\n    }\r\n    /**\r\n     * 方法: connect\r\n     * 功能: 连接数据库\r\n     * 参数: 无\r\n     * 说明: 连接mysql服务器,连接数据库,设置字符编码\r\n     */\r\n    private function connect() {\r\n        $this->link = mysql_connect($this->server, $this->user, $this->password) or die($this->error("数据库服务器连接出错!"));\r\n        mysql_select_db($this->database, $this->link) or die($this->error("数据库连接出错!"));\r\n        mysql_query("set names ''$this->charset''");\r\n    }\r\n    /**\r\n     * 方法: query\r\n     * 功能: 执行sql\r\n     * 参数: $sql\r\n     * 说明: 对传过来的sql语句执行,并返回结果$result资源标识符\r\n     */\r\n    public function query($sql) {\r\n        $result = mysql_query($sql, $this->link);\r\n        if ( !$result ) {\r\n            $this->error($sql . "语句执行失败!");\r\n            return false;\r\n        } else {\r\n            return $result;\r\n        }\r\n    }\r\n    /**\r\n     * 方法: fetcharray\r\n     * 功能: 从结果集中取一行做为数组\r\n     * 参数: $result资源标识符\r\n     * 说明: 需要提供sql语句执行返回的资源标识符\r\n     */\r\n    public function fetcharray($result) {\r\n        return mysql_fetch_array($result);\r\n    }\r\n    /**\r\n     * 方法: fetchall\r\n     * 功能: 从结果集中取出所有记录做为二维数组$arr\r\n     * 参数: $result资源标识符\r\n     * 说明: 循环取所有记录保存为$arr\r\n     */\r\n    public function fetchall($result) {\r\n        $arr = array ();\r\n        while ( $row = mysql_fetch_array($result) ) {\r\n            $arr[] = $row;\r\n        }\r\n        mysql_free_result($result);\r\n        return $arr;\r\n    }\r\n    /**\r\n     * 方法: numrows\r\n     * 功能: 统计结果集中记录数\r\n     * 参数: $result资源标识符\r\n     * 说明: 统计行数\r\n     */\r\n    public function numrows($result) {\r\n        return mysql_num_rows($result);\r\n    }\r\n    /**\r\n     * 方法: numfields\r\n     * 功能: 统计结果集中字段数\r\n     * 参数: $result资源标识符\r\n     * 说明: 统计字段数\r\n     */\r\n    public function numfields($result) {\r\n        return mysql_num_fields($result);\r\n    }\r\n    /**\r\n     * 方法: affectedrows\r\n     * 功能: 取得前一次mysql操作所影响的记录行数\r\n     * 参数: 无\r\n     * 说明: 取得前一次mysql操作所影响的记录行数\r\n     */\r\n    public function affectedrows() {\r\n        return mysql_affected_rows($this->link);\r\n    }\r\n    /**\r\n     * 方法: version\r\n     * 功能: 取得mysql版本\r\n     * 参数: 无\r\n     * 说明: 取得当前数据库服务器mysql的版本\r\n     */\r\n    public function version() {\r\n        return mysql_get_server_info();\r\n    }\r\n    /**\r\n     * 方法: insertid\r\n     * 功能: 取得上一步insert操作产生的id\r\n     * 参数: 无\r\n     * 说明: 取得上一步insert操作产生的自增字段id\r\n     */\r\n    public function insertid() {\r\n        return mysql_insert_id($this->link);\r\n    }\r\n    /**\r\n     * 方法: close\r\n     * 功能: 关闭连接\r\n     * 参数: 无\r\n     * 说明: 关闭非永久数据库连接\r\n     */\r\n    private function close() {\r\n        mysql_close($this->link);\r\n    }\r\n    /**\r\n     * 方法: error\r\n     * 功能: 提示错误\r\n     * 参数: $err_msg\r\n     * 说明: 对给出的错误提示内容给予echo\r\n     */\r\n    private function error($err_msg = "") {\r\n        if ( $err_msg == "" ) {\r\n            echo "errno: " . mysql_errno . "</br>";\r\n            echo "error: " . mysql_error . "</br>";\r\n        } else {\r\n            echo $err_msg;\r\n        }\r\n    }\r\n    /**\r\n     * 方法: __destruct\r\n     * 功能: 析构函数\r\n     * 参数: 无\r\n     * 说明: 释放类,关闭连接\r\n     */\r\n    public function __destruct() {\r\n        $this->close();\r\n    }\r\n}\r\n?>', '<h5>Mysql数据库语句封装</h5>                                                                                               \r\n<p>这个类的作用是将mysql语句进行封装，方便使用，详细如下：</p>\r\n<p>属性：$server, $user, $password, $database, $charset, $link</p>\r\n<p>方法: connet, query, fetcharray, fetchall, numrows, numfields, affectedrows, version, insertid, close, error</p>\r\n<h6>方法：query</h6>\r\n<p>功能: 执行sql语句</p>\r\n<p>参数: $sql</p> \r\n<p>说明: 对传过来的sql语句执行,并返回结果$result资源标识符</p>\r\n<h6>方法: fetcharray</h6> \r\n<p>功能: 从结果集中取一行做为数组</p>\r\n<p>参数: $result资源标识符</p> \r\n<p>说明: 需要提供sql语句执行返回的资源标识符</p>\r\n<h6>方法: fetchall</h6> \r\n<p>功能: 从结果集中取出所有记录做为二维数组$arr</p>\r\n<p>参数: $result资源标识符</p> \r\n<p>说明: 循环取所有记录保存为$arr</p>\r\n<h6>使用例子：</h6>\r\n<pre>&lt;?php \r\n    $mysql = new Mysql("localhost", "root", "123456", "cms");\r\n    // 建立到cms数据库的连接\r\n    $result = $mysql-&gt;query("select * from cms_user");\r\n    // 执行sql语句\r\n    $array = $mysql-&gt;fetchall($result);\r\n    // 将结果集转为二维数组\r\n?&gt;</pre>'),
(31, '.html()', 'jquery', 'jquery', '获取html内容', 'jquery-1.8.3.js', '2013-03-22 17:28:43', '2013-03-26 14:12:50', '管理员', '', '<h5>.html()</h5>\r\n<p>返回： String</p>\r\n<p>从匹配的第一个元素中获取HTML内容。</p>\r\n<p>这个方法对 XML 文档无效。</p>\r\n<p>在一个 HTML 文档中, 我们可以使用.html()方法来获取任意一个元素的内容。 如果选择器匹配多于一个的元素，那么只有第一个匹配元素的 HTML 内容会被获取。 考虑下面的代码：</p>\r\n<pre>$(''div.demo-container'').html();</pre>\r\n<p>下文的获取的&lt;div&gt;的内容，必定是在文档中的第一个class=&quot;demo-container&quot;的div中获取的：</p>\r\n<pre>&lt;div class="demo-container"&gt;\r\n    &lt;div class="demo-box"&gt;Demonstration Box&lt;/div&gt;\r\n&lt;/div&gt;</pre>\r\n<p>结果如下:</p>\r\n<pre>&lt;div class="demo-box"&gt;Demonstration Box&lt;/div&gt;</pre>\r\n<h6>举例：</h6>\r\n<p>点击段落将HTML转化为文本</p>\r\n<pre>&lt;!DOCTYPE html&gt;\r\n&lt;html&gt;\r\n&lt;head&gt;\r\n&lt;style&gt;\r\n    p { margin:8px; font-size:20px; color:blue; cursor:pointer; }\r\n    b { text-decoration:underline; }\r\n    button { cursor:pointer; }\r\n&lt;/style&gt;\r\n&lt;script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"&gt;&lt;/script&gt;\r\n&lt;/head&gt;\r\n&lt;body&gt;\r\n&lt;p&gt;\r\n    &lt;b&gt;Click&lt;/b&gt; to change the &lt;span id="tag"&gt;html&lt;/span&gt;\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n    to a &lt;span id="text"&gt;text&lt;/span&gt; node.\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n    This\r\n    &lt;button name="nada"&gt;button&lt;/button&gt; does nothing.\r\n&lt;/p&gt;\r\n&lt;script&gt;\r\n$("p").click(function () {\r\n    var htmlStr = $(this).html();\r\n    $(this).text(htmlStr);\r\n});\r\n&lt;/script&gt;\r\n&lt;/body&gt;\r\n&lt;/html&gt;</pre>'),
(32, 'css派生选择器', 'css', 'css', 'css派生选择器', '', '2013-03-23 06:11:43', '2013-03-27 14:12:50', '管理员', '', '<h5>\r\n    派生选择器<br />\r\n</h5>\r\n<h6>\r\n    通过依据元素在其位置的上下文关系来定义样式，你可以使标记更加简洁。<br />\r\n</h6>\r\n<p>\r\n    在 CSS1 中，通过这种方式来应用规则的选择器被称为上下文选择器 (contextual selectors)，这是由于它们依赖于上下文关系来应用或者避免某项规则。在 CSS2 中，它们称为派生选择器，但是无论你如何称呼它们，它们的作用都是相同的。\r\n</p>\r\n<p>\r\n    派生选择器允许你根据文档的上下文关系来确定某个标签的样式。通过合理地使用派生选择器，我们可以使 HTML 代码变得更加整洁。\r\n</p>\r\n<p>\r\n    比方说，你希望列表中的 strong 元素变为斜体字，而不是通常的粗体字，可以这样定义一个派生选择器：\r\n</p>\r\n<pre>\r\n    li strong {\r\n    font-style: italic;\r\n    font-weight: normal;\r\n}\r\n</pre>\r\n<pre>\r\n    &lt;p&gt;&lt;strong&gt;我是粗体字，不是斜体字，因为我不在列表当中，所以这个规则对我不起作用&lt;/strong&gt;&lt;/p&gt;\r\n&lt;ol&gt;\r\n&lt;li&gt;&lt;strong&gt;我是斜体字。这是因为 strong 元素位于 li 元素内。&lt;/strong&gt;&lt;/li&gt;\r\n&lt;li&gt;我是正常的字体。&lt;/li&gt;\r\n&lt;/ol&gt;\r\n</pre>\r\n<p>在上面的例子中，只有 li 元素中的 strong 元素的样式为斜体字，无需为 strong 元素定义特别的 class 或 id，代码更加简洁。</p>');

-- --------------------------------------------------------

--
-- Table structure for table `cms_comment`
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
-- Table structure for table `cms_label`
--

CREATE TABLE IF NOT EXISTS `cms_label` (
  `label_codeid` bigint(20) unsigned NOT NULL,
  `label_content` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cms_label`
--

INSERT INTO `cms_label` (`label_codeid`, `label_content`) VALUES
(31, 'jquery'),
(31, 'javascript'),
(28, 'jquery');

-- --------------------------------------------------------

--
-- Table structure for table `cms_user`
--

CREATE TABLE IF NOT EXISTS `cms_user` (
  `user_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account` varchar(50) NOT NULL,
  `user_password` varchar(64) NOT NULL,
  `user_nickname` varchar(50) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_phonenum` varchar(20) NOT NULL,
  `user_signintime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `cms_user`
--

INSERT INTO `cms_user` (`user_ID`, `user_account`, `user_password`, `user_nickname`, `user_email`, `user_phonenum`, `user_signintime`) VALUES
(1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员', 'admin@admin.admin', '12345678901', '2013-03-05 06:18:34'),
(2, 'liuyicheng', 'e10adc3949ba59abbe56e057f20f883e', '流浪小猫', 'yichengliu2013@gmail.com', '13476229542', '2013-03-14 10:44:02'),
(3, 'niewenhui', 'e10adc3949ba59abbe56e057f20f883e', 'MoMo', '', '', '2013-03-14 10:44:02');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
