json.id               puzzle.id
json.name             puzzle.name
json.instructions     puzzle.instructions
if @solution
  json.solution         puzzle.solution 
end 
json.created_at       puzzle.created_at
json.updated_at       puzzle.updated_at

