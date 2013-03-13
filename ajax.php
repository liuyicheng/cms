<?php
if (isset($_POST["type"])) {
    switch($_POST["type"]) {
        case "vertifyAccount":
            if (isset($_POST["account"]) && isset($_POST["password"])) {
                $account = $_POST["account"];
                $password = $_POST["password"];
                include_once("_connect.php");
                $connect = new Connect();
                $connect->vertifyAccount($account, $password);
            } else {
                die("请输入用户名密码");
            }
    }
}
?>
