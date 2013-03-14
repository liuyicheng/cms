$(function() {
    $.cms.init.initSignForm($('#signInForm'));
    $('#signInForm').submit(function(event) {
        event.preventDefault();
        $.cms.sign.postSignIn($('#signInForm'));
    });
});
