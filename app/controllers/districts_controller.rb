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

		if @district.school_raw == nil
  		@school_coordinates = []
  	else
  		@school_coordinates = @district.school_raw.map do |school_hash|
				school_hash["geometry"]["location"]
			end
		end

		if @district.parc_raw == nil
  		@school_coordinates = []
  	else
  		@park_coordinates = @district.parc_raw.map do |park_hash|
				park_hash["geometry"]["location"]
			end
		end

		if @district.subway_raw == nil
  		@subway_coordinates = []
  	else
  		@subway_coordinates = @district.subway_raw.map do |subway_hash|
				subway_hash["geometry"]["location"]
			end
		end
  end

  def new
  end
end
