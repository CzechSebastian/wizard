class AddParkToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :park_score, :float
    add_column :districts, :park_raw, :jsonb
  end
end
