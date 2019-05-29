class RemoveScoreFromDistrict < ActiveRecord::Migration[5.2]
  def change
    remove_column :districts, :score, :float
  end
end
