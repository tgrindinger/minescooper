createjs    = require 'createjs'
ClassicCell = require './classic_cell'
GameBoard   = require './game_board'

class ClassicBoard extends GameBoard
  constructor: (stage, rows, columns, mines) ->
    super(stage, rows, columns, mines)

  generateCellList: =>
    @cellWidth  = @stage.canvas.width / @columns
    @cellHeight = @stage.canvas.height / @rows
    if @cellWidth < @cellHeight
      @cellHeight = @cellWidth
    else
      @cellWidth = @cellHeight
    @cells      = []
    @cellTable  = []
    for row in [0...@rows] by 1
      @cellTable.push([])
      for col in [0...@columns] by 1
        cell = new ClassicCell(@stage, row, col, @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  addCellNeighbors: (row, col) =>
    for r in [Math.max(0, row-1)..Math.min(@rows-1,row+1)] by 1
      for c in [Math.max(0,col-1)..Math.min(@columns-1, col+1)] by 1
        @cellTable[row][col].addNeighbor(@cellTable[r][c])

  addNeighbors: =>
    for row in [0...@rows] by 1
      for col in [0...@columns] by 1
        @addCellNeighbors(row, col)

module.exports = ClassicBoard
