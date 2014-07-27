class Api::V1::PuzzlesController < ApplicationController

  def create
    @puzzle = Puzzle.new(puzzle_params)
    @puzzle.save
  end


  private

  def puzzle_params
    return params.require(:puzzle).permit(:name, :instructions, :solution)
  end

end
