class LocalStorage
  constructor: (@namespace) ->
    unless @get('code')
      @set('code', @example_code)
    @ranking = { problems: [], board: []}
    setTimeout( (=> @_rankingUpdateCauser()), 5000)

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

  # prefetching all the stuff
  loadAllRequest: =>
    data = {
      problem: {
        name: 'Compilated Expressions'
        limits: {
          time: '5s'
          memory: '32768kb'
        }
        content: @problem_content
        input: @problem_input
        output: @problem_output
        examples: [
          {
            name: 'Example #1'
            input: @test1_input
            output: @test1_output
            explanation: 'This example should be easy to understand'
          }
          {
            name: 'Example #2'
            input: @test2_input
            output: @test2_output
          }
        ]
      }
      code: {
        language: 'c++'
        mode: 'text/x-c++src'
        text: @get('code')
      }
      submissions: @example_submissions
      ranking: @_generateRanking ['A', 'B', 'C', 'D'], ['Piotr Krzemiński', 'Joe Bonamassa', 'Eric Johnson', 'Jimi Hendrix', 'Eric Clapton', 'Jimi Page', 'George Harrison', 'Ritchie Blackmore', 'Buddy Guy', 'Eddie Van Halen', 'Steve Vai', 'John Petrucci']
    }
    setTimeout( (=> @loadAllResponse(data)), 1000)
  loadAllResponse: (data) =>

  # saving code
  saveCodeRequest: (code) =>
    # async saving code, result randomized
    @set('code', code)
    result = Number.random(0,1) == 0
    setTimeout( (=> @saveCodeResponse(result)), 1000)
  saveCodeResponse: (result) =>

  # compiling code
  compileCodeRequest: (data) =>
    result1 = Number.random(0,3) != 0
    setTimeout( (=> @compileCodeResponse(result1)), 1000)
    if result1
      if Number.random(0,1) == 0
        result2 = { status: 'error', messages: @compilation_with_error }
      else if Number.random(0,1) == 0
        result2 = { status: 'success' }
      else
        result2 = { status: 'success', messages: @compilation_with_warning }
      setTimeout( (=> @compileCodeIndication(result2)), 5000)
  compileCodeResponse: (result) =>
    # boolean result determining whether compilation has beed successfully queued
  compileCodeIndication: (result) => # websocket
    # indicated by websocket channel when compilation is finished

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

  _rankingUpdateCauser: =>
    index = Number.random(0, @ranking.board.length - 1)
    row = @ranking.board[index]
    problems = row.problems
    pindex = Number.random(0, problems.length - 1)
    if (problems[pindex] == '0.00')
      problems[pindex] = parseFloat(Number.random(0, 50000) / 100).toFixed(2)
      total = (problems.map parseFloat).sum()
      @ranking.board[index].score = parseFloat(total).toFixed(2)
      @ranking.board = @ranking.board.sortBy( (x) -> parseFloat(x.score)).reverse()
      i = 1
      @ranking.board = @ranking.board.map (row) =>
        row.no = i
        i += 1
        row
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
    board = board.sortBy( (x) -> parseFloat(x.score)).reverse()
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

  example_code: """
/*
 * Piotr Krzemiński
 * Web Programming Contest demo (2012-12-24)
 * Problem easy
 */

#include<iostream>
#include<string>

using namespace std;

bool op_hi(char op) { return op == '/' || op == '*'; }
bool op_lo(char op) { return op == '+' || op == '-'; }
bool is_op(char op) { return op_hi(op) || op_lo(op); }

bool can_omit(char inop, char leop, char riop) {
  if(op_lo(inop) && (op_hi(leop) || op_hi(riop))) return false;
  if(leop == '-' && op_lo(inop)) return false;
  if(leop == '/' && op_hi(inop)) return false;
  return true;
}

char find_inop(const string & s) {
  int f = -1, p = 0;
  for(int i = 0; i < s.size(); ++i) {
    if(s[i] == '(') ++p;
    else if(s[i] == ')') --p;
    else if(p == 1 && op_lo(s[i])) f = i;
  }
  if(f != -1) return s[f];
  for(int i = 0; i < s.size(); ++i) {
    if(s[i] == '(') ++p;
    else if(s[i] == ')') --p;
    else if(p == 1 && op_hi(s[i])) f = i;
  }
  return s[f];
}

string simplify(const string & s) {
  if(s.find('(') == string::npos) return s;
  int i = 0, N = s.size();
  bool omit[N];
  for(int i = 0; i < N; omit[i++] = false);
  while(i < N) {
    i = s.find('(', i);
    if(i == string::npos) break;
    int p,j;
    for(p = 1, j = i+1; p>0; ++j) {
      if(s[j] == '(') ++p;
      else if(s[j] == ')') --p;
    }
    --j;

    int le = i-1, ri = j+1;
    char c_le, c_ri;
    while(le >= 0 && omit[le]) --le;
    if(is_op(s[le])) c_le = s[le]; else c_le = '(';
    while(ri < N && omit[ri]) ++ri;
    if(is_op(s[ri])) c_ri = s[ri]; else c_ri = ')';
    char c_in = find_inop(s.substr(i,j-i+1));

    if(can_omit(c_in,c_le,c_ri)) {
      omit[i] = omit[j] = true;
    }
    ++i;
  }


  string r;
  for(int i = 0; i < N; ++i) {
    if(omit[i]) continue;
    r += s[i];
  }
  return r;
}

int main() {
  int n;
  string s;
  cin >> n;
  while(n--) {
    cin >> s;
    cout << simplify(s) << endl;
  }
  return 0;
}

"""


  example_submissions: [
        #{
        #  id: 6
        #  timestamp: '2013-01-03 20:59:21'
        #  status: 'running'
        #  progress: 70
        #}
        {
          id: 5
          timestamp: '2013-01-03 20:55:08'
          status: 'finished'
          progress: 100
          code: 'passed'
          performance: { time: '4.12', memory: '22368kb'}
          score: '315.23'
        }
        {
          id: 4
          timestamp: '2013-01-03 20:51:21'
          status: 'finished'
          progress: 10
          code: 're'
          performance: { time: '1.02s', memory: '31337kb'}
          score: '0.00'
        }
        {
          id: 3
          timestamp: '2013-01-03 20:03:29'
          status: 'finished'
          progress: 40
          code: 'wa'
          performance: { time: '4.77s', memory: '21356kb'}
          score: '0.00'
        }
        {
          id: 2
          timestamp: '2013-01-03 19:26:11'
          status: 'finished'
          progress: 90
          code: 'tle'
          performance: { memory: '22368kb'}
          score: '0.00'
        }
        {
          id: 1
          timestamp: '2013-01-03 19:26:11'
          status: 'finished'
          progress: 60
          code: 'mle'
          performance: { time: '2.11s' }
          score: '0.00'
        }
      ]

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



  problem_content: """<p>The most important activity of ACM is the GSM network. As the mobile phone operator, ACM must build its own transmitting stations. It is very important to compute the exact behaviour of electro-magnetic waves. Unfortunately, prediction of electro-magnetic fields is a very complex task and the formulas describing them are very long and hard-to-read. For example, Maxwell's Equations describing the basic laws of electrical engineering are really tough.</p>
                    <p>ACM has designed its own computer system that can make some field computations and produce results in the form of mathematic expressions. Unfortunately, by generating the expression in several steps, there are always some unneeded parentheses inside the expression. Your task is to take these partial results and make them "nice" by removing all unnecessary parentheses.</p>"""
  problem_input: """<p>There is a single positive integer T on the first line of input (equal to about 10000). It stands for the number of expressions to follow. Each expression consists of a single line containing only lowercase letters, operators (+, -, *, /) and parentheses (( and )). The letters are variables that can have any value, operators and parentheses have their usual meaning. Multiplication and division have higher priority then subtraction and addition. All operations with the same priority are computed from left to right (operators are left-associative). There are no spaces inside the expressions. No input line contains more than 250 characters.</p>"""
  problem_output: """<p>Print a single line for every expression. The line must contain the same expression with unneeded parentheses removed. You must remove as many parentheses as possible without changing the semantics of the expression. The semantics of the expression is considered the same if and only if any of the following conditions hold:</p>
                <ul>
                <li>The ordering of operations remains the same. That means "(a+b)+c" is the same as "a+b+c", and "a+(b/c)" is the same as "a+b/c".</li>
                <li>The order of some operations is swapped but the result remains unchanged with respect to the addition and multiplication associativity. That means "a+(b+c)" and "(a+b)+c" are the same. We can also combine addition with subtraction and multiplication with division, if the subtraction or division is the second operation. For example, "a+(b-c)" is the same as "a+b-c".</li>
                </ul>
                <p>You cannot use any other laws, namely you cannot swap left and right operands and you cannot replace "a-(b-c)" with "a-b+c".</p>"""
  test1_input: """5
(a+(b*c))
((a+b)*c)
(a*(b*c))
(a*(b/c)*d)
((a/(b/c))/d)"""
  test1_output: """a+b*c
(a+b)*c
a*b*c
a*b/c*d
a/(b/c)/d"""
  test2_input: """3
((x))
(a+b)-(c-d)-(e/f)
(a+b)+(c-d)-(e+f)"""
  test2_output: """x
a+b-(c-d)-e/f
a+b+c-d-(e+f)"""
