class UseCase
  constructor: ->
    @user = {}
    @contest_list = []
    @contest = {}

  start: =>

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
  problem: =>
  status: =>
  ranking: =>
  messages: =>
  settings: =>
  exitContestArea: =>
    @loadContestList()
  signOut: =>
  
  initCodeView: =>
     
  codeChanged: (newText) =>

   
