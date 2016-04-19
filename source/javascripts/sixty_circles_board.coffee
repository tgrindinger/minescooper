createjs    = require 'createjs'
SixtyCirclesCell = require './sixty_circles_cell'
GameBoard   = require './game_board'

class SixtyCirclesBoard extends GameBoard

  constructor: (stage, rows, columns, mines) ->
    @CIRCLE = 0
    @IRREGULAR = 1
    super(stage, rows, columns, mines)

  setupBoard: =>
    super()
    #@drawBoard()

  drawBoard: =>
    @stage.removeAllChildren()
    @stage.clear()
    cell.initView() for cell in @cells when cell.orient == @IRREGULAR
    cell.initView() for cell in @cells when cell.orient == @CIRCLE
    @stage.update()

  generateCellList: =>
    @cellWidth  = @stage.canvas.width / (@columns * 0.75 + 0.3)
    @cellHeight = @cellWidth
    if @stage.canvas.height < @cellHeight * (@rows + 0.5)
      @cellHeight = @stage.canvas.height / (@rows + 0.5)
      @cellWidth = @cellHeight
    @cells      = []
    @cellTable  = []
    for row in [0...@rows] by 1
      @cellTable.push([])
      for col in [0...@columns] by 1
        cell = new SixtyCirclesCell(@stage, row, col, @orient(row, col), @cellHeight, @cellWidth, this)
        @cellTable[row].push(cell)
        @cells.push(cell)
    @addNeighbors()

  orient: (row, col) =>
    switch row % 3
      when 0
        if @isEven(col) then @CIRCLE else @IRREGULAR
      when 1
        if @isEven(col) then @IRREGULAR else @CIRCLE
      when 2
        @IRREGULAR

  addCellNeighbors: (row, col) =>
    if @isEven(col)
      @addColumns(@cellTable[row-1], [col-1,col,col+1], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-1,col+1], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col], @cellTable[row][col]) if row+1 < @rows
    else
      @addColumns(@cellTable[row-1], [col], @cellTable[row][col]) if row-1 >= 0
      @addColumns(@cellTable[row], [col-1,col+1], @cellTable[row][col])
      @addColumns(@cellTable[row+1], [col-1,col,col+1], @cellTable[row][col]) if row+1 < @rows

  addNeighbors: =>
    for row in [0...@cellTable.length] by 1
      for col in [0...@cellTable[row].length] by 1
        @addCellNeighbors(row, col)

module.exports = SixtyCirclesBoard
