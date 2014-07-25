class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.string :name
      t.text :instructions
      t.string :language
      t.text :test_code

      t.timestamps
    end
  end
end
