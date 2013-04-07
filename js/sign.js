$(function() {
    CMS.init.initSignForm($('#signInForm'));
    $('#signInForm').submit(function(event) {
        event.preventDefault();
        CMS.sign.postSignIn($('#signInForm'));
    });
    $('#signUp').click(function() {
        window.location.href='signup.php';
    });
});
