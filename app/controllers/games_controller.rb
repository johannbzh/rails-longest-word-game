class GamesController < ApplicationController
  require 'open-uri'
  require 'json'
  require 'time'

  def new
    @letters = Array.new(10) { Array('A'..'Z').sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    answer = JSON.parse(word_serialized)
    if @word.upcase.chars.all? { |letter| answer.count(letter) <= @letters.count(letter) }
      if answer['found'] == true
        @result = "Congratulations ! #{@word.capitalize} is a valid English word!"
        @score = (answer.length * 20)
      else
        @result = "Sorry but #{@word.capitalize} does not seem to be an english word..."
        @score = 0
      end
    else
      @result = "Sorry but #{@word.capitalize} can't be built out of #{@letters}"
      @score = 0
    end
    @result
  end
end
