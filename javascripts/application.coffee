# addAudio = (id, file) ->
#   track = document.createElement("audio")
#   track.id = "suggestion-#{id}"
#   track.src = file
#   track.controls = ""
#   document.body.appendChild(track)
#   track.load()
#   track

alphabet = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ")
alphabetSounds = {}


$ ->  
                
  $quiz         = $("#quiz")
  $settings     = $("#settings")
  
  # soundsLoadedCounter = 0
  # soundLoaded = ->
  #   if ++soundsLoadedCounter == _.size(alphabetSounds)
  #     alert "all sounds loaded"
  
  _.each alphabet, (letter) ->
    alphabetSounds[letter] = new buzz.sound("audio/#{letter}.aiff")
    alphabetSounds[letter].load().bind "stall", ->
      alert("stalling #{letter}")
                  
  quizOptions   = 
    pool: alphabet
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
        "css"  :
          "fontSize": "#{width * 0.8}px"
          "left"    : margin + i * width
          "top"     : 500 - width
          "width"   : "#{width}px"
      })
      .attr("onclick", "")
      .appendTo($quiz)
      .bind "click", ->
        letter = $(@).addClass("bounceOutDown").text()
        console.log letter
        alphabetSounds[letter].play()
        remove = => $(@).remove()
        setTimeout(remove, 1000)
        
      revealDelayed = -> 
        rotation = Math.random() * 40 - 20
        $letter.addClass("bounceInDown")
          
      setTimeout(revealDelayed, Math.random() * 500 + 150 * i)
  #
    # 
    # if $("#quiz").find(".suggestion").length == 1
    #   $(document).trigger("refreshquiz")
  
  $(document).trigger("refreshquiz")
    