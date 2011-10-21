(function() {
  var AlphAlphabet, Boo;
  Boo = (function() {
    function Boo() {}
    return Boo;
  })();
  AlphAlphabet = (function() {
    function AlphAlphabet() {}
    AlphAlphabet.prototype.getLetters = function() {
      return [];
    };
    return AlphAlphabet;
  })();
  window.AlphAlphabet = AlphAlphabet;
}).call(this);
