class Gui
  
  constructor: ->
    @saveCodeEvery = 15

  # utils

  _render: (template, target, data) =>
    console.log('template = ' + template)
    template = Handlebars.templates[template]
    html = template(data)
    $(target).hide().html(html).fadeIn(500)

  _setLayout: (layout) =>
    @_render("layout-#{layout}.tmpl", 'body', {})


  # GUI actions
  
  start: =>
    @_setLayout('center')
    @showSignInForm()

  # sign in

  showSignInForm: =>
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
    console.log(contests)
    @_render('contest-list.tmpl', '#main', contests)
    $('.register-for-contest').click((obj) => @registerForContestClicked(obj.toElement.id))
    $('.open-contest').click((obj) => @openContestClicked(obj.toElement.id))

  registerForContestClicked: (id) =>
  
  openContestClicked: (id) =>

  # contest area

  showContestArea: (contest) =>
    console.log(contest)
    @_setLayout('navbar')
    $('#contest-welcome').text(contest.name)
    @_loadProblemsMenu(contest.problems)
    $('#contest-welcome').click( => @contestWelcomeClicked() )
    $('#status').click( => @statusClicked() )
    $('#ranking').click( => @rankingClicked() )
    $('#messages').click( => @messagesClicked() )
    $('#settings').click( => @settingsClicked() )
    $('#sign-out').click( => @signOutClicked() )
    

  _loadProblemsMenu: (problems) =>
    problems.each (problem) =>
      link = $('<a>').attr('id', problem.id)
                     .text(problem.name)
                     .click((obj) => @problemClicked(obj.toElement.id))
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
  settingsClicked: =>
  signOutClicked: =>

  showContestWelcome: (contest) =>
    @_render('welcome.tmpl', '#main', contest)
    data = [
        { start: new Date(2012,12,24,13,0,0), content: 'Registration end' }
        { start: new Date(2012,12,24,13,10,0), content: 'Trial round start' }
        { start: new Date(2012,12,24,14,0,0), content: 'Trial round end' }
        { start: new Date(2012,12,24,14,15,0), content: 'Main round start' }
        { start: new Date(2012,12,24,18,0,0), content: 'Main round end' }
        { start: new Date(2012,12,24,17,30,0), content: 'Ranking freeze' }
        { start: new Date(2012,12,24,18,30,0), content: 'Results publish' }
    ]
    data = data.map (a) => { start: a.start, content: """<span class="label label-success">#{a.content}</span>""" }

    options = {
      start: new Date(2012,12,24,11,30,0)
      end: new Date(2012,12,24,20,0,0)
      width: '100%'
      style: 'dot'
      zoomable: false
      selectable: false
      moveable: false
      showMajorLabels: false
      showCurrentTime: true
    }
    timeline = new links.Timeline(document.getElementById('timeline'))
    timeline.draw(data, options)
    timeline.setCurrentTime(new Date(2012,12,24,16,5,22))
    $(window).on('resize', => timeline.redraw())

  showProblem: (problem) =>
    @_render('problem.tmpl', '#main', problem)
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

  initCodeView: (codeText) =>
    opts = {
      mode: 'text/x-c++src',
      theme: 'monokai',
      lineNumbers: true,
      indentUnit: 4,
      extraKeys: {
        'F11': (cm) => @setCodeViewFullScreen(cm, !@isCodeViewFullScreen(cm))
        'Esc': (cm) => @setCodeViewFullScreen(cm, false) if @isCodeViewFullScreen(cm)
      }
    }
    codeWidget = document.getElementById('code')
    @cm = CodeMirror.fromTextArea(codeWidget, opts)
    @cm.setValue(codeText)
    @cm.markClean()
    setTimeout(@saveCodeCallback, @saveCodeEvery * 1000)
    # previously, saving the code was performed every editor's content change
    # CodeMirror.on(@cm, "change", (instance, chObj) => @codeChanged(instance.getValue()))

  isCodeViewFullScreen: (cm) =>
    /\bCodeMirror-fullscreen\b/.test(cm.getWrapperElement().className)

  setCodeViewFullScreen: (cm, full) =>
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

  saveCodeCallback: =>
    @codeChanged(@cm.getValue()) unless @cm.isClean()
    @cm.markClean()
    setTimeout(@saveCodeCallback, @saveCodeEvery * 1000)

  codeChanged: (newText) =>



