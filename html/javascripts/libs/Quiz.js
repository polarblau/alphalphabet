(function() {
  var Quiz;
  Quiz = (function() {
    Quiz.prototype.pool = [];
    Quiz.prototype.possibilitiesCount = 0;
    Quiz.prototype.possibilities = [];
    Quiz.prototype.correct = null;
    function Quiz(options) {
      var key, value;
      for (key in options) {
        value = options[key];
        if (this[key] != null) {
          this[key] = value;
        }
      }
    }
    Quiz.prototype.ask = function() {
      var start;
      start = Math.floor(Math.random() * (this.pool.length - this.possibilitiesCount));
      this.possibilities = this.pool.slice(start, start + this.possibilitiesCount);
      this.pick();
      return this.possibilities;
    };
    Quiz.prototype.pick = function() {
      return this.correct = this.possibilities[Math.floor(Math.random() * this.possibilities.length)];
    };
    Quiz.prototype.check = function(suggestion) {
      return this.correct === suggestion;
    };
    return Quiz;
  })();
  window.Quiz = Quiz;
}).call(this);
