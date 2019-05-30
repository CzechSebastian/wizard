class AddAverageToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :average, :float
  end
end
