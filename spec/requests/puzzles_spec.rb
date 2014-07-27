require 'rails_helper'

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

