$ ->  
                
  $quiz         = $("#quiz")
  $settings     = $("#settings")
                
  quizOptions   = 
    pool: "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ")
    possibilitiesCount: 3
                
  quiz          = new Quiz(quizOptions)
                
  possibilities = quiz.ask()
  
  letterSize    = 800 / possibilities.length
  letterWidth   = letterSize
  
  _.each possibilities, (letter, i) ->
    $letter = $("<span/>", { 
      class: "suggestion animated"
      text : letter
      css  :
        fontSize: letterSize + "px"
        left    : 140 + i * letterSize
        top     : 760 - letterSize * 2
    }).appendTo($quiz)
    bounce = -> 
      $letter.addClass("bounceInDown")
    setTimeout(bounce, Math.random() * 500 + 150 * i)
