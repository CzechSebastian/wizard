class AddCriteriaToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :language, :string, default: "French"
    add_column :districts, :crime_rate, :string, default: "Low"
    add_column :districts, :age, :integer, default: 30
    add_column :districts, :rent_rate, :integer, default: 900
  end
end
