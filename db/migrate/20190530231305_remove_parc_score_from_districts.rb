class RemoveParcScoreFromDistricts < ActiveRecord::Migration[5.2]
  def change
    remove_column :districts, :parc_score, :float
    remove_column :districts, :parc_raw, :jsonb
  end
end
