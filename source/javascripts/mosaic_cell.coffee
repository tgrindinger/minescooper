createjs = require 'createjs'
GameCell = require './game_cell'

class MosaicCell extends GameCell
  constructor: (stage, row, column, orient, height, width, board) ->
    @orient = orient
    super(stage, row, column, height, width, board)

  constructPoints: =>
    # hexagon (points up):
    # top legs: 12,6
    # side legs: 6,12
    # bottom legs: 12,6
    # bottom edge: 12,0

    # pentagon (points up):
    # top legs: 12,6
    # sides: 6,12
    # bottom: 12,0

    short = @width / 3
    long = short * 2
    if @board.isEven(@row)
      if @orient == @board.PENTAGON
        @p1 = {x: short,            y: 0}
        @p2 = {x: short + long,     y: 0}
        @p3 = {x: 2 * short + long, y: long}
        @p4 = {x: long,             y: long + short}
        @p5 = {x: 0,                y: long}
      else if @orient == @board.SEPTAGON
        @p1 = {x: 0,                y: short}
        @p2 = {x: long,             y: 0}
        @p3 = {x: 2 * long,         y: 0}
        @p4 = {x: 3 * long,         y: short}
        @p5 = {x: 2 * long + short, y: long + short}
        @p6 = {x: long + short,     y: long + 2 * short}
        @p7 = {x: short,            y: long + short}
      else
        console.log "Invalid orient: " + @orient
    else
      if @orient == @board.PENTAGON
        @p1 = {x: short,            y: 0}
        @p2 = {x: short + long,     y: 0}
        @p3 = {x: 2 * short + long, y: long}
        @p4 = {x: long,             y: long + short}
        @p5 = {x: 0,                y: long}
      else if @orient == @board.SEPTAGON
        @p1 = {x: 0,                y: long + short}
        @p2 = {x: short,            y: short}
        @p3 = {x: short + long,     y: 0}
        @p4 = {x: short + long * 2, y: short}
        @p5 = {x: 3 * long,         y: short + long}
        @p6 = {x: 2 * long,         y: long + short * 2}
        @p7 = {x: long,             y: long + short * 2}
      else
        console.log "Invalid orient: " + @orient

  displayCell: =>
    @constructPoints()
    super()

  drawCell: =>
    if @orient == @board.PENTAGON
      @view.graphics.moveTo(@p1.x, @p1.y)
        .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y)
        .lineTo(@p4.x, @p4.y).lineTo(@p5.x, @p5.y)
        .lineTo(@p1.x, @p1.y)
    else if @orient == @board.SEPTAGON
      @view.graphics.moveTo(@p1.x, @p1.y)
        .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y).lineTo(@p4.x, @p4.y)
        .lineTo(@p5.x, @p5.y).lineTo(@p6.x, @p6.y).lineTo(@p7.x, @p7.y)
        .lineTo(@p1.x, @p1.y)
    else
      console.log "Invalid orient: " + @orient

  xpos: =>
    start = @width / 2
    if @board.isEven(Math.floor(@row / 2))
      start += (@width / 3) + @column * @width - (@width / 3)
      if @orient == @board.PENTAGON
        start
      else if @orient == @board.SEPTAGON
        start - (@width / 6)
      else
        console.log "Invalid orient: " + @orient
    else
      start += @column * @width - (@width / 3)
      if @orient == @board.PENTAGON
        start
      else if @orient == @board.SEPTAGON
        start - (@width / 6)
      else
        console.log "Invalid orient: " + @orient

  ypos: =>
    if @orient == @board.PENTAGON
      @row * @height * 0.75 + @height * 0.25
    else if @orient == @board.SEPTAGON
      @row * @height * 0.75
    else
      console.log "Invalid orient: " + @orient

  setTextPos: =>
    if @orient == @board.PENTAGON
      @text.x = @view.x + (@p1.x + @p2.x + @p3.x + @p4.x + @p5.x) / 5
      @text.y = @view.y + (@p1.y + @p2.y + @p3.y + @p4.y + @p5.y) / 5
    else if @orient == @board.SEPTAGON
      @text.x = @view.x + (@p1.x + @p2.x + @p3.x + @p4.x + @p5.x + @p6.x + @p7.x) / 7
      @text.y = @view.y + (@p1.y + @p2.y + @p3.y + @p4.y + @p5.y + @p6.y + @p7.y) / 7

module.exports = MosaicCell
