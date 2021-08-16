require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    letters = params[:word].upcase.chars
    grid = params[:grid].split
    @result = `Sorry, but #{params[:word]} can not be built from #{params[:grid]}` if letters.size.zero?
    letters.each do |letter|
      return @result = "Sorry, but #{params[:word]} can not be built from #{params[:grid]}" unless grid.include?(letter)

      grid.delete_at(grid.index(letter))
    end
    uri = URI.parse("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    final = JSON.parse(uri)

    @result = 'Well done!' if final['found']
    @result = 'Not an english word' if final['found'] == false
  end
end
