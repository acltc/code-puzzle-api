class Api::V1::PuzzlesController < ApplicationController
  respond_to :json, :xml, :html
  

  def index
      @puzzles = Puzzle.all
      @solutions = params[:solution]
  end

  def show 
    @puzzle = Puzzle.find_by(:id => params[:id])
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    @puzzle.save
  end

  private

  def puzzle_params
    return params.require(:puzzle).permit(:name, :instructions, :solution)
  end  
end
