class Gui
  
  constructor: ->
    @saveCodeEvery = 15

  # utils

  _render: (template, target, data) =>
    console.log('template = ' + template)
    template = Handlebars.templates[template]
    html = template(data)
    $(target).html(html)

  _setLayout: (layout) =>
    @_render("layout-#{layout}.tmpl", 'body', {})


  # GUI actions
  
  start: =>
    @_setLayout('center')
    @showSignInForm()

  # sign in
  
  showSignInForm: =>
    @_render('sign-in.tmpl', '#main', {})
    $('#sign-in').click( =>
        credentials =
            email: $('#email').val()
            password: $('#password').val()
        @signInClicked(credentials)
    )
  signInClicked: (credentials) =>
    $('#sign-in').off('click').addClass('disabled').text('Signing in...')
  
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
  problemListClicked: =>
  problemClicked: (id) =>
    @_setActiveNavMenuItem('problems')
  statusClicked: =>
    @_setActiveNavMenuItem('status')
  rankingClicked: =>
    @_setActiveNavMenuItem('ranking')
  settingsClicked: =>
  signOutClicked: =>

  showContestWelcome: (contest) =>
  showProblemList: (problems) =>
  showProblem: (problem) =>
  showStatus: (status) =>
  showRanking: (ranking) =>
  showSettingsForm: (settings) =>
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



