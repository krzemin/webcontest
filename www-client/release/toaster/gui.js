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

    this.showRanking = __bind(this.showRanking, this);

    this.showStatus = __bind(this.showStatus, this);

    this.showProblem = __bind(this.showProblem, this);

    this.showProblemList = __bind(this.showProblemList, this);

    this.showContestWelcome = __bind(this.showContestWelcome, this);

    this.signOutClicked = __bind(this.signOutClicked, this);

    this.settingsClicked = __bind(this.settingsClicked, this);

    this.rankingClicked = __bind(this.rankingClicked, this);

    this.statusClicked = __bind(this.statusClicked, this);

    this.problemClicked = __bind(this.problemClicked, this);

    this.problemListClicked = __bind(this.problemListClicked, this);

    this.contestWelcomeClicked = __bind(this.contestWelcomeClicked, this);

    this._setActiveNavMenuItem = __bind(this._setActiveNavMenuItem, this);

    this._loadProblemsMenu = __bind(this._loadProblemsMenu, this);

    this.showContestArea = __bind(this.showContestArea, this);

    this.openContestClicked = __bind(this.openContestClicked, this);

    this.registerForContestClicked = __bind(this.registerForContestClicked, this);

    this.showContestList = __bind(this.showContestList, this);

    this.signInClicked = __bind(this.signInClicked, this);

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
    return $('#sign-in').click(function() {
      var credentials;
      credentials = {
        email: $('#email').val(),
        password: $('#password').val()
      };
      return _this.signInClicked(credentials);
    });
  };

  Gui.prototype.signInClicked = function(credentials) {
    return $('#sign-in').off('click').addClass('disabled').text('Signing in...');
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

  Gui.prototype.problemListClicked = function() {};

  Gui.prototype.problemClicked = function(id) {
    return this._setActiveNavMenuItem('problems');
  };

  Gui.prototype.statusClicked = function() {
    return this._setActiveNavMenuItem('status');
  };

  Gui.prototype.rankingClicked = function() {
    return this._setActiveNavMenuItem('ranking');
  };

  Gui.prototype.settingsClicked = function() {};

  Gui.prototype.signOutClicked = function() {};

  Gui.prototype.showContestWelcome = function(contest) {};

  Gui.prototype.showProblemList = function(problems) {};

  Gui.prototype.showProblem = function(problem) {};

  Gui.prototype.showStatus = function(status) {};

  Gui.prototype.showRanking = function(ranking) {};

  Gui.prototype.showSettingsForm = function(settings) {};

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
