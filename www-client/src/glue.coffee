class Glue
  constructor: (@useCase, @gui, @storage)->
    AutoBind(@gui, @useCase)
    
    LogAll(@useCase, 'UseCase')
    LogAll(@gui, 'Gui')
    LogAll(@storage, 'Storage')

    After(@useCase, 'start', @gui.start)
    After(@useCase, 'start', => @useCase.loadCode(@storage.getCode()))
    After(@useCase, 'codeChanged', (newText) => @storage.setCode(newText))
    After(@gui, 'codeChanged', (newText) => @useCase.codeChanged(newText))
    After(@useCase, 'loadCode', (codeText) => @gui.loadCode(codeText))


