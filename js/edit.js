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
});
