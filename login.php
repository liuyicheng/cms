<?php
include_once("init.php");
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>login | cms</title>
</head>
<body>
<form action="ajax.php" method="post">
    <input id="account" name="account" type="text" />
    <input id="password" name="password" type="password" />
    <input id="submit" type="submit" value="确定" />
</form>
<script src="jquery-1.8.3.min.js"></script>
<script>
$(function() {
    $('#submit').click(function(event) {
        event.preventDefault();
        $.post("ajax.php", {
            'type': 'vertifyAccount',
            'account': $('#account').val(),
            'password': $('#password').val()
        }, function(data) {
            alert(data);
        });
    });
});
</script>
</body>
</html>
