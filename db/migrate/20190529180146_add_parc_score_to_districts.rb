class AddParcScoreToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :parc_score, :float
  end
end
