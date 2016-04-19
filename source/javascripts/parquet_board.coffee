createjs    = require 'createjs'
ParquetCell = require './parquet_cell'
GameBoard   = require './game_board'

class ParquetBoard extends GameBoard

  constructor: (stage, rows, columns, mines) ->
    @PARQUET_TOP = 0
    @PARQUET_BOTTOM = 1
    @PARQUET_LEFT = 2
    @PARQUET_RIGHT = 3
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
        if @orient(row, col) == @PARQUET_TOP ||
            @orient(row, col) == @PARQUET_BOTTOM
          width = @cellWidth
          height = @cellWidth / 2
        else
          width = @cellWidth / 2
          height = @cellWidth
        cell = new ParquetCell(@stage, row, col, @orient(row, col), height, width, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  addCellNeighbors: (row, col) =>
    if @cellTable[row][col].orient == @PARQUET_TOP
      @addColumns(@cellTable[row-1], [col-1,col,col+1,col+3], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-1,col+1,col+2], @cellTable[row][col])
    else if @cellTable[row][col].orient == @PARQUET_BOTTOM
      @addColumns(@cellTable[row], [col-2,col-1,col+1], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-3,col-1,col,col+1], @cellTable[row][col]) if row+1 < @rows
    else if @cellTable[row][col].orient == @PARQUET_LEFT
      @addColumns(@cellTable[row-1], [col-1,col+1], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-2,col-1,col+1], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-1,col], @cellTable[row][col]) if row+1 < @rows
    else if @cellTable[row][col].orient == @PARQUET_RIGHT
      @addColumns(@cellTable[row-1], [col,col+1], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-1,col+1,col+2], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-1,col+1], @cellTable[row][col]) if row+1 < @rows
    else
      console.log "invalid orientation: " + @cellTable[row][col].orient

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

  orient: (row, col) =>
    evenRow = [@PARQUET_TOP, @PARQUET_BOTTOM, @PARQUET_LEFT, @PARQUET_RIGHT]
    oddRow = [@PARQUET_LEFT, @PARQUET_RIGHT, @PARQUET_TOP, @PARQUET_BOTTOM]
    if @isEven(row) then evenRow[col % 4] else oddRow[col % 4]

module.exports = ParquetBoard
