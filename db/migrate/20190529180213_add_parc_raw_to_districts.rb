class AddParcRawToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :parc_raw, :jsonb, default: []
  end
end
