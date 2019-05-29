class AddSchoolScoreToDistricts < ActiveRecord::Migration[5.2]
  def change
  	add_column :districts, :school_score, :float
  end
end
