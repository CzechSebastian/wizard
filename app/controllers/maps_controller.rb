class MapsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    averagedistrict = District.all.map do |district|
      score = (district.restaurant_score + district.school_score) / 2
      district.average = score
      district
    end
    # binding.pry

    @districts = averagedistrict.sort_by { |district| 1 / district.average }
    @districts = @districts.first(10)

    respond_to do |format|
      format.html { render 'districts/index' }
      format.js
    end
  end

end


