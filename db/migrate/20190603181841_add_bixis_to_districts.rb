class AddBixisToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :bixi_score, :float, default: 0.0
    add_column :districts, :bixi_raw, :jsonb, default: []
  end
end
