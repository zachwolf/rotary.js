# @codekit-prepend "requestAnimation.coffee";

canvas  = null
context = null
toggle  = null

cW = null
cX = null
cH = null
cY = null

###

            |
            |
    1       |      2
            |
            |
--------[cX, cY]---------
            |
            |
    4       |      3
            |
            |
###

topLeft = "1"
topRight = "2"
bottomRight = "3"
bottomLeft = "4"

mouseX  = 100
mouseY  = 100

animation = null


$canvas = $("#triangles")
$window = $(window)

animate = ->
  animation = window.requestAnimationFrame( animate )
  # draw()
  track()

draw = ->

  time = new Date().getTime() * 0.002
  x = Math.sin( time ) * 192 + 256
  y = Math.cos( time * 0.9 ) * 192 + 256
  toggle = !toggle

  if context
    context.fillStyle = if toggle then 'rgb(200,200,20)' else 'rgb(20,20,200)'
    context.beginPath()
    context.arc( x, y, 10, 0, Math.PI * 2, true )
    context.closePath()
    context.fill()

  return

track = ->

  quadrant = null

  if mouseX < cX
    if mouseY < cY
      quadrant = topLeft
    else # mouseY > cY
      quadrant = bottomLeft
  else # mouseX < cX
    if mouseY < cY
      quadrant = topRight
    else # mouseY > cY
      quadrant = bottomRight

  console.log quadrant

  context.fillStyle = "rgba(255, 255, 255, 1)"
  context.fillRect 0, 0, cW, cH

  # context.beginPath()
  # context.moveTo cX, cY
  # context.lineTo cX, mouseY
  # context.lineTo mouseX, cY
  # context.closePath()
  # context.strokeStyle = '#666666';
  # context.stroke()

  
  context.fillStyle = "#000000"
  context.font = "10px sans-serif"

  context.fillText "90°", cX - 3, mouseY

  # context.fillText "hello°", mouseX, mouseY - 3

  context.fillText "l: #{Math.abs cX - mouseX}px", mouseX + ((cX - mouseX) / 2), mouseY - 3

  context.fillText "h: #{Math.abs cY - mouseY}px", cX + 3, mouseY + ((cY - mouseY) / 2)

  context.beginPath()
  context.moveTo cX, cY
  context.lineTo mouseX, mouseY
  context.lineTo cX, mouseY
  context.closePath()
  context.strokeStyle = '#000000';
  context.stroke()



init = do ->

  canvas = $canvas[0]
  canvas.width = $canvas.width()
  canvas.height = $canvas.height()

  context = canvas.getContext '2d'

  cW = canvas.width
  cX = cW / 2 # centerX
  cH = canvas.height
  cY = cH / 2 # centerY

$canvas
  .on "mousedown", ->
    animate()    
    $window
      .on "mousemove", (e) ->
        mouseX  = e.clientX
        mouseY  = e.clientY
      .on "mouseup", ->
        window.cancelAnimationFrame animation
        $window.off "mousemove"
