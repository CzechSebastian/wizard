class AddSchoolRawToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :school_raw, :jsonb
  end
end
