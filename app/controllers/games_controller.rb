require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters_new = []
    10.times do
      @letters_new << ("a".."z").to_a.sample
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @in_letters = in_letters?(@word, @letters)
    @in_dictionary = in_dictionary?(@word)
    @result = result(@in_letters, @in_dictionary,)
  end

  private

  def in_letters?(word, letters)
    # letters_array = letters.split(" ")
    # word.each_char do |char|
    #   if letters_array.include?(char)
    #     letters_array.delete_at(letters_array.index(char))
    #   else
    #     next
    #   end
    # end
    # letters_array.length == 10 - @word.length

    word.each_char.all? do |char|
      word.count(char) <= letters.count(char)
    end
  end

  def in_dictionary?(word)
    url = "https://dictionary.lewagon.com/#{word}"

    json_string = URI.parse(url).read

    dictionary_search = JSON.parse(json_string)

    dictionary_search["found"]
  end

  def result(in_letters, in_dictionary)
    if in_letters == false
      return "#{@word} cannot be built out of #{@letters}"
    elsif in_dictionary == false
      return "#{@word} is not a valid Engligh word"
    else
      return "CONGRATULATIONS! #{@word} is a valid english word!"
    end
  end
end
