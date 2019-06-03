class AddSubwaysToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :subway_score, :float, default: 0.0
    add_column :districts, :subway_raw, :jsonb, default: []
  end
end
