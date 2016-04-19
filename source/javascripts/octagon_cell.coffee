createjs = require 'createjs'
GameCell = require './game_cell'

class OctagonCell extends GameCell
  constructor: (stage, row, column, orient, height, width, board) ->
    @orient = orient
    super(stage, row, column, height, width, board)

  constructPoints: =>
    if @orient == @board.OCTAGON
      oneThird = @view.width / 3
      twoThirds = (@view.width * 2) / 3
      full = @view.width
      @p1 = {x: oneThird,  y: 0}
      @p2 = {x: twoThirds, y: 0}
      @p3 = {x: full,      y: oneThird}
      @p4 = {x: full,      y: twoThirds}
      @p5 = {x: twoThirds, y: full}
      @p6 = {x: oneThird,  y: full}
      @p7 = {x: 0,         y: twoThirds}
      @p8 = {x: 0,         y: oneThird}
    else if @orient == @board.SQUARE
      half = @view.width / 3
      full = (@view.width * 2) / 3
      @p1 = {x: half, y: 0}
      @p2 = {x: full, y: half}
      @p3 = {x: half, y: full}
      @p4 = {x: 0,    y: half}
    else
      console.log "Invalid orientation: " + @orient

  displayCell: =>
    @constructPoints()
    super()

  drawCell: =>
    if @orient == @board.OCTAGON
      @view.graphics.moveTo(@p1.x, @p1.y)
        .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y).lineTo(@p4.x, @p4.y)
        .lineTo(@p5.x, @p5.y).lineTo(@p6.x, @p6.y).lineTo(@p7.x, @p7.y)
        .lineTo(@p8.x, @p8.y).lineTo(@p1.x, @p1.y)
    else if @orient == @board.SQUARE
      @view.graphics.moveTo(@p1.x, @p1.y).lineTo(@p2.x, @p2.y)
        .lineTo(@p3.x, @p3.y).lineTo(@p4.x, @p4.y).lineTo(@p1.x, @p1.y)

  xpos: =>
    if @orient == @board.OCTAGON
      Math.floor(@column / 2) * @width
    else if @orient == @board.SQUARE
      Math.floor(@column / 2) * @width + (@width * (2/3))

  ypos: =>
    if @orient == @board.OCTAGON
      @row * @height
    else if @orient == @board.SQUARE
      @row * @height + (@height * (2/3))

  setTextPos: =>
    if @orient == @board.OCTAGON
      super()
    else if @orient == @board.SQUARE
      @text.x = @view.x + (@p1.x + @p2.x + @p3.x + @p4.x) / 4
      @text.y = @view.y + (@p1.y + @p2.y + @p3.y + @p4.y) / 4

module.exports = OctagonCell
