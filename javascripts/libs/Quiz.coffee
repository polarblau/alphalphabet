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
    @possibilities = @pool.sort(@_byRandom).slice(start, start + @possibilitiesCount)
    @pick()
    @possibilities
    
  pick: ->
    @correct = @possibilities[Math.floor(Math.random() * @possibilities.length)]
    
  check: (suggestion) ->
    @correct == suggestion
    
  #
  
  # cheap shuffle
  _byRandom: ->
    Math.round(Math.random()) - 0.5
    
    
window.Quiz = Quiz