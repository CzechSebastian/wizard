require "json"
require 'csv'

# puts 'Cleaning database...'
# District.destroy_all
# puts 'Creating districts seed...'

# file = File.read('quartierreferencehabitation.geojson')

# districts = JSON.parse(file)

# districts["features"].each do |district|

# 	name = district["properties"]["nom_qr"]
# 	coordinates = district["geometry"]["coordinates"][0][0]

# 	location_latitude = coordinates.map do |coordinate|
# 		coordinate.last
# 	end

# 	location_longitude = coordinates.map do |coordinate|
# 		coordinate.first
# 	end

# 	middle_long = (location_longitude.min + location_longitude.max) / 2
# 	middle_lat = (location_latitude.min + location_latitude.max) / 2

# 	location = [middle_long, middle_lat]
# 	# if district["center"] != nil
# 		District.create!(name:name, coordinates:coordinates, location:location)
# 	# else
# 	# 	District.create!(name:name, coordinates:coordinates, location:district["center"])
# 	# end

# end

# THIS IS THE CODE FOR RESTAURANT SCORE

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
    district.update!(raw_restaurant: valid_restaurants)

	  number = valid_restaurants.count
	  puts number

	  sum = 0
	  valid_restaurants.each do |restaurant|
	    sum += restaurant["rating"]
	  end

	  average = sum/number
	  puts average
	  district.update!(restaurant_score: average)

	else
		puts "This one has 0 places"
		average = 0
		district.update!(restaurant_score: average)
  end
end

"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

 # THIS IS THE CODE FOR SCHOOL SCORE

def set_schools_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1000&type=school&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  schools = []

  schools << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    schools << results["results"]
  end

    valid_schools = schools.flatten.select do |school|
      !school["rating"].nil? && district.contains_point?([(school["geometry"]["location"]["lng"]).to_f,(school["geometry"]["location"]["lat"]).to_f])
    end
   if valid_schools.length != 0
    district.update!(school_raw: valid_schools)

    number = valid_schools.count
    puts district.name
    puts number

    sum = 0
    valid_schools.each do |school|
      sum += school["rating"]
    end

    average = sum/number
    puts average
    district.update!(school_score: average)

  else
    puts "This one has 0 places"
    average = 0
    district.update!(school_score: average)
  end
end


"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

#  # THIS IS THE CODE FOR SUBWAY SCORE


def set_subways_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1500&type=subway_station&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  subways = []

  subways << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    subways << results["results"]
  end

    valid_subways = subways.flatten.select do |subway|
      district.contains_point?([(subway["geometry"]["location"]["lng"]).to_f,(subway["geometry"]["location"]["lat"]).to_f])
    end

    if valid_subways.length >= 2
      score = 5
      district.update!(subway_score: score)
      district.update!(subway_raw: valid_subways)
    elsif valid_subways.length == 1
      score = 3
      district.update!(subway_score: score)
      district.update!(subway_raw: valid_subways)
    elsif valid_subways.length == 0
      score = 0
      district.update!(subway_score: score)
      district.update!(subway_raw: valid_subways)
    end
    puts district.name
    puts district.subway_score
end


"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

# THIS IS THE CODE FOR PARK SCORE

def set_parks_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1000&type=park&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  parks = []

  parks << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    parks << results["results"]
  end

    valid_parks = parks.flatten.select do |park|
      !park["rating"].nil? && district.contains_point?([(park["geometry"]["location"]["lng"]).to_f,(park["geometry"]["location"]["lat"]).to_f])
    end
   if valid_parks.length != 0
    district.update!(park_raw: valid_parks)

    number = valid_parks.count
    puts district.name
    puts number

    sum = 0
    valid_parks.each do |park|
      sum += park["rating"]
    end

    average = sum/number
    puts average
    district.update!(park_score: average)

  else
    puts "This one has 0 places"
    average = 0
    district.update!(park_score: average)
  end
end


"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="


# THIS IS THE CODE FOR PARK SCORE

def set_bikes_score(district)
  bixis = []

  csv_options = { col_sep: ',', headers: :first_row }
  filepath    = 'stations_2019.csv'

  CSV.foreach(filepath, csv_options) do |row|
    bixis << row
  end

  valid_bixis = bixis.flatten.select do |row|
    district.contains_point?([(row['longitude']).to_f,(row['latitude']).to_f])
  end

  district.update!(bixi_raw: valid_bixis)

  puts district.name
  puts valid_bixis.length

    if valid_bixis.length == 0
      score = 0
      district.update!(bixi_score: score)
    elsif valid_bixis.length > 15
      score = 5
      district.update!(bixi_score: score)
    elsif valid_bixis.length > 10
      score = 4
      district.update!(bixi_score: score)
    elsif valid_bixis.length > 5
      score = 3
      district.update!(bixi_score: score)
    elsif valid_bixis.length > 1
      score = 2
      district.update!(bixi_score: score)
    end
    puts district.bixi_score
end

"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

def set_parkings_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1500&type=parking&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  parkings = []

  parkings << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    parkings << results["results"]
  end

    valid_parkings = parkings.flatten.select do |parking|
      district.contains_point?([(parking["geometry"]["location"]["lng"]).to_f,(parking["geometry"]["location"]["lat"]).to_f])
    end


    if valid_parkings.length == 0
      score = 0
      district.update!(parking_score: score)
      district.update!(parking_raw: valid_parkings)
    elsif valid_parkings.length > 10
      score = 5
      district.update!(parking_score: score)
      district.update!(parking_raw: valid_parkings)
    elsif valid_parkings.length > 5
      score = 3
      district.update!(parking_score: score)
      district.update!(parking_raw: valid_parkings)
    elsif valid_parkings.length > 1
      score = 1
      district.update!(parking_score: score)
      district.update!(parking_raw: valid_parkings)
    end
    puts district.name
    puts district.parking_score
end

"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

def set_quiet_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1500&type=night_club&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  night_clubs = []

  night_clubs << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    night_clubs << results["results"]
  end

    valid_night_clubs = night_clubs.flatten.select do |night_club|
      district.contains_point?([(night_club["geometry"]["location"]["lng"]).to_f,(night_club["geometry"]["location"]["lat"]).to_f])
    end

      district.update!(quiet_raw: valid_night_clubs)
puts valid_night_clubs
    if valid_night_clubs.length == 0
      score = 5
      district.update!(quiet_score: score)
    elsif valid_night_clubs.length > 20
      score = 0
      district.update!(quiet_score: score)
    elsif valid_night_clubs.length > 15
      score = 1
      district.update!(quiet_score: score)
    elsif valid_night_clubs.length > 10
      score = 2
      district.update!(quiet_score: score)
    elsif valid_night_clubs.length > 5
      score = 3
      district.update!(quiet_score: score)
    elsif valid_night_clubs.length > 1
      score = 4
      district.update!(quiet_score: score)
    end
    puts district.name
    puts district.quiet_score
end

"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

def set_dog_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1500&type=pet_store&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  pet_stores = []

  pet_stores << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    pet_stores << results["results"]
  end

    valid_pet_stores = pet_stores.flatten.select do |pet_store|
      district.contains_point?([(pet_store["geometry"]["location"]["lng"]).to_f,(pet_store["geometry"]["location"]["lat"]).to_f])
    end


    if valid_pet_stores.length == 0
      score = 0
      district.update!(dog_score: score)
      district.update!(dog_raw: valid_pet_stores)
    elsif valid_pet_stores.length > 3
      score = 5
      district.update!(dog_score: score)
      district.update!(dog_raw: valid_pet_stores)
    elsif valid_pet_stores.length > 2
      score = 4
      district.update!(dog_score: score)
      district.update!(dog_raw: valid_pet_stores)
    elsif valid_pet_stores.length > 1
      score = 3
      district.update!(dog_score: score)
      district.update!(dog_raw: valid_pet_stores)
    end
    puts district.name
    puts district.dog_score
end

"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

def set_bars_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1500&type=bar&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  bars = []

  bars << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    bars << results["results"]
  end

    valid_bars = bars.flatten.select do |bar|
      district.contains_point?([(bar["geometry"]["location"]["lng"]).to_f,(bar["geometry"]["location"]["lat"]).to_f])
    end
      district.update!(bar_raw: valid_bars)

puts district.name
puts valid_bars.length
end

"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

def set_cafes_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1500&type=cafe&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  cafes = []

  cafes << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    cafes << results["results"]
  end

    valid_cafes = cafes.flatten.select do |cafe|
      district.contains_point?([(cafe["geometry"]["location"]["lng"]).to_f,(cafe["geometry"]["location"]["lat"]).to_f])
    end
      district.update!(cafe_raw: valid_cafes)

puts district.name
puts valid_cafes.length
end

"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="
def set_gyms_score(district)
  arr_location = district.location
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{arr_location[1]},#{arr_location[0]}&radius=1500&type=gym&key=#{ENV["GOOGLE_API_KEY"]}"
  response = RestClient.get url
  results = JSON.parse(response)

  last_page_token = results["next_page_token"]

  gyms = []

  gyms << results["results"]

  while last_page_token != nil
    sleep 2

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV["GOOGLE_API_KEY"]}&pagetoken=#{last_page_token}"
    results = JSON.parse(response)

    last_page_token = results["next_page_token"]

    gyms << results["results"]
  end

    valid_gyms = gyms.flatten.select do |gym|
      district.contains_point?([(gym["geometry"]["location"]["lng"]).to_f,(gym["geometry"]["location"]["lat"]).to_f])
    end
      district.update!(gym_raw: valid_gyms)

puts district.name
puts valid_gyms.length
end

"=============================================================================================================================================================================================================================="


"=============================================================================================================================================================================================================================="

District.all.each do |district|
  set_restaurants_score(district)
  set_schools_score(district)
  set_subways_score(district)
  set_parks_score(district)
  set_bikes_score(district)
  set_parkings_score(district)
  set_quiet_score(district)
  set_dog_score(district)
  set_bars_score(district)
  set_cafes_score(district)
  set_gyms_score(district)
end
