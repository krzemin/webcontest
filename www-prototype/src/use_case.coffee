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

  setProblem: (problem) =>
    @problem = problem
  setCode: (code) =>
    @code = code
  setSubmissions: (submissions) =>
    @submissions = submissions
  setRanking: (ranking) =>
    @ranking = ranking

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
