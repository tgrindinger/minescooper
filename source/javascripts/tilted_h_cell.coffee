createjs = require 'createjs'
GameCell = require './game_cell'

class TiltedHCell extends GameCell
  constructor: (stage, row, column, orient, height, width, board) ->
    @orient = orient
    super(stage, row, column, height, width, board)

  constructPoints: =>
    halfWidth = @view.width * 0.5
    oneThird = @view.width / 3
    twoThirds = oneThird * 2
    switch @orient
      when @board.TOPLEFT
        @p1 = {x: 0,         y: 0}
        @p2 = {x: oneThird,  y: 0}
        @p3 = {x: twoThirds, y: oneThird}
        @p4 = {x: oneThird,  y: twoThirds}
        @p5 = {x: 0,         y: oneThird}
      when @board.TOPRIGHT
        @p1 = {x: oneThird,    y: 0}
        @p2 = {x: @view.width, y: 0}
        @p3 = {x: @view.width, y: twoThirds}
      when @board.BOTTOMLEFT
        @p1 = {x: 0,         y: oneThird}
        @p2 = {x: twoThirds, y: @view.height}
        @p3 = {x: 0,         y: @view.height}
      when @board.BOTTOMRIGHT
        @p1 = {x: @view.width, y: @view.height}
        @p2 = {x: twoThirds,   y: @view.height}
        @p3 = {x: oneThird,    y: twoThirds}
        @p4 = {x: twoThirds,   y: oneThird}
        @p5 = {x: @view.width, y: twoThirds}

  initTextSize: (height, width) =>
    if width > height then width / 2 else height / 2

  displayCell: =>
    @constructPoints()
    super()

  drawCell: =>
    if @orient == @board.TOPLEFT || @orient == @board.BOTTOMRIGHT
      @view.graphics.moveTo(@p1.x, @p1.y)
        .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y)
        .lineTo(@p4.x, @p4.y).lineTo(@p5.x, @p5.y).lineTo(@p1.x, @p1.y)
    else
      @view.graphics.moveTo(@p1.x, @p1.y)
        .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y).lineTo(@p1.x, @p1.y)

  xpos: =>
    Math.floor(@column / 4 + @board.ALPHA) * @width

  ypos: =>
    @row * @height

  setTextPos: =>
    if @orient == @board.TOPLEFT || @orient == @board.BOTTOMRIGHT
      @text.x = @view.x + (@p1.x + @p2.x + @p3.x + @p4.x + @p5.x) / 5
      @text.y = @view.y + (@p1.y + @p2.y + @p3.y + @p4.y + @p5.y) / 5
    else
      @text.x = @view.x + (@p1.x + @p2.x + @p3.x) / 3
      @text.y = @view.y + (@p1.y + @p2.y + @p3.y) / 3

module.exports = TiltedHCell
