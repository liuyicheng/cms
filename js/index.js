$(function() {
    $('#signOut').click(function(event) {
        event.preventDefault();
        $.cms.sign.postSignOut();
    });
    $.cms.getCodeList('default', function(data) {
        alert(data);
    });
});
