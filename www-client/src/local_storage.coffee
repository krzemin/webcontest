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

  setCode: (newText) =>
    @set('code', newText)

  getCode: =>
    @get('code') || """
#include<iostream>
using namespace std;

int main() {
    cout << "Hello World!" << endl;
    return 0;
}
"""

  signIn: (credentials) =>
    if credentials.email == '' && credentials.password == ''
      response = {
        user: {
          name: 'Piotr Krzemiński'
          email: 'pio.krzeminski@gmail.com'
          language: 'c++'
          code_template: """
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
        contest_list: [
          { id: '1', name: 'NSN Programming Open (Qualification Round I)', date: '27.06.2013 17:00', registered: true, active: true}
          { id: '2', name: 'NSN AlgoMatch C++ #1', date: '15.07.2013 19:00', registered: true, active: false }
          { id: '3', name: 'NSN AlgoMatch C++ #2', date: '31.07.2013', registered: false}
          { id: '4', name: 'NSN Programming Open (Qualification round II)', date: '08.08.2013', registered: false }
          { id: '5', name: 'NSN AlgoMatch C++ #3', date: '19.08.2013', registered: false }
          { id: '6', name: 'NSN AlgoMatch C++ #4', date: '28.08.2013', registered: false }
          { id: '7', name: 'NSN Programming Open Finals', date: '05.09.2013', registered: false }
        ]
      }
      setTimeout( (=> @signInResponse(response)), 100)
    else
      setTimeout( (=> @signInResponse(false)), 600)
  signInResponse: (response) =>

  getContest: (id) =>
    contest = {
      id: '1'
      name: 'Web Programming Contest demo'
      agenda: [
        { start: "2012-12-24 13:00:00", content: 'Registration end' }
        { start: "2012-12-24 13:10:00", content: 'Trial round start' }
        { start: "2012-12-24 14:00:00", content: 'Trial round end' }
        { start: "2012-12-24 14:10:00", content: 'Main round start' }
        { start: "2012-12-24 17:40:00", content: 'Main round end' }
        { start: "2012-12-24 17:00:00", content: 'Ranking freeze' }
        { start: "2012-12-24 18:00:00", content: 'Results publish' }
      ]
      problems: [
        {
          id: '1'
          name: 'Problem easy'
          limits: { time: '2.0', memory: '64', sourceCode: '10240' }
          description: """Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas."""
          input_specification: """Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas."""
          output_specification: """Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas."""
          testcases: [
            { input: "5\n4 7 2 9 0", output: "0 9" }
            { input: "10\n1 2 5 9 231232 4324 3214 5435 3 545", output: "1 231232" }
            { input: "5\n7\n2\n7\n4\n8\n8\n8\n", output: "1232\n12323\n76\n8\n2\n" }
          ]
          testcases_explanation:"""Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie."""
        }
        { id: '2', name: 'Stones in my passway' }
        { id: '3', name: 'Brilliant room' }
        { id: '4', name: 'Driving towards the daylight' }
        { id: '5', name: 'Planet Welfare' }
        { id: '6', name: 'Gem' }
      ]
    }
    setTimeout( (=> @contestResponse(contest)), 800)

  contestResponse: (contest) =>
    

