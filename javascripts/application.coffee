addAudio = (id, file) ->
  $track          = $("<audio/>")
    .attr
      "id"      : "suggestion-#{id}"
      "autoplay": false
      "preload" : true
  removeListener = -> $track.unbind('canplaythrough')
  $track.bind('canplaythrough', removeListener)
  $("body").append($track)
  $track.attr("src", file)
  $track.trigger("play")
  pauseTrack = => $track.trigger("pause")
  setTimeout(pauseTrack, 1)
  
letterClickHandler = ->
  letter = $(@).data("value")
  $("#suggestion-#{letter}").trigger("play")
  refresh = -> $(document).trigger("refreshquiz")
  remove = =>
    $(@)
      .removeClass("bounceInDown")
      .addClass("bounceOutDown")
    unless $("#quiz").find(".bounceInDown").length
      setTimeout(refresh, 1000)
  setTimeout(remove, 1000)
  

POOL = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ")

$ ->  
                
  $quiz         = $("#quiz")
  $settings     = $("#settings")
  
  _.each POOL, (letter) ->
    addAudio(letter, "audio/#{letter}.aiff")
                
  quizOptions   = 
    pool: POOL
    possibilitiesCount: 3
                
  quiz          = new Quiz(quizOptions)
  
  $(document).bind "refreshquiz", =>
    
    $quiz.empty()
         
    possibilities = quiz.ask()
  
    margin        = 50
    width         = (1024 - margin * 2)  / possibilities.length

    _.each possibilities, (letter, i) ->
      rotation = Math.random() * 30 - 15
      $letter = $("<span/>", { 
        "class": "suggestion animated"
        "text" : letter
        "data" : 
          "value": letter.toUpperCase()
        "css"  :
          "fontSize": "#{width * 0.8}px"
          "left"    : margin + i * width
          "top"     : 500 - width
          "width"   : "#{width}px"
          "-webkit-transform" : "rotate(#{rotation}deg)"
      })
      .appendTo($quiz)
      bounce = -> 
        $letter.addClass("bounceInDown")
      setTimeout(bounce, Math.random() * 500 + 150 * i)
      $letter.bind("click", letterClickHandler)
  #
  
  $(document).trigger("refreshquiz")
    