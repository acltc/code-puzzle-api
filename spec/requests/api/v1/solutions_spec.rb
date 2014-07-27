require 'rails_helper'

describe 'GET api/v1/puzzles/solutions/:id' do

    it 'should return whether or not a solution is correct' do
      puzzle = Puzzle.create(name: "Guess Trevor's age", instructions: "Just a type a number to guess his age", solution: "27")

      get "/api/v1/puzzles/solutions/#{puzzle.id}.json?solution=27"

      expect(response_json).to eq({
        "response" => "correct"
        })

    end
  end

