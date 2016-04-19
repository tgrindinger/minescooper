createjs = require 'createjs'
GameCell = require './game_cell'

class TriangleShiftedCell extends GameCell
  constructor: (stage, row, column, orient, height, width, board) ->
    @orient = orient
    super(stage, row, column, height, width, board)

  constructPoints: =>
    halfWidth = @view.width * 0.5
    if @orient == @board.POINTS_DOWN
      @p1 = {x: 0,           y: 0}
      @p2 = {x: @view.width, y: 0}
      @p3 = {x: halfWidth,   y: @view.height}
    else
      @p1 = {x: halfWidth,   y: 0}
      @p2 = {x: @view.width, y: @view.height}
      @p3 = {x: 0,           y: @view.height}

  displayCell: =>
    @constructPoints()
    super()

  drawCell: =>
    @view.graphics.moveTo(@p1.x, @p1.y)
      .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y).lineTo(@p1.x, @p1.y)
  
  xpos: =>
    @column * (@width * 0.5)

  ypos: =>
    @row * @height

module.exports = TriangleShiftedCell
