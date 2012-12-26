class Glue
  constructor: (@useCase, @gui, @storage) ->
    # auto binding XyzClicked from @gui to Xyz in @useCase
    AutoBind(@gui, @useCase)
    
    # logging stuff for adapters
    LogAll(@useCase, 'UseCase')
    LogAll(@gui, 'Gui')
    LogAll(@storage, 'Storage')

    # initiation & starting an application
    After(@useCase, 'start', @gui.start)
    After(@gui, 'signIn', (credentials) => @storage.signIn(credentials))
    After(@storage, 'signInResponse', (response) => @useCase.signIn(response))
    After(@useCase, 'signInError', @gui.signInError)
    After(@useCase, 'signOut', @gui.signOut)
    After(@useCase, 'loadContestList', => @gui.showContestList(@useCase.contest_list))
    After(@useCase, 'openContest', (id) => @storage.getContest(id))
    After(@storage, 'contestResponse', (contest) => @useCase.loadContest(contest))
    Before(@useCase, 'loadContest', (contest) => @gui.showContestArea(@useCase.user, contest))
    After(@useCase, 'contestWelcome', => @gui.showContestWelcome(@useCase.contest))
    After(@useCase, 'problem', (id) => @gui.showProblem(@useCase.getProblem(id), @useCase.user))
    After(@useCase, 'status', => @gui.showStatus([]))
    After(@useCase, 'ranking', => @gui.showRanking({}))
    After(@useCase, 'messages', => @gui.showMessages([]))
    After(@useCase, 'settings', => @gui.showSettingsForm({}))


    # codemirror stuff
    #After(@useCase, 'initCodeView', => @gui.initCodeView(@storage.getCode()))
    #After(@gui, 'codeChanged', (newText) => @useCase.codeChanged(newText))
    #After(@useCase, 'codeChanged', (newText) => @storage.setCode(newText))


