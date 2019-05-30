class AddSubwaysToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :subway_score, :float
    add_column :districts, :subway_raw, :jsonb
  end
end
