class ChangeLocationToJson < ActiveRecord::Migration[5.2]
  def change
  	remove_column :districts, :location
  	add_column :districts, :location, :jsonb
  end
end
