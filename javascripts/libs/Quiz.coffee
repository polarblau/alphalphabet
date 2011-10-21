class Quiz
  
  pool              : []
  possibilitiesCount: 0
  possibilities     : []
  correct           : null
  
  constructor: (options) ->
    for key, value of options
      @[key] = value if @[key]?
  
  ask: ->
    start = Math.floor(Math.random() * (@pool.length - @possibilitiesCount))
    @possibilities = @pool.slice(start, start + @possibilitiesCount)
    @pick()
    @possibilities
    
  pick: ->
    @correct = @possibilities[Math.floor(Math.random() * @possibilities.length)]
    
  check: (suggestion) ->
    @correct == suggestion
    
    
window.Quiz = Quiz