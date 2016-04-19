createjs = require 'createjs'
GameCell = require './game_cell'

class HexagonalShiftedCell extends GameCell
  constructor: (stage, row, column, orient, height, width, board) ->
    @orient = orient
    super(stage, row, column, height, width, board)

  constructPoints: =>
    fourth = @view.width * 0.25
    half = @view.width * 0.5
    threeFourths = fourth * 3
    full = @view.width
    if @orient == @board.HEXAGON
      @p1 = {x: half, y: 0}
      @p2 = {x: full, y: fourth}
      @p3 = {x: full, y: threeFourths}
      @p4 = {x: half, y: full}
      @p5 = {x: 0,    y: threeFourths}
      @p6 = {x: 0,    y: fourth}
    else if @orient == @board.SQUARE
      @p1 = {x: half, y: 0}
      @p2 = {x: full, y: fourth}
      @p3 = {x: half, y: half}
      @p4 = {x: 0,    y: fourth}
    else
      console.log "Invalid orientation: " + @orient

  displayCell: =>
    @constructPoints()
    super()

  drawCell: =>
    if @orient == @board.HEXAGON
      @view.graphics.moveTo(@p1.x, @p1.y)
        .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y).lineTo(@p4.x, @p4.y)
        .lineTo(@p5.x, @p5.y).lineTo(@p6.x, @p6.y).lineTo(@p1.x, @p1.y)
    else if @orient == @board.SQUARE
      @view.graphics.moveTo(@p1.x, @p1.y).lineTo(@p2.x, @p2.y)
        .lineTo(@p3.x, @p3.y).lineTo(@p4.x, @p4.y).lineTo(@p1.x, @p1.y)

  xpos: =>
    @width * @column * 0.5

  ypos: =>
    if @orient == @board.HEXAGON
      @row * @height
    else if @orient == @board.SQUARE
      @row * @height + (@height * 0.75)

  setTextPos: =>
    if @orient == @board.HEXAGON
      super()
    else if @orient == @board.SQUARE
      @text.x = @view.x + (@p1.x + @p2.x + @p3.x + @p4.x) / 4
      @text.y = @view.y + (@p1.y + @p2.y + @p3.y + @p4.y) / 4

module.exports = HexagonalShiftedCell
