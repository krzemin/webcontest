class Glue
  constructor: (@useCase, @gui, @storage) ->
    # auto binding xClicked from @gui to x in @useCase
    AutoBind(@gui, @useCase)
    
    # logging stuff for adapters
    LogAll(@useCase, 'UseCase')
    LogAll(@gui, 'Gui')
    LogAll(@storage, 'Storage')

    # initiation & starting an application
    After(@useCase, 'start', @gui.start)
    After(@useCase, 'initCodeView', => @gui.initCodeView(@storage.getCode()))
    
    # code text change handling & saving to local storage
    After(@gui, 'codeChanged', (newText) => @useCase.codeChanged(newText))
    After(@useCase, 'codeChanged', (newText) => @storage.setCode(newText))


