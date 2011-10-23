(function() {
  var alphabet, alphabetSounds;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  alphabet = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ");
  alphabetSounds = {};
  $(function() {
    var $quiz, $settings, quiz, quizOptions;
    window.applicationCache.addEventListener('error', (function() {
      return console.error("Cache error.");
    }), false);
    $quiz = $("#quiz");
    $settings = $("#settings");
    _.each(alphabet, function(letter) {
      return alphabetSounds[letter] = new buzz.sound("audio/" + letter + ".aiff");
    });
    quizOptions = {
      pool: alphabet,
      possibilitiesCount: 3
    };
    quiz = new Quiz(quizOptions);
    $(document).bind("refreshquiz", __bind(function() {
      var margin, possibilities, width;
      $quiz.empty();
      possibilities = quiz.ask();
      margin = 50;
      width = (1024 - margin * 2) / possibilities.length;
      return _.each(possibilities, function(letter, i) {
        var $letter, revealDelayed, rotation;
        rotation = Math.random() * 30 - 15;
        $letter = $("<span/>", {
          "class": "suggestion animated",
          "text": letter,
          "css": {
            "fontSize": "" + (width * 0.8) + "px",
            "left": margin + i * width,
            "top": 500 - width,
            "width": "" + width + "px"
          }
        }).appendTo($quiz).bind("click", function() {
          var remove;
          letter = $(this).addClass("bounceOutDown").text();
          alphabetSounds[letter].play();
          remove = __bind(function() {
            if ($("#quiz").find(".suggestion").length === 1) {
              $(document).trigger("refreshquiz");
            }
            return $(this).remove();
          }, this);
          return setTimeout(remove, 1000);
        });
        revealDelayed = function() {
          rotation = Math.random() * 40 - 20;
          return $letter.addClass("bounceInDown");
        };
        return setTimeout(revealDelayed, Math.random() * 500 + 150 * i);
      });
    }, this));
    return $(document).trigger("refreshquiz");
  });
}).call(this);
