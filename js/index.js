$(function() {
    $.cms.form.initForm($('#searchForm'));
    $('#signOut').click(function(event) {
        event.preventDefault();
        $.cms.sign.postSignOut();
    });
    $.cms.getCodeList('default', function(data) {
        console.log(data);
    });
});
