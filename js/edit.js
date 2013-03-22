$(function() {
    $.getScript('ueditor/editor_config.js', function() {
        $.getScript('ueditor/editor_all.js', function() {
            var ue = UE.getEditor('editor');
            ue.addListener('ready',function(){
                this.focus()
            });
        });
    });
    /*$('button').click(function() {
        console.log(UE.getEditor('editor').getContent());
    });*/
    $('#returnIndex').click(function() {
        window.location.href = 'index.php';
    });
    $('#addNew').click(function() {
        event.preventDefault();
        var addNewData = {
            title: $('#title').val(),
            project: $('#project').val(),
            language: $('#language').val(),
            summary: $('#summary').val(),
            location: $('#location').val(),
            source: $('#source').val(),
            description: UE.getEditor('editor').getContent()
        }
        CMS.setData.addCodePage(addNewData);
    });
});
