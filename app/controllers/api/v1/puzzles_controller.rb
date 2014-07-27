class Api::V1::PuzzlesController < ApplicationController
  respond_to :json, :xml, :html

  

  def index
      @puzzles = Puzzle.all
  end

  def show 
    @puzzle = Puzzle.find_by(:id => params[:id])
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    @puzzle.save
  end

  def check_solution
    @solution = Puzzle.find_by(:id => params[:id])
    @proposed = params[:solution]
    if @solution.solution == @proposed
      render :json => {"response" => "correct"}
    else
      render :json => {"response" => "incorrect"}
    end
  end


  private

  def puzzle_params
    return params.require(:puzzle).permit(:name, :instructions, :solution)
  end  
end
