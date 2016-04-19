createjs = require 'createjs'
GameCell = require './game_cell'

class HexagonalCell extends GameCell
  constructor: (stage, row, column, height, width, board) ->
    super(stage, row, column, height, width, board)

  constructPoints: =>
    fourth = @view.width / 4
    threeFourths = fourth * 3
    half = @view.width / 2
    full = @view.width
    @p1 = {x: half, y: 0}
    @p2 = {x: full, y: fourth}
    @p3 = {x: full, y: threeFourths}
    @p4 = {x: half, y: full}
    @p5 = {x: 0,    y: threeFourths}
    @p6 = {x: 0,    y: fourth}

  displayCell: =>
    @constructPoints()
    super()

  drawCell: =>
    @view.graphics.moveTo(@p1.x, @p1.y)
      .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y).lineTo(@p4.x, @p4.y)
      .lineTo(@p5.x, @p5.y).lineTo(@p6.x, @p6.y).lineTo(@p1.x, @p1.y)

  xpos: =>
    x = @column * @width
    if @board.isEven(@row) then x else x + (@width * 0.5)

  ypos: =>
    @row * (@height * 0.75)

module.exports = HexagonalCell
