class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts do |t|
      t.string :name
      t.float :score
      t.jsonb :coordinates

      t.timestamps
    end
  end
end
