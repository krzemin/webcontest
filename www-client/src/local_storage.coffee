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
    credentials.email == '' && credentials.password == ''

  getContestList: =>
    [
      { id: 1, name: 'NSN Programming Open (Qualification Round I)', date: '27.06.2013 17:00', registered: true, active: true}
      { id: 2, name: 'NSN AlgoMatch C++ #1', date: '15.07.2013 19:00', registered: true, active: false }
      { id: 3, name: 'NSN AlgoMatch C++ #2', date: '31.07.2013', registered: false}
      { id: 4, name: 'NSN Programming Open (Qualification round II)', date: '08.08.2013', registered: false }
      { id: 5, name: 'NSN AlgoMatch C++ #3', date: '19.08.2013', registered: false }
      { id: 6, name: 'NSN AlgoMatch C++ #4', date: '28.08.2013', registered: false }
      { id: 7, name: 'NSN Programming Open Finals', date: '05.09.2013', registered: false }
    ]

  getContest: (id) =>
    {
      name: 'Web Programming Contest demo'
      problems: [
        { id: 1, name: 'Problem 1' }
        { id: 2, name: 'Stones in my passway' }
        { id: 3, name: 'Brilliant room' }
        { id: 4, name: 'Driving towards the daylight' }
        { id: 5, name: 'Planet Welfare' }
        { id: 6, name: 'Gem' }
      ]

    }


