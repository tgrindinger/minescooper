createjs = require 'createjs'

class GameCell

  constructor: (stage, row, column, height, width, board) ->
    @CONCEALED = 0
    @REVEALED = 1
    @MINE = 2
    @MARKED = 3

    @stage = stage
    @row = row
    @column = column
    @height = height
    @width = width
    @board = board

    @state = @CONCEALED
    @count = 0
    @neighbors = []

    @initColors()
    @initView()
    @initText()

  initColors: =>
    @colors = []
    @colors[@CONCEALED] = "#eeeeee"
    @colors[@REVEALED]  = "#cccccc"
    @colors[@MINE]      = "#ff0000"
    @colors[@MARKED]    = "#00ff00"
    
  initView: =>
    @view = new createjs.Shape
    @viewDims()
    @displayCell()
    @view.addEventListener("click", @shapeClick)
    @view.addEventListener("dblclick", @shapeDblClick)
    @view.addEventListener("mousedown", @shapeMouseDown)
    @view.addEventListener("pressup", @shapeMouseUp)
    @stage.addChild(@view)

  initText: =>
    textSize = @initTextSize(@height, @width)
    @text = new createjs.Text("", "bold " + Math.floor(textSize / 2 + @board.ALPHA) + "px Arial", "#000000")
    @text.textAlign = "center"
    @text.textBaseline = "middle"
    @setTextPos()
    @stage.addChild(@text)

  initTextSize: (height, width) =>
    if width > height then width else height

  setTextPos: =>
    @text.x = @view.x + (@view.width * 0.5)
    @text.y = @view.y + (@view.height * 0.5)

  viewDims: =>
    @view.x = @xpos()
    @view.y = @ypos()
    @view.width = @width
    @view.height = @height

  displayCell: =>
    @view.graphics.beginFill("rgba(0,0,0,0)")
    @view.graphics.drawRect(0, 0, @view.width, @view.height)
    @view.graphics.beginFill(@colors[@state])
    @drawCell()
    @view.graphics.beginStroke("black")
    @drawCell()
    @view.graphics.endStroke()

  displayCount: =>
    @text.text = @count

  displayColumn: =>
    @text.text = @column

  displayNeighbors: =>
    @text.text = @neighbors.length

  shapeClick: (event) =>
    if @board.active
      if event.nativeEvent.button == 2
        @toggleMark()
        @displayCell()
      else
        @open()
      @stage.update()

  handleOpenMarkedNeighbors: =>
    if @markedNeighbors() + @revealedMineNeighbors() == @count
      #if @hasOpenNeighborMine()
      #  @board.loseGame()
      #else
      @openUnmarkedNeighbors()
      @stage.update()
      @board.checkGame()
  
  shapeDblClick: (event) =>
    if @board.active
      @handleOpenMarkedNeighbors()

  shapeMouseDown: (event) =>
    if @board.active
      if event.nativeEvent.button == 2
        @board.rightMouseDown = true
      else
        @board.leftMouseDown = true
    else if event.nativeEvent.button == 2
      @board.setupBoard()

  shapeMouseUp: (event) =>
    if @board.active && @board.leftMouseDown && @board.rightMouseDown
      @handleOpenMarkedNeighbors()
    if event.nativeEvent.button == 2
      @board.rightMouseDown = false
    else
      @board.leftMouseDown = false

  placeMine: =>
    @count = -1

  countMinedNeighbors: =>
    @count = @minedNeighbors() if @count == 0

  minedNeighbors: =>
    (c for c in @neighbors when c.hasMine()).length

  markedNeighbors: =>
    (c for c in @neighbors when c.isMarked()).length

  revealedMineNeighbors: =>
    (c for c in @neighbors when c.isRevealedMine()).length

  showMine: =>
    @state = @MINE if @state != @REVEALED && @count == -1
    @text.text = "*"
    document.getElementById("minesLeft").innerHTML = @board.minesLeft()
    @displayCell()
    c.open() for c in @neighbors when !(c.isMarked() || c.isRevealedMine())

  toggleMark: =>
    if @state == @CONCEALED
      @mark()
    else if @state == @MARKED
      @unmark()
  
  unmark: =>
    @state = @CONCEALED if @state == @MARKED
    @text.text = ""
    
  mark: =>
    @state = @MARKED if @state == @CONCEALED
    @text.text = "M"
    document.getElementById("minesLeft").innerHTML = @board.minesLeft()
    @displayCell()

  openUnmarkedNeighbors: =>
    (c.open() unless c.isMarked() || c.isRevealedMine()) for c in @neighbors

  hasOpenNeighborMine: =>
    (c for c in @neighbors when c.hasMine() && !c.isMarked()).length > 0

  hasOpenMine: =>
    @state == @CONCEALED && @count == -1

  open: =>
    return if @state == @REVEALED || @state == @MARKED
    if @count == -1
      #if @board.guesses > 0
      #  @mark()
      #@board.useGuess()
      @showMine()
    else
      @state = @REVEALED
      if @count == 0
        @text.text = ""
        c.open() for c in @neighbors
      else
        @text.text = @count
        #@board.incGuessCount()
      @board.checkGame()
    @displayCell()

  hasMine: =>
    @count == -1

  isEmpty: =>
    @count == 0

  isRevealed: =>
    @state == @REVEALED

  isMarked: =>
    @state == @MARKED

  isRevealedMine: =>
    @state == @MINE

  addNeighbor: (cell) =>
    @neighbors.push(cell) unless cell.row == @row && cell.column == @column

module.exports = GameCell
