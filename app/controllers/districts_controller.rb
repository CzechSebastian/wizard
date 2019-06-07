class DistrictsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
  end

  def show
    @districts = District.all
    @district = District.find(params[:id])
    session[:top_districts] = session[:top_districts].reject { |id| id.to_i == params[:id].to_i }.reverse.first(3)

    if session[:top_districts].length == 2 && params[:original_suggestion].present?
      session[:top_districts].push(params[:original_suggestion])
    end

  	if @district.raw_restaurant == nil
  		 @restaurant_coordinates = []
  	else
  		 @restaurant_coordinates = @district.raw_restaurant.map do |restaurant_hash|
        if !restaurant_hash["photos"].nil?
          reference = restaurant_hash["photos"][0]["photo_reference"]
          photo_url = "https://maps.googleapis.com/maps/api/place/photo?photoreference=#{reference}&maxwidth=400&key=#{ENV["GOOGLE_API_KEY"]}"
        end
        {
          lat: restaurant_hash["geometry"]["location"]["lat"],
          lng: restaurant_hash["geometry"]["location"]["lng"],
          infoWindow: render_to_string(partial: "infowindow", locals: { form_data: restaurant_hash, category: "restaurant", photo_url: photo_url }),
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
          infoWindow: render_to_string(partial: "infowindow", locals: { form_data: school_hash, category: "school" }),
          category: "schools"
        }
			end
		end

		if @district.bar_raw == nil
  		@bar_coordinates = []
  	else
  		@bar_coordinates = @district.bar_raw.map do |bar_hash|
        {
          lat: bar_hash["geometry"]["location"]["lat"],
          lng: bar_hash["geometry"]["location"]["lng"],
          infoWindow: render_to_string(partial: "infowindow", locals: { form_data: bar_hash, category: "bar" }),
          category: "bars"
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
          infoWindow: render_to_string(partial: "infowindow", locals: { form_data: subway_hash, category: "subway" }),
          category: "subways"
        }
			end
		end

    if @district.cafe_raw == nil
      @cafe_coordinates = []
    else
      @cafe_coordinates = @district.cafe_raw.map do |cafe_hash|
        {
          lat: cafe_hash["geometry"]["location"]["lat"],
          lng: cafe_hash["geometry"]["location"]["lng"],
          infoWindow: render_to_string(partial: "infowindow", locals: { form_data: cafe_hash, category: "cafe" }),
          category: "coffees"
        }
      end
    end

    if @district.gym_raw == nil
      @gym_coordinates = []
    else
      @gym_coordinates = @district.gym_raw.map do |gym_hash|
        {
          lat: gym_hash["geometry"]["location"]["lat"],
          lng: gym_hash["geometry"]["location"]["lng"],
          infoWindow: render_to_string(partial: "infowindow", locals: { form_data: gym_hash, category: "gym" }),
          category: "gyms"
        }
      end
    end

    if @district.bixi_raw == nil
      @bixi_coordinates = []
    else
      @bixi_coordinates = @district.bixi_raw.map do |bixi_hash|

        {

          lat: bixi_hash[2][1],
          lng: bixi_hash[3][1],
          infoWindow: render_to_string(partial: "infowindow", locals: { form_data: bixi_hash, category: "bixi" }),
          category: "bixis"
        }
      end
    end

    @reviews = [
      { name: "Martin", image: "martin.jpg" },
      { name: "Sebastian", image: "seb.jpg" },
      { name: "Stephane", image: "stephane.jpeg" },
      { name: "Stephanie", image: "steph.jpg" }
    ].sample(2)
  end


  def new
  end
end
