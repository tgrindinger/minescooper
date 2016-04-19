createjs = require 'createjs'
GameCell = require './game_cell'

class NinetyCirclesCell extends GameCell
  constructor: (stage, row, column, orient, height, width, board) ->
    @orient = orient
    super(stage, row, column, height, width, board)

  displayCell: =>
    if @orient == @board.CIRCLE
      super()
    else
      @drawCell()

  drawCell: =>
    oneFifth = @view.width / 5
    twoFifths = oneFifth * 2
    threeFifths = oneFifth * 3
    if @orient == @board.IRREGULAR
      @view.graphics.beginFill(@colors[@state])
        .drawRect(0, 0, @view.width, @view.height)
        .arc(0, 0, twoFifths, Math.PI / 2, 0, true).closePath()
        .moveTo(@view.width, 0)
        .arc(@view.width, 0, twoFifths, Math.PI, Math.PI / 2, true).closePath()
        .moveTo(@view.width, @view.height)
        .arc(@view.width, @view.height, twoFifths, (Math.PI * 3) / 2, Math.PI, true).closePath()
        .moveTo(0, @view.height)
        .arc(0, @view.height, twoFifths, Math.PI * 2, (Math.PI * 3) / 2, true).closePath()
        .endFill()
        .beginStroke("black")
        .moveTo(twoFifths, 0).lineTo(threeFifths, 0)
        .moveTo(@view.width, twoFifths).lineTo(@view.width, threeFifths)
        .moveTo(threeFifths, @view.height).lineTo(twoFifths, @view.height)
        .moveTo(0, twoFifths).lineTo(0, threeFifths)
        .endStroke()
        .beginStroke("black")
        .arc(0, 0, twoFifths, 0, Math.PI / 2)
        .endStroke()
        .beginStroke("black")
        .arc(@view.width, 0, twoFifths, Math.PI / 2, Math.PI)
        .endStroke()
        .beginStroke("black")
        .arc(@view.width, @view.height, twoFifths, Math.PI, (Math.PI * 3) / 2)
        .endStroke()
        .beginStroke("black")
        .arc(0, @view.height, twoFifths, (Math.PI * 3) / 2, Math.PI * 2)
        .endStroke()
    else if @orient == @board.CIRCLE
      @view.graphics.drawCircle(twoFifths, twoFifths, twoFifths)

  xpos: =>
    twoFifths = (@width * 2) / 5
    if @orient == @board.IRREGULAR
      twoFifths + Math.floor(@column / 2) * @width
    else if @orient == @board.CIRCLE
      Math.floor(@column / 2) * @width

  ypos: =>
    twoFifths = (@width / 5) * 2
    if @orient == @board.IRREGULAR
      twoFifths + @row * @height
    else if @orient == @board.CIRCLE
      @row * @height

  setTextPos: =>
    if @orient == @board.IRREGULAR
      super()
    else if @orient == @board.CIRCLE
      twoFifths = (@width * 2) / 5
      @text.x = @view.x + twoFifths
      @text.y = @view.y + twoFifths

module.exports = NinetyCirclesCell
