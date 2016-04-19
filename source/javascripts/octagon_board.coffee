createjs    = require 'createjs'
OctagonCell = require './octagon_cell'
GameBoard   = require './game_board'

class OctagonBoard extends GameBoard

  constructor: (stage, rows, columns, mines) ->
    @OCTAGON = 0
    @SQUARE = 1
    super(stage, rows, columns, mines)

  generateCellList: =>
    @cellWidth  = @stage.canvas.width / ((@columns / 2) + 1)
    @cellHeight = @cellWidth
    if @stage.canvas.height < @cellHeight * (@rows + (1/3))
      @cellHeight = @stage.canvas.height / (@rows + (1/3))
      @cellWidth = @cellHeight
    @cells      = []
    @cellTable  = []
    for row in [0...@rows] by 1
      @cellTable.push([])
      for col in [0...@columns] by 1
        cell = new OctagonCell(@stage, row, col, @orient(col), @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  orient: (col) =>
    if @isEven(col) then @OCTAGON else @SQUARE

  addCellNeighbors: (row, col) =>
    if @cellTable[row][col].orient == @OCTAGON
      @addColumns(@cellTable[row-1], [col-1,col,col+1], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-2,col-1,col+1,col+2], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col], @cellTable[row][col]) if row+1 < @rows
    else if @cellTable[row][col].orient == @SQUARE
      @addColumns(@cellTable[row], [col-1,col+1], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-1,col+1], @cellTable[row][col]) if row+1 < @rows
    else
      console.log "invalid orientation: " + @cellTable[row][col].orient

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

module.exports = OctagonBoard
