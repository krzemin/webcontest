class LocalStorage
  constructor: (@namespace) ->
    @ranking = { problems: [], board: []}

  set: (key, value) =>
    $.jStorage.set("#{@namespace}/#{key}", value)

  get: (key) =>
    $.jStorage.get("#{@namespace}/#{key}")

  remove: (key) =>
    $.jStorage.deleteKey("#{@namespace}/#{key}")

  flush: =>
    for key in $.jStorage.index()
      if key.match("^#{@namespace}")
        $.jStorage.deleteKey(key)


  # submitting code
  submitCodeRequest: (code) =>
    result1 = Number.random(0,4) != 0
    subId = Number.random(10, 1000)
    result1 = { id: subId, timestamp: Date.create().format('{yyyy}-{MM}-{dd} {HH}:{mm}:{ss}'), status: 'waiting' } if result1
    setTimeout( (=> @submitCodeResponse(result1)), 1000)
    if result1
      result2 = { id: subId, status: 'compiling' }
      setTimeout( (=> @submitCodeIndication(result2)), 3000)
      result3 = { id: subId, status: 'running', progress: 20 }
      setTimeout( (=> @submitCodeIndication(result3)), 4000)
      result4 = { id: subId, status: 'running', progress: 40 }
      setTimeout( (=> @submitCodeIndication(result4)), 6000)
      result5 = { id: subId, status: 'running', progress: 50 }
      setTimeout( (=> @submitCodeIndication(result5)), 8000)
      result6 = { id: subId, status: 'running', progress: 60 }
      setTimeout( (=> @submitCodeIndication(result6)), 8500)
      result7 = { id: subId, status: 'running', progress: 70 }
      setTimeout( (=> @submitCodeIndication(result7)), 9000)
      result8 = { id: subId, status: 'running', progress: 90 }
      setTimeout( (=> @submitCodeIndication(result8)), 9500)
      result9 = @_generateFinishedSubmissionStatus(subId)
      setTimeout( (=> @submitCodeIndication(result9)), 10000)
  submitCodeResponse: (result) =>
    # boolean result determining whether submission has been successfully received
  submitCodeIndication: (result) => # websocket
    # compilation status & progress update

  # async update of ranking
  rankingUpdateIndication: (ranking) =>

  _sortRanking: (ranking) =>
    ranking.sort((a,b) ->
      if parseFloat(a.score) > parseFloat(b.score)
        return -1
      else if a.score == b.score
        return if a.name < b.name then -1 else 1
      else
        return 1
    )

  _rankingUpdateCauser: =>
    index = Number.random(0, @ranking.board.length - 1)
    row = @ranking.board[index]
    problems = row.problems
    pindex = Number.random(0, problems.length - 1)
    if (problems[pindex] == '0.00')
      problems[pindex] = parseFloat(Number.random(0, 50000) / 100).toFixed(2)
      total = (problems.map parseFloat).sum()
      @ranking.board[index].score = parseFloat(total).toFixed(2)
      @ranking.board = @_sortRanking(@ranking.board)
      i = 1
      @ranking.board.each (row) => row.no = i; i += 1
      @rankingUpdateIndication(@ranking)
      setTimeout((=> @_rankingUpdateCauser()), Number.random(3000, 10000))
      @internalCounter = 0
    else
      @internalCounter += 1
      if @internalCounter < 20
        setTimeout((=> @_rankingUpdateCauser()), Number.random(100, 500))

  _generateRanking: (problems, names) =>
    board = names.map (name) => {
      name: name,
      problems: problems.map (name) =>
        solved = Number.random(0,3) == 0
        return 0 unless solved
        return Number.random(0, 50000) / 100
    }
    board = board.map (row) =>
      row.score = parseFloat(row.problems.sum()).toFixed(2)
      row.problems = row.problems.map (score) => parseFloat(score).toFixed(2)
      row
    board = @_sortRanking(board)
    i = 1
    board = board.map (row) =>
      row.no = i
      i += 1
      row
    @ranking = { problems: problems, board: board }
    @ranking

  _generateFinishedSubmissionStatus: (id) =>
    c = Number.random(0,6)
    code = 'mle' if c == 6
    code = 'tle' if c == 5
    code = 'wa' if c == 4
    code = 're' if c == 3
    code = 'passed' if c <= 2
    performance = {}
    performance.time = parseFloat(Number.random(50, 600) / 100).toFixed(2) + 's' if c != 5
    performance.memory = Number.random(4000, 30000) + 'kb' if c != 6
    {
      id: id
      status: 'finished'
      code: code
      score: parseFloat(if c <= 2 then Number.random(10000, 50000) / 100 else 0).toFixed(2)
      performance: performance
    }

  compilation_with_warning: """clang++ -c -g -MMD -MP -MF
syscallshandler.cpp:14:13: warning: enumeration value 'stBlockedFile' not handled in switch [-Wswitch]
    switch (state) {
            ^
syscallshandler.cpp:306:50: warning: comparison of constant 2 with expression of type 'bool' is always false
      [-Wtautological-constant-out-of-range-compare]
    if (lastFileMode == O_RDONLY || lastFileMode == O_RDWR) {
                                    ~~~~~~~~~~~~ ^  ~~~~~~
syscallshandler.cpp:309:54: warning: comparison of constant 2 with expression of type 'bool' is always false
      [-Wtautological-constant-out-of-range-compare]
        if (lastFileMode == O_WRONLY || lastFileMode == O_RDWR) {
                                        ~~~~~~~~~~~~ ^  ~~~~~~
3 warnings generated."""

  compilation_with_error: """clang++ -c -g -MMD -MP -MF
output.cpp:14:1: error: unknown type name 'vo'
vo id print(OutputResult code, float maxTime, long maxMemory) {
^
output.cpp:14:6: error: expected ';' after top level declarator
vo id print(OutputResult code, float maxTime, long maxMemory) {
     ^
     ;
2 errors generated."""


