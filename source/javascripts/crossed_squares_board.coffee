createjs    = require 'createjs'
CrossedSquaresCell = require './crossed_squares_cell'
GameBoard   = require './game_board'

class CrossedSquaresBoard extends GameBoard

  constructor: (stage, rows, columns, mines) ->
    @SLASH = 0
    @BACKSLASH = 1
    @BORDERS_BOTTOM = 0
    @BORDERS_TOP = 1
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
      for col in [0...@columns * 2] by 1
        cell = new CrossedSquaresCell(@stage, row, col, @orient(row, col), @location(col), @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  orient: (row, col) =>
    if @isEven(Math.floor(col / 2 + @ALPHA)) == @isEven(row) then @BACKSLASH else @SLASH

  location: (col) =>
    if @isEven(col) then @BORDERS_BOTTOM else @BORDERS_TOP

  addCellNeighbors: (row, col) =>
    if @cellTable[row][col].orient == @SLASH
      if @cellTable[row][col].location == @BORDERS_TOP
        @addColumns(@cellTable[row-1], [col-3,col-1,col,col+1,col+2], @cellTable[row][col]) if row-1 >= 0
        @addColumns(@cellTable[row], [col-3,col-2,col-1,col+1,col+2], @cellTable[row][col])
        @addColumns(@cellTable[row+1], [col-3,col-2,col-1,col], @cellTable[row][col]) if row+1 < @rows
      else if @cellTable[row][col].location == @BORDERS_BOTTOM
        @addColumns(@cellTable[row-1], [col,col+1,col+2,col+3], @cellTable[row][col]) if row-1 >= 0
        @addColumns(@cellTable[row], [col-2,col-1,col+1,col+2,col+3], @cellTable[row][col])
        @addColumns(@cellTable[row+1], [col-2,col-1,col,col+1,col+3], @cellTable[row][col]) if row+1 < @rows
      else
        console.log "Invalid location: " + @cellTable[row][col].location
    else if @cellTable[row][col].orient == @BACKSLASH
      if @cellTable[row][col].location == @BORDERS_TOP
        @addColumns(@cellTable[row-1], [col-3,col-2,col-1,col,col+1], @cellTable[row][col]) if row-1 >= 0
        @addColumns(@cellTable[row], [col-3,col-2,col-1,col+1,col+2], @cellTable[row][col])
        @addColumns(@cellTable[row+1], [col-1,col,col+1,col+2], @cellTable[row][col]) if row+1 < @rows
      else if @cellTable[row][col].location == @BORDERS_BOTTOM
        @addColumns(@cellTable[row-1], [col-2,col-1,col,col+1], @cellTable[row][col]) if row-1 >= 0
        @addColumns(@cellTable[row], [col-2,col-1,col+1,col+2,col+3], @cellTable[row][col])
        @addColumns(@cellTable[row+1], [col-1,col,col+1,col+2,col+3], @cellTable[row][col]) if row+1 < @rows
      else
        console.log "Invalid location: " + @cellTable[row][col].location
    else
      console.log "Invalid location: " + @cellTable[row][col].orient

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

module.exports = CrossedSquaresBoard
