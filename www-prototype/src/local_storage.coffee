class LocalStorage
  constructor: (@namespace) ->

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

  _generateRanking: (problems, names) =>
    board = names.map (name) => {
      name: name,
      problems: problems.map (name) =>
        solved = Number.random(0,1) == 0
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
      row.no = i + "."
      i += 1
      row
    { problems: problems, board: board }

  # prefetching all the stuff
  loadAllRequest: =>
    data = {
      problem: {
        name: 'Name of the problem'
        limits: {
          time: '3s'
          memory: '32768kb'
        }
        content: '<p>This is simple HTML problem content</p>'
        input: '<p>This is simple HTML problem input specification</p>'
        output: '<p>This is simple HTML problem output specification</p>'
        examples: [
          {
            name: 'Example #1'
            input: '1 2 3 4 5 6 7 8'
            output: '2 3 4 5 6 7 8 9'
            explanation: 'This test bla bla bla'
          }
          {
            name: 'Example #2'
            input: '1 1 1 1 1 1 1 1 1 1'
            output: '2 2 2 2 2 2 2 2 2 2'
            explanation: ''
          }
        ]
      }
      code: {
        language: 'c++'
        mode: 'text/x-c++src'
        text: """
/*
 * Piotr Krzemiński
 * Web Programming Contest demo (2012-12-24)
 * Problem easy
 */

#include <cstdio>
#include <cstring>
#include <algorithm>
#include <functional>

using namespace std;

int T, C, R, max_d = 0;
bool BOARD[1000][1000];
bool VISITED[1000][1000];
char line[1001];
pair<int, int> start;

int dfs(int row, int col)
{
    if(row < 0 || row >= R || col < 0 || col >= C) return 0;
    if(VISITED[row][col]) return 0;
    if(!BOARD[row][col]) return 0;
    VISITED[row][col] = true;

    int t[4];
    t[0] = dfs(row, col - 1);
    t[1] = dfs(row - 1, col);
    t[2] = dfs(row, col + 1);
    t[3] = dfs(row + 1, col);

    partial_sort(t, t + 2, t + 4, greater<int>());

    if(t[0] + t[1] + 1 > max_d)
        max_d = t[0] + t[1] + 1;

    return 1 + t[0];
}

int main()
{
    scanf("%d", &T);

    while(T--)
    {
        memset(BOARD, 0, 1000000);
        memset(VISITED, 0, 1000000);
        max_d = 0;
        scanf("%d %d\\n", &C, &R);
        for(int r = 0; r < R; ++r)
        {
            scanf("%s\\n", line);
            for(int c = 0; c < C; ++c)
            {
                BOARD[r][c] = (line[c] != '#');
                if(BOARD[r][c])
                {
                    start.first = r;
                    start.second = c;
                }
            }
        }
        max_d = max(max_d, dfs(start.first, start.second));
        printf("Maximum rope length is %d.\\n", max_d - 1);
    }

    return 0;
}"""
      }
      submissions: [
        {
          id: 6
          timestamp: '2013-01-03 20:59:21'
          status: 'running'
          progress: '70%'
        }
        {
          id: 5
          timestamp: '2013-01-03 20:55:08'
          status: 'finished'
          progress: '100%'
          code: 'passed'
          performance: { time: '4.12', memory: '22368kb'}
          score: '315.23'
        }
        {
          id: 4
          timestamp: '2013-01-03 20:51:21'
          status: 'finished'
          progress: '10%'
          code: 're'
          performance: { time: '1.02s', memory: '31337kb'}
          score: '0.00'
        }
        {
          id: 3
          timestamp: '2013-01-03 20:03:29'
          status: 'finished'
          progress: '40%'
          code: 'wa'
          performance: { time: '4.77s', memory: '21356kb'}
          score: '0.00'
        }
        {
          id: 2
          timestamp: '2013-01-03 19:26:11'
          status: 'finished'
          progress: '90%'
          code: 'tle'
          performance: { memory: '22368kb'}
          score: '0.00'
        }
        {
          id: 1
          timestamp: '2013-01-03 19:26:11'
          status: 'finished'
          progress: '60%'
          code: 'mle'
          performance: { time: '2.11s' }
          score: '0.00'
        }
      ]
      ranking: @_generateRanking ['A', 'B', 'C', 'D'], ['Piotr Krzemiński', 'Joe Bonamassa', 'Eric Johnson', 'Jimi Hendrix', 'Eric Clapton', 'Jimi Page', 'George Harrison', 'Ritchie Blackmore', 'Buddy Guy', 'Eddie Van Halen', 'Steve Vai', 'John Petrucci']
    }
    setTimeout( (=> @loadAllResponse(data)), 1000)
  loadAllResponse: (data) =>

  # saving code
  saveCodeRequest: (code) =>
    # async saving code, result ok
    result = true
    setTimeout( (=> @saveCodeResponse(result)), 1000)
  saveCodeResponse: (result) =>

  # compiling code
  compileCodeRequest: (data) =>
    result1 = true
    setTimeout( (=> @compileCodeResponse(result1)), 1000)
    result2 = { status: 'error', message: 'bla bla bla' }
    setTimeout( (=> @compileCodeIndication(result2)), 5000)
  compileCodeResponse: (result) =>
    # boolean result determining whether compilation has beed successfully queued
  compileCodeIndication: (result) => # websocket
    # indicated by websocket channel when compilation is finished

  # submitting code
  submitCodeRequest: (code) =>
    result1 = true
    setTimeout( (=> @submitCodeResponse(result1)), 1000)
    result2 = { status: 'waiting' }
    setTimeout( (=> @submitCodeIndication(result2)), 2000)
    result3 = { status: 'compiling' }
    setTimeout( (=> @submitCodeIndication(result3)), 4000)
    result4 = { status: 'running', progress: '10%' }
    setTimeout( (=> @submitCodeIndication(result4)), 6000)
    result5 = { status: 'running', progress: '70%' }
    setTimeout( (=> @submitCodeIndication(result5)), 8000)
    result6 = {
                status: 'finished', progress: '100%', code: 'passed',
                performance: { time: '3.26s', memory: '19325kb'},
                score: '315.23'
              }
    setTimeout( (=> @submitCodeIndication(result6)), 10000)
  submitCodeResponse: (result) =>
    # boolean result determining whether submission has been successfully received
  submitCodeIndication: (result) => # websocket
    # compilation status & progress update

  # async update of ranking
  rankingUpdateIndication: (ranking) =>
    




