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
            $label = isset($_POST["label"]) ? $_POST["label"] : "";
            $language = isset($_POST["language"]) ? $_POST["language"] : "";
            $project = isset($_POST["project"]) ? $_POST["project"] : "";
            $author = isset($_POST["author"]) ? $_POST["author"] : "";
            $keywords = isset($_POST["keywords"]) ? $_POST["keywords"] : "";
            echo $connect->getCodeList($label, $language, $project, $author, $keywords);
        break;
        case "getUserList":
            echo $connect->getUserList();
        break;
        case "getLabelList":
            echo $connect->getLabelList();
        break;
        case "getLanguageList":
            echo $connect->getLanguageList();
        break;
        case "getProjectList":
            echo $connect->getProjectList();
        break;
        case "getCodePage":
            $code_ID = isset($_POST["code_ID"]) ? $_POST["code_ID"] : "";
            echo $connect->getCodePage($code_ID);
            // TODO 显示代码页面还没做完
        break;
        case "getCodeLabel":
            $code_ID = isset($_POST["code_ID"]) ? $_POST["code_ID"] : "";
            echo $connect->getCodeLabel($code_ID);
        break;
        // TODO 如此多的相似代码，考虑是否可以合并，Do not repeat yourself!
        case "addCodePage":
            $code_title = isset($_POST["code_title"]) ? $_POST["code_title"] : "";
            $code_project = isset($_POST["code_project"]) ? $_POST["code_project"] : "";
            $code_language = isset($_POST["code_language"]) ? $_POST["code_language"] : "";
            $code_summary = isset($_POST["code_summary"]) ? $_POST["code_summary"] : "";
            $code_location = isset($_POST["code_location"]) ? $_POST["code_location"] : "";
            $code_source = isset($_POST["code_source"]) ? $_POST["code_source"] : "";
            $code_description = isset($_POST["code_description"]) ? $_POST["code_description"] : "";
            echo $connect->addCodePage($code_title, $code_project, $code_language, $code_summary, $code_location, $code_source, $code_description);
        break;
    }
}
?>
