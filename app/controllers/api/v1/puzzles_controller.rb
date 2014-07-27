class Api::V1::PuzzlesController < ApplicationController

def index
    @puzzles = Puzzle.all
  end

end
