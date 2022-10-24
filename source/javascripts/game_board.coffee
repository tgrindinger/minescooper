createjs    = require 'createjs'

class GameBoard
  constructor: (stage, rows, columns, mines) ->
    @stage = stage
    @rows = rows
    @columns = columns
    @mines = mines
    @ALPHA = 0.0001
    @guesses = 0
    @GUESS_COUNT = 10
    @nextGuess = @GUESS_COUNT
    @setupBoard()

  setupBoard: =>
    @stage.removeAllChildren()
    @stage.clear()
    document.getElementById("minesLeft").innerHTML = @mines
    #document.getElementById("guessesLeft").innerHTML = @guesses
    @revealedCells = 0
    @markedCells = 0
    @leftMouseDown = false
    @rightMouseDown = false
    @generate()
    @openEmptyCell()
    @stage.update()

  generateCellList: =>
    console.log "generateCellList should be overriden in child"

  generateHelper: =>
    @generateCellList()
    @placeMines()
    @populateCounts()
    @active = true
    element = document.getElementById("active")
    element.innerHTML = 'TRUE'
    element.style = "color:green"

  generate: =>
    @generateHelper()
    @generateHelper() until (c for c in @cells when c.isEmpty()).length > 0
    
  openEmptyCell: =>
    i = Math.floor(Math.random() * @cells.length + @ALPHA)
    i = Math.floor(Math.random() * @cells.length + @ALPHA) until @cells[i].isEmpty()
    @cells[i].open()
    @checkGame()

  loseGame: =>
    document.getElementById("active").innerHTML = @active = false
    @showMines()
    @stage.update()

  #useGuess: =>
  #  if @guesses == 0
  #    @loseGame()
  #  else
  #    @guesses--
  #    document.getElementById("guessesLeft").innerHTML = @guesses

  #incGuessCount: =>
  #  @nextGuess--
  #  while @nextGuess < 0
  #    @guesses++
  #    @GUESS_COUNT++
  #    @nextGuess += @GUESS_COUNT
  #  document.getElementById("guessesLeft").innerHTML = @guesses

  addColumns: (row, columns, cell) =>
    cell.addNeighbor(row[c]) for c in columns when c >= 0 && c < row.length

  populateCounts: =>
    c.countMinedNeighbors() for c in @cells
    #c.displayCount() for c in @cells
    #c.displayNeighbors() for c in @cells
    #c.displayColumn() for c in @cells

  placeMines: =>
    for i in [0...@mines] by 1
      i = Math.floor(Math.random() * @cells.length + @ALPHA)
      i = Math.floor(Math.random() * @cells.length + @ALPHA) while @cells[i].hasMine()
      @cells[i].placeMine()

  showMines: =>
    c.showMine() for c in @cells when c.hasMine()

  markAllCells: =>
    c.mark() for c in @cells when c.hasMine() && !c.isRevealedMine()

  checkGame: =>
    revCells = 0
    revCells++ for c in @cells when c.isRevealed()
    if revCells + @mines == @cells.length
      @active = false
      element = document.getElementById("active")
      element.innerHTML = "FALSE"
      element.style = "color:red"

      @markAllCells()

  minesLeft: =>
    numMarked = 0
    numMarked++ for c in @cells when c.isMarked() || c.isRevealedMine()
    @mines - numMarked

  #concealedCells: =>
  #  numRevCells = 0
  #  numRevCells++ for c in @cells when c.isRevealed() || c.isMarked()
  #  @cells.length - numRevCells

  isEven: (n) =>
    n % 2 == 0

  isOdd: (n) =>
    !isEven(n)

module.exports = GameBoard
