class UseCase
  constructor: ->
    @user = {}
    @contest_list = []
    @contest = {}

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

   
