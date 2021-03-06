class Api::V1::PuzzlesController < ApplicationController
  respond_to :json, :xml, :html
  

  def index
    @puzzles = Puzzle.all
    @solution = params[:solution]
    search_term = params[:q]
    if params[:q] 
      @puzzles = Puzzle.where("instructions LIKE ? OR name LIKE ?", "%#{search_term}%", "%#{search_term}%")
    end
  end

  def show 
    @puzzle = Puzzle.find_by(:id => params[:id])
    @solution = params[:solution]
    render(json: "Puzzle is not found", status: 404) unless @puzzle
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    if @puzzle.save
    else
      render :json => @puzzle.errors
    end
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
