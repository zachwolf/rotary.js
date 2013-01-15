do ->
  lastTime = 0

  for vendor in ['ms', 'moz', 'webkit', 'o']
    break if window.requestAnimationFrame

    window.requestAnimationFrame  = window[vendors[x] + 'RequestAnimationFrame'];
    window.cancelAnimationFrame   = window[vendors[x] + 'CancelAnimationFrame'] or window[vendors[x] + 'CancelRequestAnimationFrame'];

  if !window.requestAnimationFrame
    window.requestAnimationFrame = (callback, element) ->
      currTime = new Date().getTime()
      timeToCall = Math.max( 0, 16 - (currTime - lastTime))
      id = window.setTimeout callback(currTime + timeToCall), timeToCall
      lastTime = currTime + timeToCall
      id

  if !window.cancelAnimationFrame
    window.cancelAnimationFrame = (id) ->
      clearTimeout id
