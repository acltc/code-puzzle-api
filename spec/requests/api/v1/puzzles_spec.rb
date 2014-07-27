require 'rails_helper'
require 'spec_helper'

describe 'POST /api/v1/puzzles' do

    it 'should create new puzzle and save name, instructions, solution, and created_at' do
      
      post 'api/v1/puzzles.json', {
        puzzle: {
          name: "Sample Arithmetic Puzzle",
          instructions: "Write code that returns the sum of 1 and 1",
          solution: "1 + 1",
        }
      }.to_json, {'Content-Type' => 'application/json'}

      puzzle = Puzzle.last

      expect(puzzle.name).to eq("Sample Arithmetic Puzzle")
      expect(puzzle.instructions).to eq("Write code that returns the sum of 1 and 1")
      expect(puzzle.solution).to eq("1 + 1")
    end

    it 'should render id' do
      post 'api/v1/puzzles.json', {
        puzzle: {
          name: "Sample Arithmetic Puzzle",
          instructions: "Write code that returns the sum of 1 and 1",
          solution: "1 + 1",
        }
      }.to_json, {'Content-Type' => 'application/json'}

      expect(response_json).to include({'id' => Puzzle.last.id})
    end

    it 'should return error message when invalid' do
      post 'api/v1/puzzles.json', {
        puzzle: {
          name: "Sample Arithmetic Puzzle",
          instructions: "",
          solution: "1 + 1",
          created_at: "Now"
        }
      }.to_json, {'Content-Type' => 'application/json'}

      expect(response_json).to eq({
        "message" => "Puzzle not created",
        "errors" => ["Instructions can't be blank"]
      })
    end
  end

describe 'GET /api/v1/puzzles/:id' do

  it 'should return a puzzle by its id' do
    puzzle = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "nil")

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

describe 'GET /api/v1/puzzles' do

  it 'should return all employees without solutions' do
    puzzle = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "test")

    get "/api/v1/puzzles.json"

    data = response_json

    data.delete('created_at')
    data.delete('updated_at')
    

    expect(data).to eq(
      [
        {
          'id' => puzzle.id,
          'name' => puzzle.name,
          'instructions' => puzzle.instructions         
        },
        
      ]
    )
  end
end

  describe 'GET /api/v1/puzzles.json?solution=true' do

  it 'should return all puzzles with solutions' do
    puzzle = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "test")

    get "/api/v1/puzzles.json?solution=true"

    data = response_json
    data.delete('created_at')
    data.delete('updated_at')

    expect(data).to eq(
      [
        {
          'id' => puzzle.id,
          'name' => puzzle.name,
          'instructions' => puzzle.instructions,
          'solution' => puzzle.solution
          
        },
        
      ]
    )
  end
end

end