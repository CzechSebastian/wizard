class MapsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # params[:criteria] = ["", "restaurant", "school", ... ]
    # initialize le average a 0
    @districts = District.all

    # incrementer le score average selon les criteres selectionnes
    if params[:criteria].include? "restaurant"
      @districts = @districts.each do |district|
        if district.raw_restaurant && district.raw_restaurant.length > 10
          district.average += district.restaurant_score
        else
          district.average = 0
        end
      end
    end

    if params[:criteria].include? "school"
      @districts = @districts.each do |district|
        district.average += district.school_score
      end
    end

    if params[:criteria].include? "park"
      @districts = @districts.each do |district|
        if district.park_raw && district.park_raw.length > 5
        district.average += district.park_score
        else
          district.average = 0
        end
      end
    end

    if params[:criteria].include? "subway_station"
      @districts = @districts.each do |district|
        district.average += district.subway_score*1.5
      end
    end
    if params[:criteria].include? "bixi"
      @districts = @districts.each do |district|
        district.average += district.bixi_score
      end
    end

    if params[:criteria].include? "parking"
      @districts = @districts.each do |district|
        district.average += district.parking_score
      end
    end

    if params[:criteria].include? "quiet"
      @districts = @districts.each do |district|
        district.average += district.quiet_score
      end
    end

    if params[:criteria].include? "dog"
      @districts = @districts.each do |district|
        district.average += district.dog_score
      end
    end

    # # ONLY restaurants:
    # if params[:criteria].includes("restaurant")

    #   restaurant_score = District.all.map do |district|
    #     score = district.restaurant_score

    #     @districts = restaurant_score.sort_by { |district| 1/score }
    #     @district = @districts.first(10)
    #   end
    # end

    # if clicked button is only schools:

    # school_score = District.all.map do |district|
    #   score = district.school_score

    #   @districts = school_score.sort_by { |district| 1/score }
    #   @district = @districts.first(10)
    # end

    # # if clicked buttons are both:

    # resto = District.all.map do |district|
    #   district.restaurant_score
    #   district
    # end

    # averagedistrict = District.all.map do |district|
    #   score = (district.restaurant_score + district.school_score) / 2
    #   district.average = score
    #   district
    # end
    @districts = @districts.sort_by { |district| district.average }
    @districts = @districts.last(10)
    @districts = [] if params[:criteria].count <= 1
    # @districts = @districts.map { |district| { coordinates: district.coordinates, name: district.name, url: "/districts/#{district.id}" } }

    respond_to do |format|
      format.html { render 'districts/index' }
      format.js
    end
  end
end

