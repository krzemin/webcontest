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
    After(@useCase, 'loadAll', @storage.loadAllRequest)
    After(@useCase, 'loadAllResponse', (data) => @useCase.data = data; @gui.loadAll(data))
    # saving code to a remote storage
    After(@gui, 'saveCode', (code) => @useCase.saveCode(code))
    After(@useCase, 'saveCode', (code) => @storage.saveCodeRequest(code))
    #After(@storage, 'saveCodeResponse', (result) => ... )
    # compile code
    After(@gui, 'compileCode', (code) => @useCase.compileCode(code))
    After(@useCase, 'compileCode', (code) => @storage.compileCodeRequest(code))
    After(@storage, 'compileCodeResponse', (result) => @useCase.codeCompilationStarted() if result)
    After(@useCase, 'codeCompilationStarted', @gui.codeCompilationStarted)
    After(@storage, 'compileCodeIndication', (result) => @useCase.codeCompilationFinished(result))
    After(@useCase, 'codeCompilationFinished', @gui.codeCompilationFinished)
    # submit code
    After(@gui, 'submitCode', (code) => @useCase.submitCode(code))
    After(@useCase, 'submitCode', (code) => @storage.submitCodeRequest(code))
    After(@storage, 'submitCodeResponse', (result) => @useCase.submissionPosted() if result)
    After(@useCase, 'submissionPosted', @gui.submissionPosted)
    After(@storage, 'submitCodeIndication', (result) => @useCase.submissionResultUpdated(result))
    After(@useCase, 'submissionResultUpdated', (result) => @gui.submissionResultUpdated(result))
    # ranking update
    After(@storage, 'rankingUpdateIndication', (ranking) => @useCase.rankingUpdated(ranking))
    After(@useCase, 'rankingUpdated', (ranking) => @gui.rankingUpdated(ranking))

 
