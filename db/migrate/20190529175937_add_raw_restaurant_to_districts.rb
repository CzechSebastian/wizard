class AddRawRestaurantToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :raw_restaurant, :jsonb, default: []
  end
end
