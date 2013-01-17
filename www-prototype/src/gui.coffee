class Gui
  
  constructor: ->

  # utils

  _render: (template, target, data) =>
    console.log('template = ' + template)
    template = Handlebars.templates[template]
    html = template(data)
    $(target).html(html)
 
  start: =>
    # init stuff here, before loading any data
  
  loadAll: (data) =>
    # init stuff when data is loaded
  
  saveCode: (code) =>
    # triggered when user wants to save code buffer in editor
    # to persistent storage

  compileCode: (code) =>
    # compilation request also should save code remotely, so we
    # doesn't need to save code before compilation

  codeCompilationStarted: =>

  codeCompilationFinished: (result) =>

  submitCode: (code) =>

  submissionPosted: =>

  submissionResultUpdated: (result) =>

  rankingUpdated: (ranking) =>




