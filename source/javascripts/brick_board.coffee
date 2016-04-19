createjs    = require 'createjs'
BrickCell = require './brick_cell'
GameBoard   = require './game_board'

class BrickBoard extends GameBoard
  constructor: (stage, rows, columns, mines) ->
    super(stage, rows, columns, mines)

  generateCellList: =>
    @cellWidth  = @stage.canvas.width / (@columns + 0.5)
    @cellHeight = @cellWidth / 2
    if @stage.canvas.height < @cellHeight * @rows
      @cellHeight = @stage.canvas.height / @rows
      @cellWidth = @cellHeight * 2
    @cells      = []
    @cellTable  = []
    for row in [0...@rows] by 1
      @cellTable.push([])
      for col in [0...@columns] by 1
        cell = new BrickCell(@stage, row, col, @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  addCellNeighbors: (row, col) =>
    if @isEven(row)
      if row > 0
        for c in [Math.max(0,col-1)..col] by 1
          @cellTable[row][col].addNeighbor(@cellTable[row-1][c])
      for c in [Math.max(0,col-1)..Math.min(col+1,@columns-1)] by 1 when c != col
        @cellTable[row][col].addNeighbor(@cellTable[row][c])
      if row < @rows - 1
        for c in [Math.max(0,col-1)..col] by 1
          @cellTable[row][col].addNeighbor(@cellTable[row+1][c])
    else
      if row > 0
        for c in [col..Math.min(col+1,@columns-1)] by 1
          @cellTable[row][col].addNeighbor(@cellTable[row-1][c])
      for c in [Math.max(0,col-1)..Math.min(col+1,@columns-1)] by 1 when c != col
        @cellTable[row][col].addNeighbor(@cellTable[row][c])
      if row < @rows - 1
        for c in [col..Math.min(col+1,@columns-1)] by 1
          @cellTable[row][col].addNeighbor(@cellTable[row+1][c])

  addNeighbors: =>
    for row in [0...@rows] by 1
      for col in [0...@columns] by 1
        @addCellNeighbors(row, col)

module.exports = BrickBoard
