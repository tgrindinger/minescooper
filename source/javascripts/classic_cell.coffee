createjs = require 'createjs'
GameCell = require './game_cell'

class ClassicCell extends GameCell
  constructor: (stage, row, column, height, width, board) ->
    super(stage, row, column, height, width, board)

  drawCell: =>
    @view.graphics.drawRect(0, 0, @view.width, @view.height)

  xpos: =>
    @column * @width

  ypos: =>
    @row * @height

module.exports = ClassicCell
