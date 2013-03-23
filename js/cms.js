/**
 * cms.js
 **/
CMS = {
    filter: {
        'language': '',
        'project': '',
        'author': '',
        'keywords': ''
    },
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
                    CMS.form.showFormMsg($signInForm, data);
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
                'language': filter.language,
                'project': filter.project,
                'author': filter.author,
                'keywords': filter.keywords
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
        initSignForm: function($form) {
            $form.find('input').bind("keypress change", function() {
                $(this).next('.formMsg').html('');
            });
        },
        initSearch: function() {
            $('#searchInput').width($('.center').width() - 334);
        },
        initSidebar: function() {
            var languageList,
                projectList,
                userList,
                sidebarContent;
            CMS.getData.getLanguageList(function(data) {
                languageList = data;
                CMS.getData.getProjectList(function(data) {
                    projectList = data;
                    CMS.getData.getUserList(function(data) {
                        userList = data;
                        sidebarContent = '<div class="filterRow languageList"><h2>开发语言</h2><span class="on" data="">不限</span>';
                        for ( var i = 0; i < languageList.length; i++ ) {
                            sidebarContent += '<span data="' + languageList[i].code_language + '">' + languageList[i].code_language + '</span>';
                        }
                        sidebarContent += '</div><div class="filterRow projectList"><h2>所属项目</h2><span class="on" data="">不限</span>';
                        for ( var i = 0; i < projectList.length; i++ ) {
                            sidebarContent += '<span data="' + projectList[i].code_project + '">' + projectList[i].code_project + '</span>';
                        }
                        sidebarContent += '</div><div class="filterRow userList"><h2>上传作者</h2><span class="on" data="">不限</span>';
                        for ( var i = 0; i < userList.length; i++ ) {
                            sidebarContent += '<span data="' + userList[i].code_author + '">' + userList[i].code_author + '</span>';
                        }
                        sidebarContent += '</div>';
                        $(sidebarContent).appendTo($('.sidebar'));
                        $('.languageList span').click(function() {
                            $('.languageList span').removeClass('on');
                            $(this).addClass('on');
                            CMS.filter.language = $(this).attr('data');
                            CMS.init.initMain();
                        });
                        $('.projectList span').click(function() {
                            $('.projectList span').removeClass('on');
                            $(this).addClass('on');
                            CMS.filter.project = $(this).attr('data');
                            CMS.init.initMain();
                        });
                        $('.userList span').click(function() {
                            $('.userList span').removeClass('on');
                            $(this).addClass('on');
                            CMS.filter.author = $(this).attr('data');
                            CMS.init.initMain();
                        });
                    });
                });
            });
        },
        initMain: function() {
            $('.main').html('');
            CMS.getData.getCodeList(CMS.filter, function(data) {
                var codeList,
                    codePage;
                for ( var i = 0; i < data.length; i++ ) {
                    codeList = '<div class="codeList"><i class="stars"></i><h3>' + data[i].code_title + '</h3><h4>' + data[i].code_summary + '</h4><p>' + data[i].code_description.substr(0, 70).replace(/<[^>]*>/g, ' ') + '<span class="googleYellow">' + data[i].code_description.substr(0, 10).replace(/<[^>]*>/g, ' ') + '</span>' + data[i].code_description.substr(70, 70).replace(/<[^>]*>/g, ' ') + '...</p></div>';
                    (function(i) {
                        $(codeList).click(function() {
                            codePage = '<div class="codePage"><i class="close">X</i>' + data[i].code_description + '<div class="comment"><ol><li><h5>流浪小猫：</h5><p>这个真好用呀。这个真好用呀。这个真好用呀。这个真好用呀。</p><span class="time">2013-3-19 12:12:04</span></li><li><h5>流浪小猫：</h5><p>这个真好用呀。这个真好用呀。这个真好用呀。这个真好用呀。</p><span class="time">2013-3-19 12:12:04</span></li></ol></div></div>';
                            $('.codePage').remove();
                            $(codePage).appendTo($('.main'));
                            $('.codePage').width($('.codeList').width() - 200);
                            $('.codePage .close').click(function() {
                                $(this).parents('.codePage').remove();
                                $('.codeList').removeClass('on');
                            });
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
                                    $('.center').height(Math.max($('.main').height(), ($('.codePage').height() + 170)));
                                });
                            }
                            $('.codeList').removeClass('on');
                            $(this).addClass('on');
                        }).appendTo($('.main'));
                    })(i);
                }
            });
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
