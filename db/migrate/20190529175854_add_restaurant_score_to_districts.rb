class AddRestaurantScoreToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :restaurant_score, :float, default: 0.0
  end
end
