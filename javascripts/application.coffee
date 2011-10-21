$ ->  
                
  $quiz         = $("#quiz")
  $settings     = $("#settings")
                
  quizOptions   = 
    pool: "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ")
    possibilitiesCount: 3
                
  quiz          = new Quiz(quizOptions)
                
  possibilities = quiz.ask()
  
  letterSize    = 700 / possibilities.length
  
  _.each possibilities, (letter, i) ->
    rotation = Math.random() * 50 - 25
    $letter = $("<span/>", { 
      "class": "suggestion animated"
      "text" : letter
      "css"  :
        "fontSize": letterSize + "px"
        "left"    : 180 + i * letterSize
        "top"     : 500 - letterSize
        # "-webkit-transform" : "rotate(#{rotation}deg)
    }).appendTo($quiz)
    bounce = -> 
      $letter.addClass("bounceInDown").css("-webkit-transform", "rotate(#{rotation}deg)")
    setTimeout(bounce, Math.random() * 500 + 150 * i)
