/**
 * jquery-cms.js
 **/
(function($) {
    $.cms = {
        sign: {
            postSignIn: function($signInForm) {
                var account = $signInForm.find('#account').val();
                    password = $signInForm.find('#password').val();
                $.post("post.php", {
                    'type': 'signIn',
                    'account': account,
                    'password': password
                }, function(data) {
                    if (data.status === 'success') {
                        window.location.href = 'index';
                    } else {
                        $.cms.form.showFormMsg($signInForm, data);
                    }
                }, 'json');
            },
            postSignOut: function() {
                $.post('post.php', {
                    'type': 'signOut'
                }, function(data) {
                    if (data.status === 'success') {
                        window.location.href = 'sign';
                    } else {
                        alert(data);
                    }
                }, 'json');
            }
        },
        getCodeList: function(filter, fun) {
            var out;
            $.post('post.php', {
                'type': 'getCodeList',
                'filter': filter
            }, fun, 'json');
        },
        form: {
            initForm: function($form) {
                $form.find('input').keypress(function() {
                    $(this).next('.formMsg').html('');
                });
            },
            showFormMsg: function($form, data) {
                for ( var i in data ) {
                    $form.find('#' + i).select().next('.formMsg').html(data[i]);
                }
            }
        }
    };
})(jQuery);
