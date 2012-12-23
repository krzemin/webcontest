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
    After(@useCase, 'loadContestList', => @gui.showContestList(@storage.getContestList()))
    Before(@useCase, 'openContest', (id) => @gui.showContestArea(@storage.getContest(id)))
    After(@useCase, 'contestWelcome', => @gui.showContestWelcome({}))
    After(@useCase, 'problem', => @gui.showProblem({}))
    After(@useCase, 'status', => @gui.showStatus([]))
    After(@useCase, 'ranking', => @gui.showRanking({}))
    After(@useCase, 'messages', => @gui.showMessages([]))
    After(@useCase, 'settings', => @gui.showSettingsForm({}))


    # codemirror stuff
    #After(@useCase, 'initCodeView', => @gui.initCodeView(@storage.getCode()))
    #After(@gui, 'codeChanged', (newText) => @useCase.codeChanged(newText))
    #After(@useCase, 'codeChanged', (newText) => @storage.setCode(newText))


