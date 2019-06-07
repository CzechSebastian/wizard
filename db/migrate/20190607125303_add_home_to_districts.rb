class AddHomeToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :home, :string, default: "This neighbourhood has an energetic atmosphere and also a concentration of bars, restaurants, theatres and other hangouts. It may be more active in the week hours of the night than by day."
    add_column :districts, :review, :string, default: "Little known to tourists, this area is really nice. So many activities for the family, very good restaurants and local food stands!"
  end
end
