createjs = require 'createjs'
GameCell = require './game_cell'

class CrossedSquaresCell extends GameCell
  constructor: (stage, row, column, orient, location, height, width, board) ->
    @orient = orient
    @location = location
    super(stage, row, column, height, width, board)

  constructPoints: =>
    if @orient == @board.SLASH
      if @location == @board.BORDERS_BOTTOM
        @p1 = {x: 0,           y: @view.height}
        @p2 = {x: @view.width, y: 0}
        @p3 = {x: @view.width, y: @view.height}
      else if @location == @board.BORDERS_TOP
        @p1 = {x: 0,           y: @view.height}
        @p2 = {x: 0,           y: 0}
        @p3 = {x: @view.width, y: 0}
      else
        console.log "Invalid location: " + @location
    else if @orient == @board.BACKSLASH
      if @location == @board.BORDERS_BOTTOM
        @p1 = {x: 0,           y: 0}
        @p2 = {x: @view.width, y: @view.height}
        @p3 = {x: 0,           y: @view.height}
      else if @location == @board.BORDERS_TOP
        @p1 = {x: 0,           y: 0}
        @p2 = {x: @view.width, y: 0}
        @p3 = {x: @view.width, y: @view.height}
      else
        console.log "Invalid location: " + @location
    else
      console.log "Invalid orientation: " + @orient

  displayCell: =>
    @constructPoints()
    super()

  drawCell: =>
    @view.graphics.moveTo(@p1.x, @p1.y)
      .lineTo(@p2.x, @p2.y).lineTo(@p3.x, @p3.y).lineTo(@p1.x, @p1.y)

  xpos: =>
    Math.floor(@column / 2) * @width

  ypos: =>
    @row * @height

  setTextPos: =>
    @text.x = @view.x + (@p1.x + @p2.x + @p3.x) / 3
    @text.y = @view.y + (@p1.y + @p2.y + @p3.y) / 3

module.exports = CrossedSquaresCell
