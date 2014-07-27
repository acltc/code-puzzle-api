class Api::V1::PuzzlesController < ApplicationController
  respond_to :json, :xml, :html

  

  def index
      @puzzles = Puzzle.all
      search_term =params[:q]

      if params[:q] 
        @puzzles = Puzzle.where("instructions LIKE '%#{search_term}%'")
      end
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
  def search
    @results = Puzzle.where("name LIKE '%#{params[:name]}%'")
  end


end
