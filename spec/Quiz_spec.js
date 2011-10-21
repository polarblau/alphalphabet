(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  describe("Quiz", function() {
    var OPTIONS;
    OPTIONS = {
      pool: ["A", "B", "C", "D", "E"],
      possibilitiesCount: 3
    };
    beforeEach(__bind(function() {
      return this.quiz = new Quiz(OPTIONS);
    }, this));
    afterEach(__bind(function() {
      return this.quiz = null;
    }, this));
    describe("#ask", __bind(function() {
      it("should return an array", __bind(function() {
        return expect(_.isArray(this.quiz.ask())).toBeTruthy();
      }, this));
      it("should return an array in the length of `possibilitiesCount`", __bind(function() {
        return expect(this.quiz.ask().length).toEqual(OPTIONS.possibilitiesCount);
      }, this));
      it("should automatically pick a correct answer", __bind(function() {
        this.quiz.ask();
        return expect(this.quiz.correct).toBeDefined();
      }, this));
      return it("should ask for a correct answer from the possibilities", __bind(function() {
        var possibilties;
        possibilties = this.quiz.ask();
        return expect(possibilties).toContain(this.quiz.correct);
      }, this));
    }, this));
    describe("#check", __bind(function() {
      it("should return true when the answer is correct", __bind(function() {
        var correct;
        this.quiz.ask();
        correct = this.quiz.correct;
        return expect(this.quiz.check(correct)).toBeTruthy();
      }, this));
      return it("should return false when the answer is not correct", __bind(function() {
        var incorrect;
        this.quiz.ask();
        incorrect = "X";
        return expect(this.quiz.check(incorrect)).toBeFalsy();
      }, this));
    }, this));
    return describe("options", __bind(function() {
      it("should accept a `pool` option through the constructor", __bind(function() {
        var quiz;
        quiz = new Quiz({
          pool: ["A"]
        });
        return expect(quiz.pool).toEqual(["A"]);
      }, this));
      it("should accept a `possibilitiesCount` option through the constructor", __bind(function() {
        var quiz;
        quiz = new Quiz({
          possibilitiesCount: 7
        });
        return expect(quiz.possibilitiesCount).toEqual(7);
      }, this));
      it("should accept a `pool` options directly", __bind(function() {
        var quiz;
        quiz = new Quiz({});
        quiz.pool = ["C"];
        return expect(quiz.pool).toEqual(["C"]);
      }, this));
      return it("should accept a `possibilitiesCount` options directly", __bind(function() {
        var quiz;
        quiz = new Quiz({});
        quiz.possibilitiesCount = 4;
        return expect(quiz.possibilitiesCount).toEqual(4);
      }, this));
    }, this));
  });
}).call(this);
