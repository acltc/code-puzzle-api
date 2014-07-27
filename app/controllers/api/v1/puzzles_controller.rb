class Api::V1::PuzzlesController < ApplicationController
  respond to :json, :xml, :html

  def show 
    @puzzle = Puzzle.find_by(:id => params[:id])
  end

end
