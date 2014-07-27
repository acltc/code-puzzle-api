require 'spec_helper'

describe 'GET /api/v1/puzzles/:id' do

  it 'should return a puzzle by its id' do
    employee = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "nil")

    get "/api/v1/puzzles/#{puzzle.id}.json"

    expect(response_json).to eq(
      {
        'id' => puzzle.id,
        'name' => puzzle.name,
        'instructions' => puzzle.instructions
      }
    )
  end

  it 'should return a status code of 404 if puzzle is not found' do

    get "/api/v1/puzzles/9999.json"

    expect(response.status).to eq(404)
  end
  
end