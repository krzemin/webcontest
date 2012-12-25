class Gui
  
  constructor: ->
    @saveCodeEvery = 15
    @fadeInTimeout = 200

  # utils

  _render: (template, target, data) =>
    console.log('template = ' + template)
    template = Handlebars.templates[template]
    html = template(data)
    $(target).hide().html(html).fadeIn(200)

  _setLayout: (layout) =>
    @_render("layout-#{layout}.tmpl", 'body', {})


  # GUI actions
  
  start: =>
    @showSignInForm()

  # sign in

  showSignInForm: =>
    @_setLayout('center')
    @_render('sign-in.tmpl', '#main', {})
    $('#sign-in').click( => @signInFired())
    $('#email').enterKey( => @signInFired())
    $('#password').enterKey( => @signInFired())
  signInFired: =>
      credentials =
        email: $('#email').val()
        password: $('#password').val()
      @signIn(credentials)
  signIn: (credentials) =>
    $('#sign-in').off('click').addClass('disabled').text('Signing in...')
    $('#sign-in-error').hide('fast')
  signInError: =>
    $('#sign-in-error').show('fast')
    $('#sign-in').removeClass('disabled').text('Sign in').click( => @signInFired())

  # contest list

  showContestList: (contests) =>
    @_setLayout('center')
    console.log(contests)
    @_render('contest-list.tmpl', '#main', contests)
    $('.register-for-contest').click((obj) => @registerForContestClicked($(obj).attr('id')))
    $('.open-contest').click((obj) => @openContestClicked($(obj).attr('id')))
    $('#sign-out').click( => @signOutClicked() )

  registerForContestClicked: (id) =>
  
  openContestClicked: (id) =>
    $('.open-contest').off('click').addClass('disabled').text('Loading...')

  # contest area

  showContestArea: (user, contest) =>
    console.log(contest)
    @_setLayout('navbar')
    $('#contest-welcome').text(contest.name)
    $('#user-name').text(user.name)
    @_loadProblemsMenu(contest.problems)
    $('#contest-welcome').click( => @contestWelcomeClicked() )
    $('#status').click( => @statusClicked() )
    $('#ranking').click( => @rankingClicked() )
    $('#messages').click( => @messagesClicked() )
    $('#settings').click( => @settingsClicked() )
    $('#exit-contest-area').click( => @exitContestAreaClicked() )
    $('#sign-out').click( => @signOutClicked() )
    

  _loadProblemsMenu: (problems) =>
    problems.each (problem) =>
      link = $('<a>').attr('id', problem.id)
                     .text(problem.name)
                     .click((obj) => @problemClicked(problem.id))
      $('ul#problems-list').append($('<li>').append(link))
 
  _setActiveNavMenuItem: (view) =>
    $('ul#navigation li').removeClass('active')
    $("##{view}").parent().addClass('active') unless view == ''

  contestWelcomeClicked: =>
    @_setActiveNavMenuItem('')
  problemClicked: (id) =>
    @_setActiveNavMenuItem('problems')
  statusClicked: =>
    @_setActiveNavMenuItem('status')
  rankingClicked: =>
    @_setActiveNavMenuItem('ranking')
  messagesClicked: =>
    @_setActiveNavMenuItem('')
  settingsClicked: =>
    @_setActiveNavMenuItem('')
  exitContestAreaClicked: =>
  signOutClicked: =>

  showContestWelcome: (contest) =>
    @_render('welcome.tmpl', '#main', contest)
    @_showTimeline(contest.agenda)


  _showTimeline: (agenda) =>
    timeline_agenda = agenda.map (it) => {
      start: Date.create(it.start)
      content: """<span class="badge badge-info">#{it.content}</span>"""
    }
    dates = (timeline_agenda.map (it) => it.start)
    startDate = Date.create(dates.min())
    endDate = Date.create(dates.max())
    timeline_options = {
      start: startDate.rewind({hours: 1})
      end: endDate.rewind({hours: -2})
      width: '100%'
      style: 'dot'
      zoomable: false
      selectable: false
      moveable: false
      showMajorLabels: false
      showCurrentTime: true
    }
    timeline = new links.Timeline(document.getElementById('timeline'))
    timeline.draw(timeline_agenda, timeline_options)
    timeline.setCurrentTime(Date.create("2012-12-24 16:05:22"))
    $(window).on('resize', => timeline.redraw())

  showProblem: (problem) =>
    @_render('problem.tmpl', '#main', problem)
    @_resizeFixedHeightContainer()
    $('.fixed-height-container').layout({
      applyDefaultStyles: false
      livePaneResizing: true
      center__paneSelector: "#problem-description"
      east__paneSelector: "#coding-panel"
    })
    $(window).on('resize', => @_resizeFixedHeightContainer())
    #@_initCodeView('#include<dupa>')

  _resizeFixedHeightContainer: =>
    $(".fixed-height-container").height(window.innerHeight - $(".navbar").height() - 40)
    $(".drag_column").addClass('drag_column')

  _initCodeView: (codeText) =>
    opts = {
      mode: 'text/x-c++src',
      theme: 'monokai',
      lineNumbers: true,
      indentUnit: 4,
      extraKeys: {
        'F11': (cm) => @_setCodeViewFullScreen(cm, !@_isCodeViewFullScreen(cm))
        'Esc': (cm) => @_setCodeViewFullScreen(cm, false) if @_isCodeViewFullScreen(cm)
      }
    }
    codeWidget = document.getElementById('codemirror')
    @cm = CodeMirror.fromTextArea(codeWidget, opts)
    @cm.setValue(codeText)
    @cm.markClean()
    setTimeout(@_saveCodeCallback, @saveCodeEvery * 1000)
    # previously, saving the code was performed every editor's content change
    # CodeMirror.on(@cm, "change", (instance, chObj) => @codeChanged(instance.getValue()))

  _isCodeViewFullScreen: (cm) =>
    /\bCodeMirror-fullscreen\b/.test(cm.getWrapperElement().className)

  _setCodeViewFullScreen: (cm, full) =>
    wrap = cm.getWrapperElement()
    winHeight = window.innerHeight || (document.documentElement || document.body).clientHeight
    if full
      wrap.className += ' CodeMirror-fullscreen'
      wrap.style.height = winHeight + 'px'
      document.documentElement.style.overflow = 'hidden'
    else
      wrap.className = wrap.className.replace(" CodeMirror-fullscreen", "")
      wrap.style.height = ""
      document.documentElement.style.overflow = ""
    cm.refresh()

  _saveCodeCallback: =>
    @codeChanged(@cm.getValue()) unless @cm.isClean()
    @cm.markClean()
    setTimeout(@_saveCodeCallback, @saveCodeEvery * 1000)

  codeChanged: (newText) =>

  showStatus: (status) =>
    @_render('status.tmpl', '#main', status)
  showRanking: (ranking) =>
    @_render('ranking.tmpl', '#main', ranking)
  showMessages: (messages) =>
    @_render('messages.tmpl', '#main', messages)
  showSettingsForm: (settings) =>
    @_render('settings.tmpl', '#main', settings)
  signOut: =>
    @start()



