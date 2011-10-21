(function() {
  $(function() {
    var $quiz, $settings, letterSize, letterWidth, possibilities, quiz, quizOptions;
    $quiz = $("#quiz");
    $settings = $("#settings");
    quizOptions = {
      pool: "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" "),
      possibilitiesCount: 3
    };
    quiz = new Quiz(quizOptions);
    possibilities = quiz.ask();
    letterSize = 800 / possibilities.length;
    letterWidth = letterSize;
    return _.each(possibilities, function(letter, i) {
      var $letter, bounce;
      $letter = $("<span/>", {
        "class": "suggestion animated",
        "text": letter,
        "css": {
          "fontSize": letterSize + "px",
          "left": 140 + i * letterSize,
          "top": 760 - letterSize * 2,
          "-webkit-transform": "rotate(" + (Math.random() * 20 - 10) + "deg)",
          "-webkit-transition-duration": "" + (Math.random() * 2000 + 1000) + "ms"
        }
      }).appendTo($quiz);
      bounce = function() {
        return $letter.addClass("bounceInDown");
      };
      return setTimeout(bounce, Math.random() * 500 + 150 * i);
    });
  });
}).call(this);
