class AddCafeToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :cafe_score, :float, default: 0.0
    add_column :districts, :cafe_raw, :jsonb, default: []
  end
end
