createjs    = require 'createjs'
TriangleCell = require './triangle_cell'
GameBoard   = require './game_board'

class TriangleBoard extends GameBoard

  constructor: (stage, rows, columns, mines) ->
    @POINTS_UP = 0
    @POINTS_DOWN = 1
    super(stage, rows, columns, mines)

  generateCellList: =>
    @cellWidth  = @stage.canvas.width / ((@columns + 1) * 0.5)
    @cellHeight = @cellWidth
    if @stage.canvas.height < @cellHeight * @rows
      @cellHeight = @stage.canvas.height / @rows
      @cellWidth = @cellHeight
    @cells      = []
    @cellTable  = []
    for row in [0...@rows] by 1
      @cellTable.push([])
      for col in [0...@columns] by 1
        cell = new TriangleCell(@stage, row, col, @orient(row, col), @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  orient: (row, col) =>
    if @isEven(row) == @isEven(col) then @POINTS_DOWN else @POINTS_UP

  addCellNeighbors: (row, col) =>
    if @cellTable[row][col].orient == @POINTS_UP
      @addColumns(@cellTable[row-1], [col-1,col,col+1], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-2,col-1,col+1,col+2], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-2,col-1,col,col+1,col+2], @cellTable[row][col]) if row+1 < @rows
    else if @cellTable[row][col].orient == @POINTS_DOWN
      @addColumns(@cellTable[row-1], [col-2,col-1,col,col+1,col+2], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-2,col-1,col+1,col+2], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-1,col,col+1], @cellTable[row][col]) if row+1 < @rows
    else
      console.log "invalid orientation: " + @cellTable[row][col].orient

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

module.exports = TriangleBoard
