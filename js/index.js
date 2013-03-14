$(function() {
    $.cms.init.initSearchForm($('#searchForm'));
    $('#signOut').click(function(event) {
        event.preventDefault();
        $.cms.sign.postSignOut();
    });
    $.cms.getData.getCodeList('default', function(data) {
        $.cms.init.initMenu(data);
    });
});
