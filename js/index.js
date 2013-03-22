$(function() {
    $('#signOut').click(function(event) {
        event.preventDefault();
        CMS.sign.postSignOut();
    });
    $('#addNewCodeButton').click(function() {
        window.location.href='edit.php';
    });
    $('#searchForm').submit(function(event) {
        event.preventDefault();
        $('#searchInput').blur();
        CMS.filter.keywords = $('#searchInput').val();
        CMS.init.initMain();
    });
    CMS.init.initSearch();
    CMS.init.initSidebar();
    CMS.init.initMain();
});
