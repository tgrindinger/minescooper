createjs = require 'createjs'
GameCell = require './game_cell'

class SixtyCirclesCell extends GameCell
  constructor: (stage, row, column, orient, height, width, board) ->
    @orient = orient
    super(stage, row, column, height, width, board)

  displayCell: =>
    @constructPoints()
    super()

  constructPoints: =>
    oneFourth = @view.width * 0.25
    oneHalf = oneFourth * 2
    threeFourths = oneFourth * 3
    @p1 = {x: oneFourth, y: 0}
    @p2 = {x: threeFourths, y: 0}
    @p3 = {x: @view.width, y: oneHalf}
    @p4 = {x: threeFourths, y: @view.height}
    @p5 = {x: oneFourth, y: @view.height}
    @p6 = {x: 0, y: oneHalf}

  drawCell: =>
    oneFourth = @view.width / 4
    oneHalf = oneFourth * 2
    threeFourths = oneFourth * 3
    if @orient == @board.IRREGULAR
      @view.graphics.beginFill(@colors[@state])
        .moveTo(@p1.x, @p1.y)
        .lineTo(@p2.x, @p2.y)
        .lineTo(@p3.x, @p3.y)
        .lineTo(@p4.x, @p4.y)
        .lineTo(@p5.x, @p5.y)
        .lineTo(@p6.x, @p6.y)
        .lineTo(@p1.x, @p1.y)
    else if @orient == @board.CIRCLE
      @view.graphics.drawCircle(oneHalf, oneHalf, oneHalf * 1.1)

  addToStage: =>
    if @orient == @board.CIRCLE
      @stage.addChild(@view)
      @stage.addChild(@text)
    else
      @stage.addChildAt(@text, 0)
      @stage.addChildAt(@view, 0)

  xpos: =>
    @column * @width * 0.75

  ypos: =>
    if @board.isEven(@column) then @row * @height else @row * @height + (@height / 2)

module.exports = SixtyCirclesCell
