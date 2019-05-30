class DistrictsController < ApplicationController

  def show
  	@district = District.find(params[:id])

  	if @district.raw_restaurant == nil
  		@restaurant_coordinates = []
  	else
  		@restaurant_coordinates = @district.raw_restaurant.map do |restaurant_hash|
				restaurant_hash["geometry"]["location"]
			end
		end
  end

  def new
  end
end
