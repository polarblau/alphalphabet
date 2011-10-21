addAudio = (id, file) ->
  track = document.createElement("audio")
  track.id = "suggestion-#{id}"
  track.src = file
  track.controls = ""
  document.body.appendChild(track)
  track.load()
  track

letterClickHandler = (e)->
  letter = $(@).data("value")
  players[letter].play()#$("#suggestion-#{letter}")[0].play()
  $(@).addClass("bounceOutDown")
  remove = =>
    if $("#quiz").find(".suggestion").length == 1
      $(document).trigger("refreshquiz")
    $(@).remove()
  setTimeout(remove, 1000)
  

POOL = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ")
players = {}

$ ->  
                
  $quiz         = $("#quiz")
  $settings     = $("#settings")
  
  _.each POOL, (letter) ->
    players[letter] = addAudio(letter, "audio/#{letter}.aiff")
                
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
      })
      .appendTo($quiz)
      bounce = -> 
        $letter.addClass("bounceInDown")
      setTimeout(bounce, Math.random() * 500 + 150 * i)
      $letter.bind("click", letterClickHandler)
  #
  
  $(document).trigger("refreshquiz")
    