createjs    = require 'createjs'
HexagonalCell = require './hexagonal_cell'
GameBoard   = require './game_board'

class HexagonalBoard extends GameBoard

  constructor: (stage, rows, columns, mines) ->
    @OCTAGON = 0
    @SQUARE = 1
    super(stage, rows, columns, mines)

  generateCellList: =>
    @cellWidth  = @stage.canvas.width / (@columns + 0.5)
    @cellHeight = @cellWidth
    if @stage.canvas.height < @cellHeight * (@rows + (1 / 3)) * 0.75
      @cellHeight = @stage.canvas.height / ((@rows + (1 / 3)) * 0.75)
      @cellWidth = @cellHeight
    @cells      = []
    @cellTable  = []
    for row in [0...@rows] by 1
      @cellTable.push([])
      for col in [0...@columns] by 1
        cell = new HexagonalCell(@stage, row, col, @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  addCellNeighbors: (row, col) =>
    if @isEven(row)
      @addColumns(@cellTable[row-1], [col-1,col], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-1,col+1], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-1,col], @cellTable[row][col]) if row+1 < @rows
    else
      @addColumns(@cellTable[row-1], [col,col+1], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-1,col+1], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col,col+1], @cellTable[row][col]) if row+1 < @rows

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

module.exports = HexagonalBoard
