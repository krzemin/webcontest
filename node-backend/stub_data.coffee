class StubData
  constructor: ->
    @code = @example_code
    @ranking = @_generateRanking ['A', 'B', 'C', 'D'], [ 'Piotr Krzemiński', 'Joe Bonamassa', 'Eric Johnson', 'Jimi Hendrix', 'Eric Clapton', 'Jimmy Page', 'George Harrison', 'Ritchie Blackmore', 'Buddy Guy', 'Eddie Van Halen', 'Steve Vai', 'John Petrucci' ]

  all_data: =>
  	{
      problem: {
        name: 'Complicated Expressions'
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
        text: @code
      }
      submissions: []
      ranking: @ranking
    }

  updateRanking: =>
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
      @internalCounter = 0
      return @ranking
    else
      @internalCounter += 1
      if @internalCounter < 20
        return @updateRanking() 
      else
        return @ranking

  _sortRanking: (ranking) =>
    ranking.sort((a,b) ->
      if parseFloat(a.score) > parseFloat(b.score)
        return -1
      else if a.score == b.score
        return if a.name < b.name then -1 else 1
      else
        return 1
    )

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
    c = Number.random(0,9)
    code = 'mle' if c == 9
    code = 'tle' if c == 8
    code = 'wa' if c == 7
    code = 're' if c == 6
    code = 'passed' if c <= 5
    performance = {}
    performance.time = parseFloat(Number.random(50, 600) / 100).toFixed(2) + 's' if c != 5
    performance.memory = Number.random(4000, 30000) + 'kb' if c != 6
    {
      _id: id
      status: 'finished'
      code: code
      score: parseFloat(if c <= 5 then Number.random(10000, 50000) / 100 else 0).toFixed(2)
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


exports.StubData = StubData