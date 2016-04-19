createjs = require 'createjs'
GameCell = require './game_cell'

class BrickCell extends GameCell
  constructor: (stage, row, column, height, width, board) ->
    super(stage, row, column, height, width, board)

  drawCell: =>
    @view.graphics.drawRect(0, 0, @view.width, @view.height)

  xpos: =>
    if @board.isEven(@row)
      @column * @width
    else
      (@column * @width) + (@width * 0.5)

  ypos: =>
    @row * @height

module.exports = BrickCell
