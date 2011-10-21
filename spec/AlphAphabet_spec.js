(function() {
  describe('AlphAphabetss', function() {
    beforeEach(function() {
      var alpha;
      return alpha = new AlphAlphabet;
    });
    describe('When changing settings', function() {});
    describe('When asking', function() {
      return describe('#getLetters', function() {
        return it('should return an array', function() {
          return expect(typeof alpha.getLetters()).toBe('object');
        });
      });
    });
    return describe('When answering', function() {});
  });
}).call(this);
