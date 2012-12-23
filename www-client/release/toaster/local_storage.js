var LocalStorage,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

LocalStorage = (function() {

  function LocalStorage(namespace) {
    this.namespace = namespace;
    this.getContest = __bind(this.getContest, this);

    this.getContestList = __bind(this.getContestList, this);

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
    var result,
      _this = this;
    result = credentials.email === '' && credentials.password === '';
    return setTimeout((function() {
      return _this.signInResponse(result);
    }), 700);
  };

  LocalStorage.prototype.signInResponse = function(response) {};

  LocalStorage.prototype.getContestList = function() {
    return [
      {
        id: 1,
        name: 'NSN Programming Open (Qualification Round I)',
        date: '27.06.2013 17:00',
        registered: true,
        active: true
      }, {
        id: 2,
        name: 'NSN AlgoMatch C++ #1',
        date: '15.07.2013 19:00',
        registered: true,
        active: false
      }, {
        id: 3,
        name: 'NSN AlgoMatch C++ #2',
        date: '31.07.2013',
        registered: false
      }, {
        id: 4,
        name: 'NSN Programming Open (Qualification round II)',
        date: '08.08.2013',
        registered: false
      }, {
        id: 5,
        name: 'NSN AlgoMatch C++ #3',
        date: '19.08.2013',
        registered: false
      }, {
        id: 6,
        name: 'NSN AlgoMatch C++ #4',
        date: '28.08.2013',
        registered: false
      }, {
        id: 7,
        name: 'NSN Programming Open Finals',
        date: '05.09.2013',
        registered: false
      }
    ];
  };

  LocalStorage.prototype.getContest = function(id) {
    return {
      name: 'Web Programming Contest demo',
      problems: [
        {
          id: 1,
          name: 'Problem 1'
        }, {
          id: 2,
          name: 'Stones in my passway'
        }, {
          id: 3,
          name: 'Brilliant room'
        }, {
          id: 4,
          name: 'Driving towards the daylight'
        }, {
          id: 5,
          name: 'Planet Welfare'
        }, {
          id: 6,
          name: 'Gem'
        }
      ]
    };
  };

  return LocalStorage;

})();
