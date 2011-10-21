# options = {
#   pool: ["A", "B", "C", "D"]
#   possibilitiesCount: 3
# }
# quiz = new Quiz(options)
# quiz.ask() # -> ["C", "D", "A"]
# quiz.check("B") # -> false
# quiz.check("C") # -> true
# 
# quiz.pool = ["A", "B", "C", "D"]
# quiz.possibilitiesCount = 3

describe "Quiz", ->
  
  OPTIONS = 
    pool: ["A", "B", "C", "D", "E"]
    possibilitiesCount: 3
  
  beforeEach =>
    @quiz = new Quiz(OPTIONS)
    
  afterEach =>
    @quiz = null
  
  
  # ASK ########################################################
  
  # Asking:
  
  describe "#ask", =>
    
    it "should return an array", =>
      expect(_.isArray(@quiz.ask())).toBeTruthy()
    
    it "should return an array in the length of `possibilitiesCount`", =>
      expect(@quiz.ask().length).toEqual(OPTIONS.possibilitiesCount)
    
    it "should automatically pick a correct answer", => 
      @quiz.ask()
      expect(@quiz.correct).toBeDefined()
      
    it "should ask for a correct answer from the possibilities", => 
      possibilties = @quiz.ask()
      expect(possibilties).toContain(@quiz.correct)
      
      
  # CHECK #######################################################
  
  describe "#check", =>  
  
    it "should return true when the answer is correct", => 
      @quiz.ask()
      correct = @quiz.correct
      expect(@quiz.check(correct)).toBeTruthy()
      
    it "should return false when the answer is not correct", => 
      @quiz.ask()
      incorrect = "X"
      expect(@quiz.check(incorrect)).toBeFalsy()
      

  # OPTIONS #####################################################
  
  describe "options", =>
    
    it "should accept a `pool` option through the constructor", =>
      quiz = new Quiz({ pool: ["A"] })
      expect(quiz.pool).toEqual(["A"])
      
    it "should accept a `possibilitiesCount` option through the constructor", =>
      quiz = new Quiz({ possibilitiesCount: 7 })
      expect(quiz.possibilitiesCount).toEqual(7)
    
    it "should accept a `pool` options directly", =>
      quiz = new Quiz({})
      quiz.pool = ["C"]
      expect(quiz.pool).toEqual(["C"])
    
    it "should accept a `possibilitiesCount` options directly", =>
      quiz = new Quiz({})
      quiz.possibilitiesCount = 4
      expect(quiz.possibilitiesCount).toEqual(4)