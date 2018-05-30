class AddSizeToHighScores < ActiveRecord::Migration[5.1]
  def change
    add_column :high_scores, :size, :string
  end
end
