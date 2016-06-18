class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError, 'Invalid guess' if letter.nil? || letter.empty? || (letter =~ /^[a-zA-Z]$/).nil?
    letter.downcase!
    
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    else  
      if @word.include? letter
        @guesses << letter
      else
        @wrong_guesses << letter
      end
      return true
    end
  end
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      :lose
    elsif @word === self.word_with_guesses
      :win
    else
      :play
    end
  end

  def word_with_guesses
    display = ''
    @word.split('').each { |letter|
      if @guesses.include? letter
        display << letter
      else
        display << '-'
      end
    }
    return display
  end

end
