class Api::V1::PuzzlesController < ApplicationController
  respond_to :json, :xml, :html

  def show 
    @puzzle = Puzzle.find_by(:id => params[:id])
    puts "000000000000000"
    puts @puzzle
  end
end
