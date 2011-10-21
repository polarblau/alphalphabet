describe 'AlphAphabetss', ->
  
  beforeEach ->
    alpha = new AlphAlphabet
  
  
  # Settings mode ###############################################
  
  describe 'When changing settings', ->
  
  
  # Quiz mode ###################################################
  
  # Asking:
  
  describe 'When asking', ->
    
    describe '#getLetters', ->
    
      it 'should return an array', ->
        expect(typeof alpha.getLetters()).toBe('object')

  # Answering:
  
  describe 'When answering', ->  

  # Feedback: