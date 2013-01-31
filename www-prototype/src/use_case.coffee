class UseCase
  constructor: ->
    @problem = {}
    @code = {}
    @submissions = []
    @ranking = {}

  setData: (data) =>
    @setProblem(data.problem)
    @setCode(data.code)
    @setSubmissions(data.submissions)
    @setRanking(data.ranking)

  setProblem: (@problem) =>
  setCode: (@code) =>
  setSubmissions: (@submissions) =>
  setRanking: (@ranking) =>

  start: =>
    @prefetchAll()

  prefetchAll: =>

  prefetchingFinished: (data) =>
    if data
      @setData(data)
    else
      @prefetchingErrored()

  prefetchingErrored: =>

  saveCode: (code) =>
    @code.text = code

  compileCode: (code) =>

  codeCompilationStarted: =>

  codeCompilationFinished: (result) =>

  submitCode: (code) =>

  submissionPosted: (result) =>

  submissionResultUpdated: (result) =>
