class AddParkToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :park_score, :float, default: 0.0
    add_column :districts, :park_raw, :jsonb, default: []
  end
end
