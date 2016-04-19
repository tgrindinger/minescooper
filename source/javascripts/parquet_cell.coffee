createjs = require 'createjs'
GameCell = require './game_cell'

class ParquetCell extends GameCell
  constructor: (stage, row, column, orient, height, width, board) ->
    @orient = orient
    super(stage, row, column, height, width, board)

  drawCell: =>
    @view.graphics.drawRect(0, 0, @view.width, @view.height)

  xpos: =>
    switch @orient
      when @board.PARQUET_TOP
        (@column / 2) * @width
      when @board.PARQUET_BOTTOM
        ((@column - 1) / 2) * @width
      when @board.PARQUET_LEFT
        (@column / 2) * @height
      when @board.PARQUET_RIGHT
        ((@column / 2) * @height)
      else
        console.log "xpos: invalid orientation: " + @orient

  ypos: =>
    switch @orient
      when @board.PARQUET_TOP
        @row * @width
      when @board.PARQUET_BOTTOM
        (@row * @width) + @height
      when @board.PARQUET_LEFT
        @row * @height
      when @board.PARQUET_RIGHT
        @row * @height
      else
        console.log "ypos: invalid orientation: " + @orient

module.exports = ParquetCell
