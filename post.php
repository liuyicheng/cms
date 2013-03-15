<?php
/**
 * 处理所有ajax中的post请求，通过type字段来区分是哪种请求
 */
include_once("class/class-connect.php");
include_once("class/class-keepin.php");
if ( isset($_POST["type"]) ) {
    $postType = $_POST["type"];
    $connect = new Connect();
    switch ( $postType ) {
        case "signIn":
            $account = isset($_POST["account"]) ? $_POST["account"] : "";
            $password = isset($_POST["password"]) ? $_POST["password"] : "";
            $vertifyMessage = $connect->vertifyAccount($account, $password);
            if ( $vertifyMessage > 0 ) {
            // TODO 这里检测很不规范，$vertifyMessage要么是user_ID数值（大于0），要么是错误信息
            //      考虑是否有更好的检测方法
                Keepin::start();
                Keepin::in($vertifyMessage);
                echo json_encode(array("status" => "success"));
            } else {
                echo $vertifyMessage;
            }
        break;
        case "signOut":
            Keepin::start();
            // TODO 这里直接end的话，会说之前没有session_start()，还不清楚原因
            Keepin::end();
            echo json_encode(array("status" => "success"));
        break;
        case "getCodeList":
            $filter = isset($_POST["filter"]) ? $_POST["filter"] : "";
            echo $connect->getCodeList($filter);
        break;
        case "getUserList":
            echo $connect->getUserList();
        break;
        case "getLanguageList":
            echo $connect->getLanguageList();
        break;
        case "getProjectList":
            echo $connect->getProjectList();
        break;
        // TODO 如此多的相似代码，考虑是否可以合并，Do not repeat yourself!
        case "getCodePage":
            $code_ID = isset($_POST["code_ID"]) ? $_POST["code_ID"] : "";
            echo $connect->getCodePage($code_ID);
            // TODO 显示代码页面还没做完
        break;
    }
}
?>
