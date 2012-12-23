class UseCase
  constructor: ->
    @contest = {}

  start: =>

  signIn: (response) =>
    if response
      @loadContestList()
    else
      @signInError()

  signInError: =>
  loadContestList: =>

  openContest: (id) =>
    @contestWelcome()

  contestWelcome: =>
  problem: =>
  status: =>
  ranking: =>
  messages: =>
  settings: =>

  signOut: =>
  
  initCodeView: =>
     
  codeChanged: (newText) =>

   
