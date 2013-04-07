$(function() {
    CMS.init.initSignForm($('#signUpForm'));
    $('#signUpForm').submit(function(event) {
        event.preventDefault();
        CMS.sign.postSignUp($('#signUpForm'));
    });
    $('#returnIndex').click(function() {
        window.location.href='sign.php';
    });
});
