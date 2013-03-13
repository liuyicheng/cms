<?php
include_once("class/class-ajax.php");
include_once("class/class-connect.php");
include_once("class/class-keepin.php");
$postType = Ajax::getPost("type");
if ( $postType ) {
    switch ( $postType ) {
        case "signIn":
            $account = Ajax::getPost("account");
            $password = Ajax::getPost("password");
            $connect = new Connect();
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
            $connect = new Connect();
            $codeList = $connect->getCodeList($filter);
            echo $codeList;
    }
}
?>
