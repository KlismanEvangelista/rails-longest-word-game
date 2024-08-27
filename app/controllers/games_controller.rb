require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # raise
    @grid = params[:grid].split
    @word = (params[:word] || '').upcase
    @included = valid_word?(@word, @grid)
    @english_word = english_word?(@word)
  end

  def valid_word?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    @json = JSON.parse(response.read)
    @json['found']
  end
end
