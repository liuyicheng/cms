<?php
include_once("class/class-ajax.php");
include_once("class/class-connect.php");
include_once("class/class-keepin.php");
$postType = Ajax::getPost("type");
if ( $postType ) {
    $connect = new Connect();
    switch ( $postType ) {
        case "signIn":
            $account = Ajax::getPost("account");
            $password = Ajax::getPost("password");
            $vertifyMessage = $connect->vertifyAccount($account, $password);
            if ( $vertifyMessage > 0 ) {
                Keepin::start();
                Keepin::in($vertifyMessage);
                echo json_encode(array("status" => "success"));
            } else {
                echo $vertifyMessage;
            }
        break;
        case "signOut":
            Keepin::start();
            Keepin::end();
            echo json_encode(array("status" => "success"));
        break;
        case "getCodeList":
            $filter = Ajax::getPost("filter");
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
        case "getCodePage":
            $code_ID = Ajax::getPost("code_ID");
            echo $connect->getCodePage($code_ID);
        break;
    }
}
?>
