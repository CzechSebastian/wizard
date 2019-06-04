class AddBarToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :bar_score, :float, default: 0.0
    add_column :districts, :bar_raw, :jsonb, default: []
  end
end
