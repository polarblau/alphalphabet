class AlphAlphaBet
  
  LETTERS = %w(A B C D E)
  
  def say_letter
    letter = LETTERS.sample
    say(letter)
    letter
  end
  
  private
  
    def say(text, delay = 0, voice = "Alex")
      %x(sleep #{delay}; say -v "#{voice}" "#{text}").rstrip
    end
  
end