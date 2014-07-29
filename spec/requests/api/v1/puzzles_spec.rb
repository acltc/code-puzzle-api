require 'rails_helper'

describe '/api/v1/puzzles/:id' do

  it 'should return puzzle without solution' do
            
    puzzle = Puzzle.create(name: "Sample Arithmetic Puzzle", instructions: "Write code that returns the sum of 1 and 1", solution: "1 + 1")

    get "/api/v1/puzzles/#{puzzle.id}.json"

    puzzle.reload

    expect(response_json).to eq(
        {
          'id' => puzzle.id,
          'name' => puzzle.name,
          'instructions' => puzzle.instructions ,
          'created_at' => puzzle.created_at.iso8601(3),
          'updated_at' => puzzle.updated_at.iso8601(3)          
        }
    )
  end

  it 'should return puzzle with solution' do
            
    puzzle = Puzzle.create(name: "Sample Arithmetic Puzzle", instructions: "Write code that returns the sum of 1 and 1", solution: "1 + 1")

    get "/api/v1/puzzles/#{puzzle.id}.json?solution=true"

    puzzle.reload

    expect(response_json).to eq(
        {
          'id' => puzzle.id,
          'name' => puzzle.name,
          'instructions' => puzzle.instructions,
          'solution' => puzzle.solution,
          'created_at' => puzzle.created_at.iso8601(3),
          'updated_at' => puzzle.updated_at.iso8601(3)
        }
    )
  end

  it 'should return a status code of 404 if puzzle is not found' do

    get "/api/v1/puzzles/9999.json"

    expect(response.status).to eq(404)
  end
end

describe 'GET /api/v1/puzzles' do

  it 'should return all puzzles without solutions' do
    puzzle = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "test")

    get "/api/v1/puzzles.json"

    puzzle.reload

    expect(response_json).to eq(
      [
        {
          'id' => puzzle.id,
          'name' => puzzle.name,
          'instructions' => puzzle.instructions,
          'created_at' => puzzle.created_at.iso8601(3),
          'updated_at' => puzzle.updated_at.iso8601(3)      
        },
        
      ]
    )
   end
   it 'should create new puzzle and save name, instructions, solution, and created_at and search for puzzle using keyword in description' do
      
      puzzle = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "test")

      get 'api/v1/puzzles.json?q=natural'

      puzzle.reload

      expect(response_json).to eq(
      [
        {
          'id' => puzzle.id,
          'name' => puzzle.name,
          'instructions' => puzzle.instructions,
          'created_at' => puzzle.created_at.iso8601(3),
          'updated_at' => puzzle.updated_at.iso8601(3)      
        },
        
      ]
    )
    end
    it 'should create new puzzle and save name, instructions, solution, and created_at and search for puzzle using keyword from name' do
      
      puzzle = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "test")

      get 'api/v1/puzzles.json?q=Multiples'

      puzzle.reload

      expect(response_json).to eq(
      [
        {
          'id' => puzzle.id,
          'name' => puzzle.name,
          'instructions' => puzzle.instructions,
          'created_at' => puzzle.created_at.iso8601(3),
          'updated_at' => puzzle.updated_at.iso8601(3)      
        },
        
      ]
    )
    end
    it 'should create new puzzle and save name, instructions, solution, and created_at and search for puzzle using keyword not found in neither name or description' do
      
      puzzle = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "test")

      get 'api/v1/puzzles.json?q=house'

      puzzle.reload

      expect(response_json).to eq([])
    end
end

describe 'GET /api/v1/puzzles.json?solution=true' do

  it 'should return all puzzles with solutions' do
    puzzle = Puzzle.create(name: "Multiples of 3 and 5", instructions: "If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.", solution: "test")

    get "/api/v1/puzzles.json?solution=true"

    puzzle.reload

    expect(response_json).to eq(
      [
        {
          'id' => puzzle.id,
          'name' => puzzle.name,
          'instructions' => puzzle.instructions,
          'solution' => puzzle.solution,
          'created_at' => puzzle.created_at.iso8601(3),
          'updated_at' => puzzle.updated_at.iso8601(3)  
          
        },
        
      ]
    )
  end
end

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
      "instructions" => ["can't be blank"]
    })
  end
end

