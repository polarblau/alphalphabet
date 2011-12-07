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
      $quiz.find(".suggestion").each(function() {
        return $(this).addClass("bounceOutDown").bind("webkitAnimationEnd", __bind(function() {
          return $(this).remove();
        }, this));
      });
      possibilities = quiz.ask();
      margin = 50;
      width = (1024 - margin * 2) / possibilities.length;
      return _.each(possibilities, function(letter, i) {
        var $letter, playCorrect, revealDelayed, rotation;
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
        }).appendTo($quiz).bind("click", function(e) {
          var remove;
          e.preventDefault();
          letter = $(this).text();
          alphabetSounds[letter].play();
          if (quiz.check(letter)) {
            $(this).addClass("correct bounce").bind("webkitAnimationEnd", __bind(function() {
              $(this).removeClass("bounce").addClass("bounceOutDown");
              setTimeout(remove, 1000);
              return $(document).trigger("refreshquiz");
            }, this));
          } else {
            $(this).addClass("glow-error wobble").bind("webkitAnimationEnd", __bind(function() {
              $(this).removeClass("wobble").addClass("bounceOutDown");
              return setTimeout(remove, 1000);
            }, this));
          }
          return remove = __bind(function() {
            return $(this).remove();
          }, this);
        });
        revealDelayed = function() {
          rotation = Math.random() * 40 - 20;
          return $letter.addClass("bounceInDown");
        };
        setTimeout(revealDelayed, Math.random() * 500 + 150 * i);
        playCorrect = __bind(function() {
          return alphabetSounds[quiz.correct].play();
        }, this);
        return setTimeout(playCorrect, 1000);
      });
    }, this));
    return $(document).trigger("refreshquiz");
  });
}).call(this);
