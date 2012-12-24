var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.saveCodeCallback = __bind(this.saveCodeCallback, this);

    this.setCodeViewFullScreen = __bind(this.setCodeViewFullScreen, this);

    this.isCodeViewFullScreen = __bind(this.isCodeViewFullScreen, this);

    this.initCodeView = __bind(this.initCodeView, this);

    this.signOut = __bind(this.signOut, this);

    this.showSettingsForm = __bind(this.showSettingsForm, this);

    this.showMessages = __bind(this.showMessages, this);

    this.showRanking = __bind(this.showRanking, this);

    this.showStatus = __bind(this.showStatus, this);

    this.showProblem = __bind(this.showProblem, this);

    this.showContestWelcome = __bind(this.showContestWelcome, this);

    this.signOutClicked = __bind(this.signOutClicked, this);

    this.settingsClicked = __bind(this.settingsClicked, this);

    this.messagesClicked = __bind(this.messagesClicked, this);

    this.rankingClicked = __bind(this.rankingClicked, this);

    this.statusClicked = __bind(this.statusClicked, this);

    this.problemClicked = __bind(this.problemClicked, this);

    this.contestWelcomeClicked = __bind(this.contestWelcomeClicked, this);

    this._setActiveNavMenuItem = __bind(this._setActiveNavMenuItem, this);

    this._loadProblemsMenu = __bind(this._loadProblemsMenu, this);

    this.showContestArea = __bind(this.showContestArea, this);

    this.openContestClicked = __bind(this.openContestClicked, this);

    this.registerForContestClicked = __bind(this.registerForContestClicked, this);

    this.showContestList = __bind(this.showContestList, this);

    this.signInError = __bind(this.signInError, this);

    this.signIn = __bind(this.signIn, this);

    this.signInFired = __bind(this.signInFired, this);

    this.showSignInForm = __bind(this.showSignInForm, this);

    this.start = __bind(this.start, this);

    this._setLayout = __bind(this._setLayout, this);

    this._render = __bind(this._render, this);
    this.saveCodeEvery = 15;
  }

  Gui.prototype._render = function(template, target, data) {
    var html;
    console.log('template = ' + template);
    template = Handlebars.templates[template];
    html = template(data);
    return $(target).html(html);
  };

  Gui.prototype._setLayout = function(layout) {
    return this._render("layout-" + layout + ".tmpl", 'body', {});
  };

  Gui.prototype.start = function() {
    this._setLayout('center');
    return this.showSignInForm();
  };

  Gui.prototype.showSignInForm = function() {
    var _this = this;
    this._render('sign-in.tmpl', '#main', {});
    $('#sign-in').click(function() {
      return _this.signInFired();
    });
    $('#email').enterKey(function() {
      return _this.signInFired();
    });
    return $('#password').enterKey(function() {
      return _this.signInFired();
    });
  };

  Gui.prototype.signInFired = function() {
    var credentials;
    credentials = {
      email: $('#email').val(),
      password: $('#password').val()
    };
    return this.signIn(credentials);
  };

  Gui.prototype.signIn = function(credentials) {
    $('#sign-in').off('click').addClass('disabled').text('Signing in...');
    return $('#sign-in-error').hide('fast');
  };

  Gui.prototype.signInError = function() {
    var _this = this;
    $('#sign-in-error').show('fast');
    return $('#sign-in').removeClass('disabled').text('Sign in').click(function() {
      return _this.signInFired();
    });
  };

  Gui.prototype.showContestList = function(contests) {
    var _this = this;
    console.log(contests);
    this._render('contest-list.tmpl', '#main', contests);
    $('.register-for-contest').click(function(obj) {
      return _this.registerForContestClicked(obj.toElement.id);
    });
    return $('.open-contest').click(function(obj) {
      return _this.openContestClicked(obj.toElement.id);
    });
  };

  Gui.prototype.registerForContestClicked = function(id) {};

  Gui.prototype.openContestClicked = function(id) {};

  Gui.prototype.showContestArea = function(contest) {
    var _this = this;
    console.log(contest);
    this._setLayout('navbar');
    $('#contest-welcome').text(contest.name);
    this._loadProblemsMenu(contest.problems);
    $('#contest-welcome').click(function() {
      return _this.contestWelcomeClicked();
    });
    $('#status').click(function() {
      return _this.statusClicked();
    });
    $('#ranking').click(function() {
      return _this.rankingClicked();
    });
    $('#messages').click(function() {
      return _this.messagesClicked();
    });
    $('#settings').click(function() {
      return _this.settingsClicked();
    });
    return $('#sign-out').click(function() {
      return _this.signOutClicked();
    });
  };

  Gui.prototype._loadProblemsMenu = function(problems) {
    var _this = this;
    return problems.each(function(problem) {
      var link;
      link = $('<a>').attr('id', problem.id).text(problem.name).click(function(obj) {
        return _this.problemClicked(obj.toElement.id);
      });
      return $('ul#problems-list').append($('<li>').append(link));
    });
  };

  Gui.prototype._setActiveNavMenuItem = function(view) {
    $('ul#navigation li').removeClass('active');
    if (view !== '') {
      return $("#" + view).parent().addClass('active');
    }
  };

  Gui.prototype.contestWelcomeClicked = function() {
    return this._setActiveNavMenuItem('');
  };

  Gui.prototype.problemClicked = function(id) {
    return this._setActiveNavMenuItem('problems');
  };

  Gui.prototype.statusClicked = function() {
    return this._setActiveNavMenuItem('status');
  };

  Gui.prototype.rankingClicked = function() {
    return this._setActiveNavMenuItem('ranking');
  };

  Gui.prototype.messagesClicked = function() {};

  Gui.prototype.settingsClicked = function() {};

  Gui.prototype.signOutClicked = function() {};

  Gui.prototype.showContestWelcome = function(contest) {
    var data, options, timeline,
      _this = this;
    this._render('welcome.tmpl', '#main', contest);
    data = [
      {
        start: new Date(2012, 12, 24, 13, 0, 0),
        content: 'Registration end'
      }, {
        start: new Date(2012, 12, 24, 13, 10, 0),
        content: 'Trial round start'
      }, {
        start: new Date(2012, 12, 24, 14, 0, 0),
        content: 'Trial round end'
      }, {
        start: new Date(2012, 12, 24, 14, 15, 0),
        content: 'Main round start'
      }, {
        start: new Date(2012, 12, 24, 18, 0, 0),
        content: 'Main round end'
      }, {
        start: new Date(2012, 12, 24, 17, 30, 0),
        content: 'Ranking freeze'
      }, {
        start: new Date(2012, 12, 24, 18, 30, 0),
        content: 'Results publish'
      }
    ];
    data = data.map(function(a) {
      return {
        start: a.start,
        content: "<span class=\"label label-success\">" + a.content + "</span>"
      };
    });
    options = {
      start: new Date(2012, 12, 24, 11, 30, 0),
      end: new Date(2012, 12, 24, 20, 0, 0),
      width: '100%',
      style: 'dot',
      zoomable: false,
      selectable: false,
      moveable: false,
      showMajorLabels: false,
      showCurrentTime: true
    };
    timeline = new links.Timeline(document.getElementById('timeline'));
    timeline.draw(data, options);
    timeline.setCurrentTime(new Date(2012, 12, 24, 16, 5, 22));
    return $(window).on('resize', function() {
      return timeline.redraw();
    });
  };

  Gui.prototype.showProblem = function(problem) {
    return this._render('problem.tmpl', '#main', problem);
  };

  Gui.prototype.showStatus = function(status) {
    return this._render('status.tmpl', '#main', status);
  };

  Gui.prototype.showRanking = function(ranking) {
    return this._render('ranking.tmpl', '#main', ranking);
  };

  Gui.prototype.showMessages = function(messages) {
    return this._render('messages.tmpl', '#main', messages);
  };

  Gui.prototype.showSettingsForm = function(settings) {
    return this._render('settings.tmpl', '#main', settings);
  };

  Gui.prototype.signOut = function() {
    return this.start();
  };

  Gui.prototype.initCodeView = function(codeText) {
    var codeWidget, opts,
      _this = this;
    opts = {
      mode: 'text/x-c++src',
      theme: 'monokai',
      lineNumbers: true,
      indentUnit: 4,
      extraKeys: {
        'F11': function(cm) {
          return _this.setCodeViewFullScreen(cm, !_this.isCodeViewFullScreen(cm));
        },
        'Esc': function(cm) {
          if (_this.isCodeViewFullScreen(cm)) {
            return _this.setCodeViewFullScreen(cm, false);
          }
        }
      }
    };
    codeWidget = document.getElementById('code');
    this.cm = CodeMirror.fromTextArea(codeWidget, opts);
    this.cm.setValue(codeText);
    this.cm.markClean();
    return setTimeout(this.saveCodeCallback, this.saveCodeEvery * 1000);
  };

  Gui.prototype.isCodeViewFullScreen = function(cm) {
    return /\bCodeMirror-fullscreen\b/.test(cm.getWrapperElement().className);
  };

  Gui.prototype.setCodeViewFullScreen = function(cm, full) {
    var winHeight, wrap;
    wrap = cm.getWrapperElement();
    winHeight = window.innerHeight || (document.documentElement || document.body).clientHeight;
    if (full) {
      wrap.className += ' CodeMirror-fullscreen';
      wrap.style.height = winHeight + 'px';
      document.documentElement.style.overflow = 'hidden';
    } else {
      wrap.className = wrap.className.replace(" CodeMirror-fullscreen", "");
      wrap.style.height = "";
      document.documentElement.style.overflow = "";
    }
    return cm.refresh();
  };

  Gui.prototype.saveCodeCallback = function() {
    if (!this.cm.isClean()) {
      this.codeChanged(this.cm.getValue());
    }
    this.cm.markClean();
    return setTimeout(this.saveCodeCallback, this.saveCodeEvery * 1000);
  };

  Gui.prototype.codeChanged = function(newText) {};

  return Gui;

})();
