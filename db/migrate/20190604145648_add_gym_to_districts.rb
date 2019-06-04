class AddGymToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :gym_score, :float, default: 0.0
    add_column :districts, :gym_raw, :jsonb, default: []
  end
end
