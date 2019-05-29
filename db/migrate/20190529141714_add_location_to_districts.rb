class AddLocationToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :location, :string
  end
end
