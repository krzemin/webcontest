class Glue
  constructor: (@useCase, @gui, @storage)->
    LogAll(@useCase, 'UseCase')
    LogAll(@gui, 'Gui')

    After(@useCase, 'start', @gui.start)

