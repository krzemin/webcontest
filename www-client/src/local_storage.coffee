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
        }
        contest_list: [
          { id: 1, name: 'NSN Programming Open (Qualification Round I)', date: '27.06.2013 17:00', registered: true, active: true}
          { id: 2, name: 'NSN AlgoMatch C++ #1', date: '15.07.2013 19:00', registered: true, active: false }
          { id: 3, name: 'NSN AlgoMatch C++ #2', date: '31.07.2013', registered: false}
          { id: 4, name: 'NSN Programming Open (Qualification round II)', date: '08.08.2013', registered: false }
          { id: 5, name: 'NSN AlgoMatch C++ #3', date: '19.08.2013', registered: false }
          { id: 6, name: 'NSN AlgoMatch C++ #4', date: '28.08.2013', registered: false }
          { id: 7, name: 'NSN Programming Open Finals', date: '05.09.2013', registered: false }
        ]
      }
      setTimeout( (=> @signInResponse(response)), 100)
    else
      setTimeout( (=> @signInResponse(false)), 600)
  signInResponse: (response) =>

  getContest: (id) =>
    contest = {
      id: 1
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
        { id: 1, name: 'Problem 1' }
        { id: 2, name: 'Stones in my passway' }
        { id: 3, name: 'Brilliant room' }
        { id: 4, name: 'Driving towards the daylight' }
        { id: 5, name: 'Planet Welfare' }
        { id: 6, name: 'Gem' }
      ]

    }
    setTimeout( (=> @contestResponse(contest)), 800)

  contestResponse: (contest) =>
    

