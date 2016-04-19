createjs    = require 'createjs'
TiltedHCell = require './tilted_h_cell'
GameBoard   = require './game_board'

class TiltedHBoard extends GameBoard

  constructor: (stage, rows, columns, mines) ->
    @TOPLEFT = 0
    @TOPRIGHT = 1
    @BOTTOMLEFT = 2
    @BOTTOMRIGHT = 3
    super(stage, rows, columns, mines)

  generateCellList: =>
    @cellWidth  = @stage.canvas.width / (@columns * 0.25)
    @cellHeight = @cellWidth
    if @stage.canvas.height < @cellHeight * @rows
      @cellHeight = @stage.canvas.height / @rows
      @cellWidth = @cellHeight
    @cells      = []
    @cellTable  = []
    for row in [0...@rows] by 1
      @cellTable.push([])
      for col in [0...@columns] by 1
        cell = new TiltedHCell(@stage, row, col, @orient(col), @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  orient: (col) =>
    col % 4

  addCellNeighbors: (row, col) =>
    if @cellTable[row][col].orient == @TOPLEFT
      @addColumns(@cellTable[row-1], [col-1,col+2], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-3,col+1,col+2,col+3], @cellTable[row][col])
    else if @cellTable[row][col].orient == @TOPRIGHT
      @addColumns(@cellTable[row-1], [col+1,col+2,col+5], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-1,col+2,col+3,col+5], @cellTable[row][col])
    else if @cellTable[row][col].orient == @BOTTOMLEFT
      @addColumns(@cellTable[row], [col-5,col-3,col-2,col+1], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-5,col-2,col-1], @cellTable[row][col]) if row+1 < @rows
    else if @cellTable[row][col].orient == @BOTTOMRIGHT
      @addColumns(@cellTable[row], [col-3,col-2,col-1,col+3], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-2,col+1], @cellTable[row][col]) if row+1 < @rows
    else
      console.log "invalid orientation: " + @cellTable[row][col].orient

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

module.exports = TiltedHBoard
