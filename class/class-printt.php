<?php
class Printt {
    public static function printTpl($tplName, $subArr) {
        include_once("tpl/" . $tplName);
    }
    public static function printTplHeader($name) {
        Printt::printTpl("header.html", array("title" => $name . " | cms", "cssName" => $name . ".css", "pgName" => "pg_" . $name ));
    }
}
?>
