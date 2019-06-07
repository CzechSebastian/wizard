class AddPHotoToDistricts < ActiveRecord::Migration[5.2]
  def change
        add_column :districts, :photo, :string
  end
end
