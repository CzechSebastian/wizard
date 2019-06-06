class MapsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # params[:criteria] = ["", "restaurant", "school", ... ]
    # initialize le average a 0
    @districts = District.all

    if params[:criteria].include? "restaurant"
      @districts = @districts.each do |district|
        if district.raw_restaurant && district.raw_restaurant.length > 10
          district.average = district.average += district.restaurant_score
          district.average
        else
          district.average = 0
        end
      end
    end

    if params[:criteria].include? "school"
      @districts = @districts.each do |district|
        district.average = district.average += district.school_score
        district.average
      end
    end

    if params[:criteria].include? "park"
      @districts = @districts.each do |district|
        if district.park_raw && district.park_raw.length > 5
          district.average += district.park_score
          district.average
        else
          district.average = 0
        end
      end
    end

    if params[:criteria].include? "subway"
      @districts = @districts.each do |district|
        district.average += district.subway_score
        district.average
      end
    end
    if params[:criteria].include? "bike"
      @districts = @districts.each do |district|
        district.average = district.average += district.bixi_score
        district.average
      end
    end

    if params[:criteria].include? "car"

      @districts = @districts.each do |district|
        district.average = district.average += district.parking_score
        district.average
      end
    end

    if params[:criteria].include? "quiet"
      @districts = @districts.each do |district|
        district.average = district.average += district.quiet_score
        district.average
      end
    end

    if params[:criteria].include? "dog"
          @districts = @districts.each do |district|
        district.average = district.average += district.dog_score
        district.average
      end
    end

    @districts = @districts.sort_by { |district| district.average }
    @districts = @districts.last(8)
    @districts = [] if params[:criteria].count <= 1

    respond_to do |format|
      format.html { render 'districts/index' }
      format.js
    end
  end
end
