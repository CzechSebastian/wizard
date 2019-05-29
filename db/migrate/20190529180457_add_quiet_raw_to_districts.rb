class AddQuietRawToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :quiet_raw, :jsonb
  end
end
