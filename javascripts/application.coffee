
alphabet = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ")
alphabetSounds = {}


$ ->  
  
  window.applicationCache.addEventListener 'error', (-> console.error("Cache error.")), false
                
  $quiz         = $("#quiz")
  $settings     = $("#settings")
  
  _.each alphabet, (letter) ->
    alphabetSounds[letter] = new buzz.sound("audio/#{letter}.aiff")

  quizOptions   = 
    pool: alphabet
    possibilitiesCount: 3
                
  quiz          = new Quiz(quizOptions)
  
  $(document).bind "refreshquiz", =>
    
    $quiz.find(".suggestion").each ->
      $(@)
        .addClass("bounceOutDown")
        .bind "webkitAnimationEnd", =>
          $(@).remove()
          
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
      .appendTo($quiz)
      .bind "click", ->
        letter = $(@).text()
        alphabetSounds[letter].play()
      .bind "touchStart", (e) ->
        e.preventDefault()
        letter = $(@).text()
        if quiz.check(letter)
          $(@)
            .addClass("correct bounce")
            .bind "webkitAnimationEnd", =>
              $(@)
                .removeClass("bounce")
                .addClass("bounceOutDown")
              setTimeout(remove, 1000)
              $(document).trigger("refreshquiz")
        else
          $(@)
            .addClass("glow-error wobble")
            .bind "webkitAnimationEnd", =>
              $(@)
                .removeClass("wobble")
                .addClass("bounceOutDown")
              setTimeout(remove, 1000)
        remove = => $(@).remove()
        
      revealDelayed = -> 
        rotation = Math.random() * 40 - 20
        $letter.addClass("bounceInDown")
          
      setTimeout(revealDelayed, Math.random() * 500 + 150 * i)
      
      # playCorrect = => alphabetSounds[quiz.correct].play()
      # setTimeout(playCorrect, 1000)
      
      $quiz.find(".suggestion").filter( ->
        $(@).text() == quiz.correct 
      ).trigger("click")

  $(document).trigger("refreshquiz")
    