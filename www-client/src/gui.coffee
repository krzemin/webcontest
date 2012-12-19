class Gui
  constructor: ->

  start: =>
    $('#code').codemirror({
                value: 'int add(int a, int b) { return a + b; }',
                mode: 'clike'
            })

