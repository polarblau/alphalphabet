(function() {
  var POOL, addAudio;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  addAudio = function(id, file) {
    var $track, pauseTrack, removeListener;
    $track = $("<audio/>").attr({
      "id": "suggestion-" + id,
      "autoplay": false,
      "preload": false
    });
    removeListener = function() {
      return $track.unbind('canplaythrough');
    };
    $track.bind('canplaythrough', removeListener);
    $("body").append($track);
    $track.attr("src", file);
    $track.trigger("play");
    pauseTrack = __bind(function() {
      return $track.trigger("pause");
    }, this);
    return setTimeout(pauseTrack, 1);
  };
  POOL = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ");
  $(function() {
    var $quiz, $settings, quiz, quizOptions;
    $quiz = $("#quiz");
    $settings = $("#settings");
    _.each(POOL, function(letter) {
      return addAudio(letter, "audio/" + letter + ".aiff");
    });
    quizOptions = {
      pool: POOL,
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
        var $letter, bounce, rotation;
        rotation = Math.random() * 30 - 15;
        $letter = $("<span/>", {
          "class": "suggestion animated",
          "text": letter,
          "data": {
            "value": letter.toUpperCase()
          },
          "css": {
            "fontSize": "" + (width * 0.8) + "px",
            "left": margin + i * width,
            "top": 500 - width,
            "width": "" + width + "px"
          }
        }).appendTo($quiz);
        bounce = function() {
          return $letter.addClass("bounceInDown").css("-webkit-transform", "rotate(" + rotation + "deg)");
        };
        return setTimeout(bounce, Math.random() * 500 + 150 * i);
      });
    }, this));
    $("span.suggestion").live("click", function() {
      var letter, refresh, remove;
      letter = $(this).data("value");
      $("#suggestion-" + letter).trigger("play");
      refresh = function() {
        return $(document).trigger("refreshquiz");
      };
      remove = __bind(function() {
        $(this).removeClass("bounceInDown").addClass("bounceOutDown");
        if (!$quiz.find(".bounceInDown").length) {
          return setTimeout(refresh, 1000);
        }
      }, this);
      return setTimeout(remove, 1000);
    });
    return $(document).trigger("refreshquiz");
  });
}).call(this);
