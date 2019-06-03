class DistrictsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
  	@district = District.find(params[:id])

  	if @district.raw_restaurant == nil
  		@restaurant_coordinates = []
  	else
  		@restaurant_coordinates = @district.raw_restaurant.map do |restaurant_hash|
        { 
          lat: restaurant_hash["geometry"]["location"]["lat"],
          lng: restaurant_hash["geometry"]["location"]["lng"],
          category: "restaurants"
        }
			end
		end

		if @district.school_raw == nil
  		@school_coordinates = []
  	else
  		@school_coordinates = @district.school_raw.map do |school_hash|
       { 
          lat: school_hash["geometry"]["location"]["lat"],
          lng: school_hash["geometry"]["location"]["lng"],
          category: "schools"
        }
			end
		end

		if @district.park_raw == nil
  		@school_coordinates = []
  	else
  		@park_coordinates = @district.park_raw.map do |park_hash|
        { 
          lat: park_hash["geometry"]["location"]["lat"],
          lng: park_hash["geometry"]["location"]["lng"],
          category: "parks"
        }
			end
		end

		if @district.subway_raw == nil
  		@subway_coordinates = []
  	else
  		@subway_coordinates = @district.subway_raw.map do |subway_hash|
        { 
          lat: subway_hash["geometry"]["location"]["lat"],
          lng: subway_hash["geometry"]["location"]["lng"],
          category: "subways"
        }
			end
		end
  end

  def new
  end
end
