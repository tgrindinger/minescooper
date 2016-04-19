createjs    = require 'createjs'
MosaicCell = require './mosaic_cell'
GameBoard   = require './game_board'

class MosaicBoard extends GameBoard

  constructor: (stage, rows, columns, mines) ->
    @PENTAGON = 0
    @SEPTAGON = 1
    super(stage, rows, columns, mines)

  generateCellList: =>
    @cellWidth  = @stage.canvas.width / @columns
    @cellHeight = @cellWidth
    if @stage.canvas.height < @cellHeight * @rows
      @cellHeight = @stage.canvas.height / @rows
      @cellWidth = @cellHeight
    @cells      = []
    @cellTable  = []
    for row in [0...@rows] by 1
      @cellTable.push([])
      for col in [0...@columns] by 1
        cell = new MosaicCell(@stage, row, col, @orient(row, col), @location(col), @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  orient: (row, col) =>
    if @isEven(Math.floor(row / 4 + @ALPHA))
      if @isEven(Math.floor(row / 2 + @ALPHA)) then @SEPTAGON else @PENTAGON
    else
      if @isEven(Math.floor(row / 2 + @ALPHA)) then @PENTAGON else @SEPTAGON

  addCellNeighbors: (row, col) =>
    if @cellTable[row][col].orient == @PENTAGON
      if @isEven(Math.floor(row / 2 + @ALPHA))
        @addColumns(@cellTable[row-1], [col-3,col-1,col,col+1,col+2], @cellTable[row][col]) if row-1 >= 0
        @addColumns(@cellTable[row], [col-3,col-2,col-1,col+1,col+2], @cellTable[row][col])
        @addColumns(@cellTable[row+1], [col-3,col-2,col-1,col], @cellTable[row][col]) if row+1 < @rows
      else
        @addColumns(@cellTable[row-1], [col,col+1,col+2,col+3], @cellTable[row][col]) if row-1 >= 0
        @addColumns(@cellTable[row], [col-2,col-1,col+1,col+2,col+3], @cellTable[row][col])
        @addColumns(@cellTable[row+1], [col-2,col-1,col,col+1,col+3], @cellTable[row][col]) if row+1 < @rows
    else if @cellTable[row][col].orient == @SEPTAGON
      if @isEven(Math.floor(row / 2 + @ALPHA))
        @addColumns(@cellTable[row-1], [col-3,col-2,col-1,col,col+1], @cellTable[row][col]) if row-1 >= 0
        @addColumns(@cellTable[row], [col-3,col-2,col-1,col+1,col+2], @cellTable[row][col])
        @addColumns(@cellTable[row+1], [col-1,col,col+1,col+2], @cellTable[row][col]) if row+1 < @rows
      else
        @addColumns(@cellTable[row-1], [col-2,col-1,col,col+1], @cellTable[row][col]) if row-1 >= 0
        @addColumns(@cellTable[row], [col-2,col-1,col+1,col+2,col+3], @cellTable[row][col])
        @addColumns(@cellTable[row+1], [col-1,col,col+1,col+2,col+3], @cellTable[row][col]) if row+1 < @rows
    else
      console.log "Invalid orient: " + @cellTable[row][col].orient

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

module.exports = MosaicBoard
