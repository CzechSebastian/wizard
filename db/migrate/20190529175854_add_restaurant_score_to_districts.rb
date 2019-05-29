class AddRestaurantScoreToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :restaurant_score, :float
  end
end
