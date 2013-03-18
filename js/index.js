$(function() {
    $.cms.init.initSearchForm($('#searchForm'));
    $('#signOut').click(function(event) {
        event.preventDefault();
        $.cms.sign.postSignOut();
    });
    $('#addNewCodeButton').click(function() {
        window.location.href='edit.php';
    });
    $.cms.getData.getCodeList('default', function(data) {
        $.cms.init.initMenu(data);
    });
});
