(function() {
  var POOL, addAudio, letterClickHandler, players;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  addAudio = function(id, file) {
    var track;
    track = document.createElement("audio");
    track.id = "suggestion-" + id;
    track.src = file;
    track.controls = "";
    document.body.appendChild(track);
    track.load();
    return track;
  };
  letterClickHandler = function(e) {
    var letter, remove;
    letter = $(this).data("value");
    players[letter].play();
    $(this).addClass("bounceOutDown");
    remove = __bind(function() {
      if ($("#quiz").find(".suggestion").length === 1) {
        $(document).trigger("refreshquiz");
      }
      return $(this).remove();
    }, this);
    return setTimeout(remove, 1000);
  };
  POOL = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(" ");
  players = {};
  $(function() {
    var $quiz, $settings, quiz, quizOptions;
    $quiz = $("#quiz");
    $settings = $("#settings");
    _.each(POOL, function(letter) {
      return players[letter] = addAudio(letter, "audio/" + letter + ".aiff");
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
          return $letter.addClass("bounceInDown");
        };
        setTimeout(bounce, Math.random() * 500 + 150 * i);
        return $letter.bind("click", letterClickHandler);
      });
    }, this));
    return $(document).trigger("refreshquiz");
  });
}).call(this);
