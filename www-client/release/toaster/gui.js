var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.signOut = __bind(this.signOut, this);

    this.showSettingsForm = __bind(this.showSettingsForm, this);

    this.showMessages = __bind(this.showMessages, this);

    this.showRanking = __bind(this.showRanking, this);

    this.showStatus = __bind(this.showStatus, this);

    this.codeChanged = __bind(this.codeChanged, this);

    this._saveCodeCallback = __bind(this._saveCodeCallback, this);

    this._initCodeView = __bind(this._initCodeView, this);

    this._resizeFixedHeightContainer = __bind(this._resizeFixedHeightContainer, this);

    this._initProblemPageLayout = __bind(this._initProblemPageLayout, this);

    this.showProblem = __bind(this.showProblem, this);

    this._initTimeline = __bind(this._initTimeline, this);

    this.showContestWelcome = __bind(this.showContestWelcome, this);

    this.signOutClicked = __bind(this.signOutClicked, this);

    this.exitContestAreaClicked = __bind(this.exitContestAreaClicked, this);

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
    this.fadeInTimeout = 200;
  }

  Gui.prototype._render = function(template, target, data) {
    var html;
    console.log('template = ' + template);
    template = Handlebars.templates[template];
    html = template(data);
    return $(target).hide().html(html).fadeIn(200);
  };

  Gui.prototype._setLayout = function(layout) {
    return this._render("layout-" + layout + ".tmpl", 'body', {});
  };

  Gui.prototype.start = function() {
    return this.showSignInForm();
  };

  Gui.prototype.showSignInForm = function() {
    var _this = this;
    this._setLayout('center');
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
    this._setLayout('center');
    console.log(contests);
    this._render('contest-list.tmpl', '#main', contests);
    $('.register-for-contest').click(function(obj) {
      return _this.registerForContestClicked($(obj).attr('id'));
    });
    $('.open-contest').click(function(obj) {
      return _this.openContestClicked($(obj).attr('id'));
    });
    return $('#sign-out').click(function() {
      return _this.signOutClicked();
    });
  };

  Gui.prototype.registerForContestClicked = function(id) {};

  Gui.prototype.openContestClicked = function(id) {
    return $('.open-contest').off('click').addClass('disabled').text('Loading...');
  };

  Gui.prototype.showContestArea = function(user, contest) {
    var _this = this;
    console.log(contest);
    this._setLayout('navbar');
    $('#contest-welcome').text(contest.name);
    $('#user-name').text(user.name);
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
    $('#exit-contest-area').click(function() {
      return _this.exitContestAreaClicked();
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
        return _this.problemClicked(problem.id);
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

  Gui.prototype.messagesClicked = function() {
    return this._setActiveNavMenuItem('');
  };

  Gui.prototype.settingsClicked = function() {
    return this._setActiveNavMenuItem('');
  };

  Gui.prototype.exitContestAreaClicked = function() {};

  Gui.prototype.signOutClicked = function() {};

  Gui.prototype.showContestWelcome = function(contest) {
    this._render('welcome.tmpl', '#main', contest);
    return this._initTimeline(contest.agenda);
  };

  Gui.prototype._initTimeline = function(agenda) {
    var dates, endDate, startDate, timeline, timeline_agenda, timeline_options,
      _this = this;
    timeline_agenda = agenda.map(function(it) {
      return {
        start: Date.create(it.start),
        content: "<span class=\"badge badge-info\">" + it.content + "</span>"
      };
    });
    dates = timeline_agenda.map(function(it) {
      return it.start;
    });
    startDate = Date.create(dates.min());
    endDate = Date.create(dates.max());
    timeline_options = {
      start: startDate.rewind({
        hours: 1
      }),
      end: endDate.rewind({
        hours: -2
      }),
      width: '100%',
      style: 'dot',
      zoomable: false,
      selectable: false,
      moveable: false,
      showMajorLabels: false,
      showCurrentTime: true
    };
    timeline = new links.Timeline(document.getElementById('timeline'));
    timeline.draw(timeline_agenda, timeline_options);
    timeline.setCurrentTime(Date.create("2012-12-24 16:05:22"));
    return $(window).on('resize', function() {
      return timeline.redraw();
    });
  };

  Gui.prototype.showProblem = function(problem) {
    var _this = this;
    this._render('problem.tmpl', '#main', problem);
    this._resizeFixedHeightContainer();
    this._initProblemPageLayout();
    $(window).on('resize', function() {
      return _this._resizeFixedHeightContainer();
    });
    return this._initCodeView('#include<dupa>');
  };

  Gui.prototype._initProblemPageLayout = function() {
    $('.fixed-height-container').layout({
      applyDefaultStyles: false,
      livePaneResizing: true,
      slidable: false,
      center__paneSelector: '#problem-description',
      east__paneSelector: '#coding-panel',
      east__size: 0.5,
      east__minSize: 320,
      east__maxSize: 0.8
    });
    return $('#tab-code').layout({
      applyDefaultStyles: false,
      livePaneResizing: true,
      slidable: false,
      center__paneSelector: '#code-editor-container',
      south__paneSelector: '#code-messages-container',
      south__size: 0.25,
      south__minSize: 0.1,
      south__maxSize: 0.9,
      south__initClosed: true
    });
  };

  Gui.prototype._resizeFixedHeightContainer = function() {
    $(".fixed-height-container").height(window.innerHeight - $(".navbar").height() - 40);
    return $(".tab-content").height($("#coding-panel").height() - $("#coding-panel .nav-tabs").height() - 1);
  };

  Gui.prototype._initCodeView = function(codeText) {
    var codeWidget, opts;
    opts = {
      mode: 'text/x-c++src',
      theme: 'monokai',
      lineNumbers: true,
      indentUnit: 4
    };
    codeWidget = document.getElementById('codemirror');
    this.cm = CodeMirror.fromTextArea(codeWidget, opts);
    this.cm.setValue(codeText);
    this.cm.markClean();
    return setTimeout(this._saveCodeCallback, this.saveCodeEvery * 1000);
  };

  Gui.prototype._saveCodeCallback = function() {
    if (!this.cm.isClean()) {
      this.codeChanged(this.cm.getValue());
    }
    this.cm.markClean();
    return setTimeout(this._saveCodeCallback, this.saveCodeEvery * 1000);
  };

  Gui.prototype.codeChanged = function(newText) {};

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

  return Gui;

})();
