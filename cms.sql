-- phpMyAdmin SQL Dump
-- version 3.5.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 18, 2013 at 11:21 AM
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
  `code_projectid` int(10) unsigned NOT NULL,
  `code_language` varchar(20) NOT NULL,
  `code_summary` varchar(140) NOT NULL,
  `code_location` varchar(60) NOT NULL,
  `code_addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `code_updatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `code_authorid` int(10) unsigned NOT NULL,
  `code_source` longtext NOT NULL,
  `code_description` longtext NOT NULL,
  PRIMARY KEY (`code_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `cms_code`
--

INSERT INTO `cms_code` (`code_ID`, `code_title`, `code_projectid`, `code_language`, `code_summary`, `code_location`, `code_addtime`, `code_updatetime`, `code_authorid`, `code_source`, `code_description`) VALUES
(1, 'Hello World!', 1, '', 'Welcome to the Code Management System', '', '2013-03-08 06:45:11', '2013-03-14 12:15:40', 1, '// 这里是源代码', '欢迎'),
(2, 'example2', 1, 'php', 'This is an example', '/example.php', '2013-03-08 06:45:11', '2013-03-09 16:00:00', 1, '/**\r\n * This is an example2\r\n */\r\nfunction example2(somewords) {\r\n    echo(somewords);\r\n    return somewords;\r\n}', '这是一个代码示例，这里写个简短的介绍。'),
(3, 'alert', 1, 'javascript', 'alert this', '/alert.js', '2013-03-14 14:37:10', '2013-03-14 15:15:40', 1, 'function alert() {\r\n    alert();\r\n}', 'alert'),
(4, 'jquery-cms.js', 1, 'javascript', '', '/cms/js/jquery-cms.js', '2013-03-15 07:16:12', '0000-00-00 00:00:00', 1, '/**\r\n * jquery-cms.js\r\n **/\r\n(function($) {\r\n    $.cms = {\r\n        sign: {\r\n            postSignIn: function($signInForm) {\r\n                var account = $signInForm.find(''#account'').val();\r\n                    password = $signInForm.find(''#password'').val();\r\n                $.post("post.php", {\r\n                    ''type'': ''signIn'',\r\n                    ''account'': account,\r\n                    ''password'': password\r\n                }, function(data) {\r\n                    if (data.status === ''success'') {\r\n                        window.location.href = ''index.php'';\r\n                    } else {\r\n                        $.cms.form.showFormMsg($signInForm, data);\r\n                    }\r\n                }, ''json'');\r\n            },\r\n            postSignOut: function() {\r\n                $.post(''post.php'', {\r\n                    ''type'': ''signOut''\r\n                }, function(data) {\r\n                    if (data.status === ''success'') {\r\n                        window.location.href = ''sign.php'';\r\n                    } else {\r\n                        alert(data);\r\n                    }\r\n                }, ''json'');\r\n            }\r\n        },\r\n        getData: {\r\n            getCodeList: function(filter, fun) {\r\n                $.post(''post.php'', {\r\n                    ''type'': ''getCodeList'',\r\n                    ''filter'': filter\r\n                }, fun, ''json'');\r\n            },\r\n            getUserList: function(fun) {\r\n                $.post(''post.php'', {\r\n                    ''type'': ''getUserList''\r\n                }, fun, ''json'');\r\n            },\r\n            getLanguageList: function(fun) {\r\n                $.post(''post.php'', {\r\n                    ''type'': ''getLanguageList''\r\n                }, fun, ''json'');\r\n            },\r\n            getProjectList: function(fun) {\r\n                $.post(''post.php'', {\r\n                    ''type'': ''getProjectList''\r\n                }, fun, ''json'');\r\n            },\r\n            getCodePage: function(code_ID, fun) {\r\n                $.post(''post.php'', {\r\n                    ''type'': ''getCodePage'',\r\n                    ''code_ID'': code_ID\r\n                }, fun, ''json'');\r\n            }\r\n        },\r\n        init: {\r\n            initSearchForm: function($form) {\r\n                $form.find(''.select'').append(function() {\r\n                    return ''<label for="'' + $(this).children(''input'').attr(''id'') + ''"></label>'';\r\n                }).each(function() {\r\n                    var $this = $(this),\r\n                        $input = $this.children(''input''),\r\n                        option = ''<div class="option"><div class="none">'' + $input.attr(''placeholder'') + ''</div>'',\r\n                        appendToSelect = function(data) {\r\n                            for ( var i = 0; i < data.length; i++ ) {\r\n                                if ( data[i][1] != '''' ) {\r\n                                    option += ''<div data-id="'' + data[i][0] + ''">'' + data[i][1] + ''</div>''\r\n                                }\r\n                            }\r\n                            option += ''</div>'';\r\n                            $(option).width($input.width() + 16).click(function(event) {\r\n                                var $target = $(event.target);\r\n                                if ( $target.hasClass(''none'') ) {\r\n                                    $input.attr(''data-id'', '''').val('''').removeClass(''active'').nextAll(''.option'').hide();\r\n                                } else {\r\n                                    $input.attr(''data-id'', $target.attr(''data-id'')).val($target.html()).removeClass(''active'').nextAll(''.option'').fadeOut(100);\r\n                                }\r\n                            }).appendTo($this);\r\n                        };\r\n                    switch ($input.attr(''id'')) {\r\n                        case ''project'':\r\n                            $.cms.getData.getProjectList(appendToSelect);\r\n                        break;\r\n                        case ''language'':\r\n                            $.cms.getData.getLanguageList(appendToSelect);\r\n                        break;\r\n                        case ''author'':\r\n                            $.cms.getData.getUserList(appendToSelect);\r\n                        break;\r\n                    }\r\n                    $input.click(function() {\r\n                        if ( !$(this).hasClass(''active'') ) {\r\n                            $(''.active'').removeClass(''active'').nextAll(''.option'').fadeOut(100);\r\n                            $(this).addClass(''active'').nextAll(''.option'').slideDown(100);\r\n                        } else {\r\n                            $(this).removeClass(''active'').nextAll(''.option'').fadeOut(100);\r\n                        }\r\n                    });\r\n                });\r\n                $(''body'').click(function(event) {\r\n                    if ( !$(event.target).parents(''.select'').length ) {\r\n                        $(''.active'').removeClass(''active'').nextAll(''.option'').fadeOut(100);\r\n                    }\r\n                });\r\n                $form.find(''.inputText'').width($form.width() - 602);\r\n            },\r\n            initSignForm: function($form) {\r\n                $form.find(''input'').bind("keypress change", function() {\r\n                    $(this).next(''.formMsg'').html('''');\r\n                });\r\n            },\r\n            initMenu: function(data) {\r\n                var $menu = $(''.menu'');\r\n                    list = '''';\r\n                $menu.html();\r\n                for ( var i = 0; i < data.length; i++ ) {\r\n                    if ( data[i].code_ID == 1 ) {\r\n                        list = ''<li data-id="'' + data[i].code_ID + ''">'' + data[i].code_title + ''</li>'' + list;\r\n                    } else {\r\n                        list += ''<li data-id="'' + data[i].code_ID + ''">'' + data[i].code_title + ''</li>''\r\n                    }\r\n                };\r\n                list = ''<ul>'' + list + ''</ul>'';\r\n                $menu.append(list).delegate(''li'', ''click'', function() {\r\n                    var $this = $(this);\r\n                    $.cms.getData.getCodePage($this.attr(''data-id''), function(data) {\r\n                        $.cms.init.initMain(data);\r\n                        $menu.find(''li'').removeClass(''on'');\r\n                        $this.addClass(''on'');\r\n                    });\r\n                }).find(''li:first'').click();\r\n            },\r\n            initMain: function(data) {\r\n                if ( !$(''#jquerySnippetCss'').length ) {\r\n                    $("<link/>", {\r\n                        id: "jquerySnippetCss",\r\n                        rel: "stylesheet",\r\n                        type: "text/css",\r\n                        href: "css/jquery.snippet.min.css"\r\n                    }).appendTo("head");\r\n                }\r\n                if ( !$(''#jquerySnippetJs'').length ) {\r\n                    $.getScript(''js/jquery.snippet.min.js'', function() {\r\n                        $(''pre'').snippet(''javascript'', { style: ''vim'', menu: false });\r\n                    });\r\n                }\r\n                $(''.main'').html(''<pre>'' + data.code_source + ''</pre>'');\r\n            }\r\n        },\r\n        form: {\r\n            showFormMsg: function($form, data) {\r\n                for ( var i in data ) {\r\n                    $form.find(''#'' + i).select().next(''.formMsg'').html(data[i]);\r\n                }\r\n            },\r\n        }\r\n    };\r\n})(jQuery);', ''),
(23, 'Mysql', 1, 'php', '数据库封装语句', 'cms/class/class-mysql.php', '2013-03-16 04:44:32', '0000-00-00 00:00:00', 1, '<?php\n/**\n * 类名: Mysql\n * 功能: 数据库语句封装\n * 属性: $server, $user, $password, $database, $charset, $link\n * 方法: connet, query, fetcharray, fetchall, numrows, numfields, affectedrows, version, insertid, close, error\n * 说明: 数据库连接，查询等操作\n */\nclass Mysql {\n    private $server;    // 服务器名\n    private $user;      // 数据库用户名\n    private $password;  // 数据库密码\n    private $database;  // 数据库名\n    private $charset;   // 数据库编码,默认为utf8\n    private $link;      // mysql连接标识符\n    /**\n     * 方法: __construct\n     * 功能: 构造函数\n     * 参数: $server, $user, $password, $database, $charset\n     * 说明: 实例化时自动连接数据库\n     */\n    public function __construct($server, $user, $password, $database, $charset = ''utf8'') {\n        $this->server = $server;\n        $this->user = $user;\n        $this->password = $password;\n        $this->database = $database;\n        $this->charset = $charset;\n        $this->connect();\n    }\n    /**\n     * 方法: connect\n     * 功能: 连接数据库\n     * 参数: 无\n     * 说明: 连接mysql服务器,连接数据库,设置字符编码\n     */\n    private function connect() {\n        $this->link = mysql_connect($this->server, $this->user, $this->password) or die($this->error("数据库服务器连接出错!"));\n        mysql_select_db($this->database, $this->link) or die($this->error("数据库连接出错!"));\n        mysql_query("set names ''$this->charset''");\n    }\n    /**\n     * 方法: query\n     * 功能: 执行sql\n     * 参数: $sql\n     * 说明: 对传过来的sql语句执行,并返回结果$result资源标识符\n     */\n    public function query($sql) {\n        $result = mysql_query($sql, $this->link);\n        if ( !$result ) {\n            $this->error($sql . "语句执行失败!");\n            return false;\n        } else {\n            return $result;\n        }\n    }\n    /**\n     * 方法: fetcharray\n     * 功能: 从结果集中取一行做为数组\n     * 参数: $result资源标识符\n     * 说明: 需要提供sql语句执行返回的资源标识符\n     */\n    public function fetcharray($result) {\n        return mysql_fetch_array($result);\n    }\n    /**\n     * 方法: fetchall\n     * 功能: 从结果集中取出所有记录做为二维数组$arr\n     * 参数: $result资源标识符\n     * 说明: 循环取所有记录保存为$arr\n     */\n    public function fetchall($result) {\n        $arr = array ();\n        while ( $row = mysql_fetch_array($result) ) {\n            $arr[] = $row;\n        }\n        mysql_free_result($result);\n        return $arr;\n    }\n    /**\n     * 方法: numrows\n     * 功能: 统计结果集中记录数\n     * 参数: $result资源标识符\n     * 说明: 统计行数\n     */\n    public function numrows($result) {\n        return mysql_num_rows($result);\n    }\n    /**\n     * 方法: numfields\n     * 功能: 统计结果集中字段数\n     * 参数: $result资源标识符\n     * 说明: 统计字段数\n     */\n    public function numfields($result) {\n        return mysql_num_fields($result);\n    }\n    /**\n     * 方法: affectedrows\n     * 功能: 取得前一次mysql操作所影响的记录行数\n     * 参数: 无\n     * 说明: 取得前一次mysql操作所影响的记录行数\n     */\n    public function affectedrows() {\n        return mysql_affected_rows($this->link);\n    }\n    /**\n     * 方法: version\n     * 功能: 取得mysql版本\n     * 参数: 无\n     * 说明: 取得当前数据库服务器mysql的版本\n     */\n    public function version() {\n        return mysql_get_server_info();\n    }\n    /**\n     * 方法: insertid\n     * 功能: 取得上一步insert操作产生的id\n     * 参数: 无\n     * 说明: 取得上一步insert操作产生的自增字段id\n     */\n    public function insertid() {\n        return mysql_insert_id($this->link);\n    }\n    /**\n     * 方法: close\n     * 功能: 关闭连接\n     * 参数: 无\n     * 说明: 关闭非永久数据库连接\n     */\n    private function close() {\n        mysql_close($this->link);\n    }\n    /**\n     * 方法: error\n     * 功能: 提示错误\n     * 参数: $err_msg\n     * 说明: 对给出的错误提示内容给予echo\n     */\n    private function error($err_msg = "") {\n        if ( $err_msg == "" ) {\n            echo "errno: " . mysql_errno . "</br>";\n            echo "error: " . mysql_error . "</br>";\n        } else {\n            echo $err_msg;\n        }\n    }\n    /**\n     * 方法: __destruct\n     * 功能: 析构函数\n     * 参数: 无\n     * 说明: 释放类,关闭连接\n     */\n    public function __destruct() {\n        $this->close();\n    }\n}\n?>', '&lt;p&gt;&aring;&ordm;');

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
-- Table structure for table `cms_project`
--

CREATE TABLE IF NOT EXISTS `cms_project` (
  `project_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_title` varchar(50) NOT NULL,
  `project_description` text NOT NULL,
  PRIMARY KEY (`project_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `cms_project`
--

INSERT INTO `cms_project` (`project_ID`, `project_title`, `project_description`) VALUES
(1, 'cms', 'Code Management System');

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
