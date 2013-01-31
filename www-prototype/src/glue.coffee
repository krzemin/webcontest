class Glue
  constructor: (@useCase, @gui, @api, @storage, @websocket) ->

    # logging stuff for adapters
    LogAll @useCase, 'UseCase'
    LogAll @gui, 'Gui'
    LogAll @api, 'API'
    LogAll @storage, 'Storage'
    LogAll @websocket, 'WebSocket'

    AfterAll @gui, ['showProblem',
                    'showCode',
                    'showSubmissions',
                    'showRanking',
                    'submissionPosted'], @gui.uiChanged

    # initiation & starting an application
    After @useCase, 'start', @gui.start
    After @useCase, 'start', @websocket.init
    After @useCase, 'prefetchAll', @api.prefetchAllRequest
    After @api, 'prefetchAllResponse', (data) => @useCase.prefetchingFinished(data)
    Before @useCase, 'setData', (data) => @gui.showUIContainers(data)
    Before @useCase, 'prefetchingErrored', (data) => @gui.showPrefetchingError(data)
    After @useCase, 'setProblem', @gui.showProblem
    After @useCase, 'setCode', @gui.showCode
    After @useCase, 'setSubmissions', @gui.showSubmissions
    After @useCase, 'setRanking', @gui.showRanking

    # saving code to a remote storage
    After @gui, 'saveCode', (code) => @useCase.saveCode(code)
    After @useCase, 'saveCode', (code) => @api.saveCodeRequest(code)
    After @api, 'saveCodeResponse', (result) => @gui.codeSaved(result)
    # # compile code
    After @gui, 'compileCode', (code) => @useCase.compileCode(code)
    After @useCase, 'compileCode', (code) => @api.compileCodeRequest(code)
    After @api, 'compileCodeResponse', (result) => @useCase.codeCompilationStarted(result)
    After @useCase, 'codeCompilationStarted', @gui.codeCompilationStarted
    After @websocket, 'compileCodeIndication', (result) => @useCase.codeCompilationFinished(result)
    After @useCase, 'codeCompilationFinished', (result) => @gui.codeCompilationFinished(result)
    # submit code
    After @gui, 'submitCode', (code) => @useCase.submitCode(code)
    After @useCase, 'submitCode', (code) => @api.submitCodeRequest(code)
    After @api, 'submitCodeResponse', (result) => @useCase.submissionPosted(result)
    After @useCase, 'submissionPosted', @gui.submissionPosted
    After @websocket, 'submitCodeIndication', (result) => @useCase.submissionResultUpdated(result)
    After @useCase, 'submissionResultUpdated', (result) => @gui.submissionResultUpdated(result)
    # ranking update
    After @websocket, 'rankingUpdateIndication', (ranking) => @useCase.setRanking(ranking)
    # gui updates
    # AfterAll @gui, ['showProblem',
    #                 'showCode',
    #                 'showSubmissions',
    #                 'showRanking',
    #                 'submissionPosted'], => @gui.uiChanged()

