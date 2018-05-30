class CreateSavedGames < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_games do |t|
      t.string :owner
      t.string :board
      t.string :name
      t.string :size
      t.string :board_type

      t.integer :moves
      t.integer :score

      t.timestamps
    end
  end
end
