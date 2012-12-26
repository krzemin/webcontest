var LocalStorage,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

LocalStorage = (function() {

  function LocalStorage(namespace) {
    this.namespace = namespace;
    this.contestResponse = __bind(this.contestResponse, this);

    this.getContest = __bind(this.getContest, this);

    this.signInResponse = __bind(this.signInResponse, this);

    this.signIn = __bind(this.signIn, this);

    this.getCode = __bind(this.getCode, this);

    this.setCode = __bind(this.setCode, this);

    this.flush = __bind(this.flush, this);

    this.remove = __bind(this.remove, this);

    this.get = __bind(this.get, this);

    this.set = __bind(this.set, this);

  }

  LocalStorage.prototype.set = function(key, value) {
    return $.jStorage.set("" + this.namespace + "/" + key, value);
  };

  LocalStorage.prototype.get = function(key) {
    return $.jStorage.get("" + this.namespace + "/" + key);
  };

  LocalStorage.prototype.remove = function(key) {
    return $.jStorage.deleteKey("" + this.namespace + "/" + key);
  };

  LocalStorage.prototype.flush = function() {
    var key, _i, _len, _ref, _results;
    _ref = $.jStorage.index();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      key = _ref[_i];
      if (key.match("^" + this.namespace)) {
        _results.push($.jStorage.deleteKey(key));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  LocalStorage.prototype.setCode = function(newText) {
    return this.set('code', newText);
  };

  LocalStorage.prototype.getCode = function() {
    return this.get('code') || "#include<iostream>\nusing namespace std;\n\nint main() {\n    cout << \"Hello World!\" << endl;\n    return 0;\n}";
  };

  LocalStorage.prototype.signIn = function(credentials) {
    var response,
      _this = this;
    if (credentials.email === '' && credentials.password === '') {
      response = {
        user: {
          name: 'Piotr Krzemiński',
          email: 'pio.krzeminski@gmail.com',
          language: 'c++',
          code_template: "/*\n * Piotr Krzemiński\n * Web Programming Contest demo (2012-12-24)\n * Problem easy\n */\n\n#include <cstdio>\n#include <cstring>\n#include <algorithm>\n#include <functional>\n\nusing namespace std;\n\nint T, C, R, max_d = 0;\nbool BOARD[1000][1000];\nbool VISITED[1000][1000];\nchar line[1001];\npair<int, int> start;\n\nint dfs(int row, int col)\n{\n    if(row < 0 || row >= R || col < 0 || col >= C) return 0;\n    if(VISITED[row][col]) return 0;\n    if(!BOARD[row][col]) return 0;\n    VISITED[row][col] = true;\n\n    int t[4];\n    t[0] = dfs(row, col - 1);\n    t[1] = dfs(row - 1, col);\n    t[2] = dfs(row, col + 1);\n    t[3] = dfs(row + 1, col);\n\n    partial_sort(t, t + 2, t + 4, greater<int>());\n\n    if(t[0] + t[1] + 1 > max_d)\n        max_d = t[0] + t[1] + 1;\n\n    return 1 + t[0];\n}\n\nint main()\n{\n    scanf(\"%d\", &T);\n\n    while(T--)\n    {\n        memset(BOARD, 0, 1000000);\n        memset(VISITED, 0, 1000000);\n        max_d = 0;\n        scanf(\"%d %d\\n\", &C, &R);\n        for(int r = 0; r < R; ++r)\n        {\n            scanf(\"%s\\n\", line);\n            for(int c = 0; c < C; ++c)\n            {\n                BOARD[r][c] = (line[c] != '#');\n                if(BOARD[r][c])\n                {\n                    start.first = r;\n                    start.second = c;\n                }\n            }\n        }\n        max_d = max(max_d, dfs(start.first, start.second));\n        printf(\"Maximum rope length is %d.\\n\", max_d - 1);\n    }\n\n    return 0;\n}"
        },
        contest_list: [
          {
            id: '1',
            name: 'NSN Programming Open (Qualification Round I)',
            date: '27.06.2013 17:00',
            registered: true,
            active: true
          }, {
            id: '2',
            name: 'NSN AlgoMatch C++ #1',
            date: '15.07.2013 19:00',
            registered: true,
            active: false
          }, {
            id: '3',
            name: 'NSN AlgoMatch C++ #2',
            date: '31.07.2013',
            registered: false
          }, {
            id: '4',
            name: 'NSN Programming Open (Qualification round II)',
            date: '08.08.2013',
            registered: false
          }, {
            id: '5',
            name: 'NSN AlgoMatch C++ #3',
            date: '19.08.2013',
            registered: false
          }, {
            id: '6',
            name: 'NSN AlgoMatch C++ #4',
            date: '28.08.2013',
            registered: false
          }, {
            id: '7',
            name: 'NSN Programming Open Finals',
            date: '05.09.2013',
            registered: false
          }
        ]
      };
      return setTimeout((function() {
        return _this.signInResponse(response);
      }), 100);
    } else {
      return setTimeout((function() {
        return _this.signInResponse(false);
      }), 600);
    }
  };

  LocalStorage.prototype.signInResponse = function(response) {};

  LocalStorage.prototype.getContest = function(id) {
    var contest,
      _this = this;
    contest = {
      id: '1',
      name: 'Web Programming Contest demo',
      agenda: [
        {
          start: "2012-12-24 13:00:00",
          content: 'Registration end'
        }, {
          start: "2012-12-24 13:10:00",
          content: 'Trial round start'
        }, {
          start: "2012-12-24 14:00:00",
          content: 'Trial round end'
        }, {
          start: "2012-12-24 14:10:00",
          content: 'Main round start'
        }, {
          start: "2012-12-24 17:40:00",
          content: 'Main round end'
        }, {
          start: "2012-12-24 17:00:00",
          content: 'Ranking freeze'
        }, {
          start: "2012-12-24 18:00:00",
          content: 'Results publish'
        }
      ],
      problems: [
        {
          id: '1',
          name: 'Problem easy',
          limits: {
            time: '2.0',
            memory: '64',
            sourceCode: '10240'
          },
          description: "Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.",
          input_specification: "Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.",
          output_specification: "Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.",
          testcases: [
            {
              input: "5\n4 7 2 9 0",
              output: "0 9"
            }, {
              input: "10\n1 2 5 9 231232 4324 3214 5435 3 545",
              output: "1 231232"
            }, {
              input: "5\n7\n2\n7\n4\n8\n8\n8\n",
              output: "1232\n12323\n76\n8\n2\n"
            }
          ],
          testcases_explanation: "Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie."
        }, {
          id: '2',
          name: 'Stones in my passway'
        }, {
          id: '3',
          name: 'Brilliant room'
        }, {
          id: '4',
          name: 'Driving towards the daylight'
        }, {
          id: '5',
          name: 'Planet Welfare'
        }, {
          id: '6',
          name: 'Gem'
        }
      ]
    };
    return setTimeout((function() {
      return _this.contestResponse(contest);
    }), 800);
  };

  LocalStorage.prototype.contestResponse = function(contest) {};

  return LocalStorage;

})();
