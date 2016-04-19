createjs = require 'createjs'
ClassicBoard = require './classic_board'
HexagonalBoard = require './hexagonal_board'
HexagonalShiftedBoard = require './hexagonal_shifted_board'
OctagonBoard = require './octagon_board'
TriangleBoard = require './triangle_board'
TriangleShiftedBoard = require './triangle_shifted_board'
ParquetBoard = require './parquet_board'
#ParquetFishboneBoard = require './parquet_fishbone_board'
#FloorBoard = require './floor_board'
BrickBoard = require './brick_board'
CrossedSquaresBoard = require './crossed_squares_board'
SixtyCirclesBoard = require './sixty_circles_board'
NinetyCirclesBoard = require './ninety_circles_board'
#PentagonalBoard = require './pentagonal_board'
#MosaicBoard = require './mosaic_board'
TiltedHBoard = require './tilted_h_board'
#RealPentagonalBoard = require './real_pentagonal_board'
#DiamondBoard = require './diamond_board'

class MineGame
  constructor: ->
    $("body").on("contextmenu", "#gameCanvas", (e) -> false)
    @canvas = document.getElementById("gameCanvas")
    @rows = document.getElementById("rows")
    @columns = document.getElementById("columns")
    @mines = document.getElementById("mines")
    @boardSelect = document.getElementById("board")
    @canvas.width = 800
    @canvas.height = 600
    @stage = new createjs.Stage "gameCanvas"
    @stage.snapToPixelsEnabled = true
    @canvas.mineGame = this
    @restart()

  restart: (autoPopulate = false) =>
    @suggest() if autoPopulate
    rows = parseInt(@rows.value)
    columns = parseInt(@columns.value)
    mines = parseInt(@mines.value)
    boards =
      classic: ClassicBoard
      brick: BrickBoard
      parquet: ParquetBoard
      triangle_shifted: TriangleShiftedBoard
      triangle: TriangleBoard
      crossed_squares: CrossedSquaresBoard
      octagon: OctagonBoard
      ninety_circles: NinetyCirclesBoard
      sixty_circles: SixtyCirclesBoard
      hexagonal: HexagonalBoard
      hexagonal_shifted: HexagonalShiftedBoard
      tilted_h: TiltedHBoard
    @board = new boards[@boardSelect.value](@stage, rows, columns, mines)

  suggest: =>
    ROWS = 0
    COLUMNS = 1
    MINES = 2
    params =
      classic: [16, 30, 99]
      brick: [22, 22, 99]
      parquet: [11, 22, 80]
      triangle_shifted: [12, 40, 99]
      triangle: [12, 35, 70]
      crossed_squares: [11, 22, 60]
      octagon: [12, 41, 80]
      ninety_circles: [12, 41, 80]
      sixty_circles: [15, 33, 90]
      hexagonal: [15, 20, 95]
      hexagonal_shifted: [15, 40, 95]
      tilted_h: [8, 60, 95]
    @rows.value = params[@boardSelect.value][ROWS]
    @columns.value = params[@boardSelect.value][COLUMNS]
    @mines.value = params[@boardSelect.value][MINES]
    
  nextBoard: =>
    boardSelect = document.getElementById('board')
    boardSelect.selectedIndex = (boardSelect.selectedIndex + 1) % boardSelect.options.length
    boardSelect.onchange()

new MineGame
