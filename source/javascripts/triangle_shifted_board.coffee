createjs    = require 'createjs'
TriangleShiftedCell = require './triangle_shifted_cell'
GameBoard   = require './game_board'

class TriangleShiftedBoard extends GameBoard

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
        cell = new TriangleShiftedCell(@stage, row, col, @orient(col), @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  orient: (col) =>
    if @isEven(col) then @POINTS_UP else @POINTS_DOWN

  addCellNeighbors: (row, col) =>
    aboveCount = if row > 0 then @cellTable[row-1].length else null
    rowCount = @cellTable[row].length
    belowCount = if row < @cellTable.length - 1 then @cellTable[row+1].length else null
    if @cellTable[row][col].orient == @POINTS_UP
      @cellTable[row][col].addNeighbor(@cellTable[row-1][col]) if aboveCount
      for c in [Math.max(0, col-2)..Math.min(col+2, rowCount-1)] by 1
        @cellTable[row][col].addNeighbor(@cellTable[row][c])
      if belowCount
        for c in [Math.max(0, col-1)..Math.min(col+1, belowCount-1)] by 1
          @cellTable[row][col].addNeighbor(@cellTable[row+1][c])
    else if @cellTable[row][col].orient == @POINTS_DOWN
      if aboveCount
        for c in [Math.max(0, col-1)..Math.min(col+1, aboveCount-1)] by 1
          @cellTable[row][col].addNeighbor(@cellTable[row-1][c])
      for c in [Math.max(0, col-2)..Math.min(col+2, rowCount-1)] by 1
        @cellTable[row][col].addNeighbor(@cellTable[row][c])
      @cellTable[row][col].addNeighbor(@cellTable[row+1][col]) if belowCount
    else
      console.log "invalid orientation: " + @cellTable[row][col].orient

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

module.exports = TriangleShiftedBoard
