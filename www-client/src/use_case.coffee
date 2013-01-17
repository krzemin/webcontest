class UseCase
  constructor: ->
    @user = {}
    @contest_list = []
    @contest = {}
    @ranking = []

  start: =>
    # temporary, for faster contest area loading
    # @openContest('1')

  signIn: (response) =>
    if response
      @user = response.user
      @contest_list = response.contest_list
      @loadContestList()
    else
      @signInError()

  signInError: =>
  loadContestList: =>

  openContest: (id) =>
  loadContest: (contest) =>
    @contest = contest
    @contestWelcome()

  contestWelcome: =>

  problem: (id) =>
  getProblem: (id) =>
    console.log(id)
    console.log(@contest.problems.find({id: id}))
    @contest.problems.find({id: id})
  
  status: =>
  ranking: =>
  messages: =>
  settings: =>
  exitContestArea: =>
    @loadContestList()
  signOut: =>
  
  initCodeView: =>
     
  codeChanged: (newText) =>

  newTestCase: (input, expectedOutput) =>


   
