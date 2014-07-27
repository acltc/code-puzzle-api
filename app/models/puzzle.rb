class Puzzle < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :instructions, presence: true
  validates :solution, presence: true

end
