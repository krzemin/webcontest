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
    After(@useCase, 'loadContestList', => @gui.showContestList(@storage.getContestList()))

    # codemirror stuff
    #After(@useCase, 'initCodeView', => @gui.initCodeView(@storage.getCode()))
    #After(@gui, 'codeChanged', (newText) => @useCase.codeChanged(newText))
    #After(@useCase, 'codeChanged', (newText) => @storage.setCode(newText))


