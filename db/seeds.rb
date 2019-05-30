require "json"

puts 'Cleaning database...'
District.destroy_all
puts 'Creating districts seed...'

file = File.read('quartierreferencehabitation.geojson')

districts = JSON.parse(file)

districts["features"].each do |district|

	name = district["properties"]["nom_qr"]
	coordinates = district["geometry"]["coordinates"][0][0]

	location_latitude = coordinates.map do |coordinate|
		coordinate.last
	end

	location_longitude = coordinates.map do |coordinate|
		coordinate.first
	end

	middle_long = (location_longitude.min + location_longitude.max) / 2
	middle_lat = (location_latitude.min + location_latitude.max) / 2

	location = [middle_long, middle_lat] 
	# if district["center"] != nil
		District.create!(name:name, coordinates:coordinates, location:location)
	# else
	# 	District.create!(name:name, coordinates:coordinates, location:district["center"])
	# end

end

#THIS IS THE CODE FOR RESTAURANT SCORE!

def set_restaurants_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1000&type=restaurant&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  restaurants = []

  restaurants << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    restaurants << results["results"]
  end
  
	  puts district.name
	  valid_restaurants = restaurants.flatten.select do |restaurant|
	    !restaurant["rating"].nil? && district.contains_point?([(restaurant["geometry"]["location"]["lng"]).to_f,(restaurant["geometry"]["location"]["lat"]).to_f])
  	end
	 if valid_restaurants.length != 0
    district.update(raw_restaurant: valid_restaurants)

	  number = valid_restaurants.count
	  puts district.name
	  puts number

	  sum = 0
	  valid_restaurants.each do |restaurant|
	    sum += restaurant["rating"]
	  end

	  average = sum/number
	  puts average
	  district.update(restaurant_score: average)

	else
		puts "This one has 0 places"
		average = 0
		district.update(restaurant_score: average)
  end
end

 # TODO THIS IS THE CODE FOR SCHOOL SCORE









