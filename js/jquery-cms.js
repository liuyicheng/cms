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
                        window.location.href = 'index.php';
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
                        window.location.href = 'sign.php';
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
                var asdf = $form.find('.select').append(function() {
                    return '<label for="' + $(this).children('input').attr('id') + '"></label>';
                }).append(function() {
                    var $input = $(this).children('input'),
                        option = '<div class="option"><div class="none">' + $input.attr('placeholder') + '</div>',
                        data = JSON.parse($input.attr('data'));
                    for ( var i = 0; i < data.length; i++ ) {
                        option += '<div data-id="' + data[i].id + '">' + data[i].name + '</div>'
                    }
                    option += '</div>';
                    return $(option).width($input.width() + 16).click(function(event) {
                        var $target = $(event.target);
                        if ( $target.hasClass('none') ) {
                            $input.attr('data-id', '').val('').removeClass('active').nextAll('.option').hide();
                        } else {
                            $input.attr('data-id', $target.attr('data-id')).val($target.html()).removeClass('active').nextAll('.option').fadeOut(100);
                        }
                    });
                }).children('input').click(function() {
                    if ( !$(this).hasClass('active') ) {
                        $('.active').removeClass('active').nextAll('.option').fadeOut(100);
                        $(this).addClass('active').nextAll('.option').slideDown(100);
                    } else {
                        $(this).removeClass('active').nextAll('.option').fadeOut(100);
                    }
                });
                $('body').click(function(event) {
                    if ( !$(event.target).parents('.select').length ) {
                        $('.active').removeClass('active').nextAll('.option').fadeOut(100);
                    }
                });
                $form.find('.inputText').width($form.width() - 602);
                $form.find('input').bind("keypress change", function() {
                    $(this).next('.formMsg').html('');
                });
            },
            showFormMsg: function($form, data) {
                for ( var i in data ) {
                    $form.find('#' + i).select().next('.formMsg').html(data[i]);
                }
            },

        }
    };
})(jQuery);
