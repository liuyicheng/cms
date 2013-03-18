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
        getData: {
            getCodeList: function(filter, fun) {
                $.post('post.php', {
                    'type': 'getCodeList',
                    'filter': filter
                }, fun, 'json');
            },
            getUserList: function(fun) {
                $.post('post.php', {
                    'type': 'getUserList'
                }, fun, 'json');
            },
            getLanguageList: function(fun) {
                $.post('post.php', {
                    'type': 'getLanguageList'
                }, fun, 'json');
            },
            getProjectList: function(fun) {
                $.post('post.php', {
                    'type': 'getProjectList'
                }, fun, 'json');
            },
            getCodePage: function(code_ID, fun) {
                $.post('post.php', {
                    'type': 'getCodePage',
                    'code_ID': code_ID
                }, fun, 'json');
            }
        },
        setData: {
            addCodePage: function(addNewData) {
                $.post('post.php', {
                    type: 'addCodePage',
                    code_title: addNewData.title,
                    code_project: addNewData.project,
                    code_language: addNewData.language,
                    code_summary: addNewData.summary,
                    code_location: addNewData.location,
                    code_source: addNewData.source,
                    code_description: addNewData.description
                }, function(data) {
                    alert(data);
                });
            }
        },
        init: {
            initSearchForm: function($form) {
                $form.find('.select').append(function() {
                    return '<label for="' + $(this).children('input').attr('id') + '"></label>';
                }).each(function() {
                    var $this = $(this),
                        $input = $this.children('input'),
                        option = '<div class="option"><div class="none">' + $input.attr('placeholder') + '</div>',
                        appendToSelect = function(data) {
                            for ( var i = 0; i < data.length; i++ ) {
                                if ( data[i][1] != '' ) {
                                    option += '<div data-id="' + data[i][0] + '">' + data[i][1] + '</div>'
                                }
                            }
                            option += '</div>';
                            $(option).width($input.width() + 16).click(function(event) {
                                var $target = $(event.target);
                                if ( $target.hasClass('none') ) {
                                    $input.attr('data-id', '').val('').removeClass('active').nextAll('.option').hide();
                                } else {
                                    $input.attr('data-id', $target.attr('data-id')).val($target.html()).removeClass('active').nextAll('.option').fadeOut(100);
                                }
                            }).appendTo($this);
                        };
                    switch ($input.attr('id')) {
                        case 'project':
                            $.cms.getData.getProjectList(appendToSelect);
                        break;
                        case 'language':
                            $.cms.getData.getLanguageList(appendToSelect);
                        break;
                        case 'author':
                            $.cms.getData.getUserList(appendToSelect);
                        break;
                    }
                    $input.click(function() {
                        if ( !$(this).hasClass('active') ) {
                            $('.active').removeClass('active').nextAll('.option').fadeOut(100);
                            $(this).addClass('active').nextAll('.option').slideDown(100);
                        } else {
                            $(this).removeClass('active').nextAll('.option').fadeOut(100);
                        }
                    });
                });
                $('body').click(function(event) {
                    if ( !$(event.target).parents('.select').length ) {
                        $('.active').removeClass('active').nextAll('.option').fadeOut(100);
                    }
                });
                $form.find('.inputText').width($form.width() - 602);
            },
            initSignForm: function($form) {
                $form.find('input').bind("keypress change", function() {
                    $(this).next('.formMsg').html('');
                });
            },
            initMenu: function(data) {
                var $menu = $('.menu');
                    list = '';
                $menu.html();
                for ( var i = 0; i < data.length; i++ ) {
                    if ( data[i].code_ID == 1 ) {
                        list = '<li data-id="' + data[i].code_ID + '">' + data[i].code_title + '</li>' + list;
                    } else {
                        list += '<li data-id="' + data[i].code_ID + '">' + data[i].code_title + '</li>'
                    }
                };
                list = '<ul>' + list + '</ul>';
                $menu.append(list).delegate('li', 'click', function() {
                    var $this = $(this);
                    $.cms.getData.getCodePage($this.attr('data-id'), function(data) {
                        $.cms.init.initMain(data);
                        $menu.find('li').removeClass('on');
                        $this.addClass('on');
                    });
                }).find('li:first').click();
            },
            initMain: function(data) {
                if ( !$('#jquerySnippetCss').length ) {
                    $("<link/>", {
                        id: "jquerySnippetCss",
                        rel: "stylesheet",
                        type: "text/css",
                        href: "css/jquery.snippet.min.css"
                    }).appendTo("head");
                }
                if ( !$('#jquerySnippetJs').length ) {
                    $.getScript('js/jquery.snippet.min.js', function() {
                        $('pre').snippet('javascript', { style: 'vim', menu: false });
                    });
                }
                $('.main').html('<pre>' + data.code_source + '</pre>');
            }
        },
        form: {
            showFormMsg: function($form, data) {
                for ( var i in data ) {
                    $form.find('#' + i).select().next('.formMsg').html(data[i]);
                }
            },
        }
    };
})(jQuery);
