class Api::V1::PuzzlesController < ApplicationController

  def index
      @puzzles = Puzzle.all
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    if @puzzle.save
    else
      render :json => @puzzle.errors
    end
  end

  private

  def puzzle_params
    return params.require(:puzzle).permit(:name, :instructions, :solution)
  end
    
end
