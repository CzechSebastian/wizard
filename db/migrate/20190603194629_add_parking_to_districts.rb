class AddCarToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :parking_score, :float, default: 0.0
    add_column :districts, :parking_raw, :jsonb, default: []
  end
end
