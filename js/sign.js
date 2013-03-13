$(function() {
    $.cms.form.initForm($('#signInForm'));
    $('#signInForm').submit(function(event) {
        event.preventDefault();
        $.cms.sign.postSignIn($('#signInForm'));
    });
});
