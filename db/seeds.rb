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
  filepath    = 'Stations_2019.csv'

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
    elsif valid_pet_stores.length > 2
      score = 5
      district.update!(dog_score: score)
      district.update!(dog_raw: valid_pet_stores)
    elsif valid_pet_stores.length == 2
      score = 4
      district.update!(dog_score: score)
      district.update!(dog_raw: valid_pet_stores)
    elsif valid_pet_stores.length == 1
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

mileend = District.find_by(name:"Mile End")
mileend.update!(rent_rate: 990, age: 31, review: "Little known to tourists, this area is really nice. So many activities for the family, very good restaurants and local food stands!@@It’s no surprise the Mile End is included in many of the world’s coolest neighborhoods in the world. With some of the best cafes, restaurants, bars and local independent shops.", home:"Mile End used to be known as just the northwestern corner of the Plateau, but now it is recognized as a separate neighbourhood. This is an ethnically and linguistically diverse district where you’ll hear a combination of English, French, Italian, Portuguese and other languages. Like the Plateau, Mile End also has an artistic vibe, which has given rise to such musicians as Arcade Fire, Grimes, Plants and Animals and more.", photo: File.open("app/assets/images/Mile-End-1.jpg"))

petitebourgogne = District.find_by(name:"Petite-Bourgogne")
petitebourgogne.update!(language: "English", age: 34, rent_rate: 1120, review: "I really love this neighbourhood. There are so much restaurants and bars. I leave near the Atwater Market, it is a really vibrant neighbourhood.@@It’s beautiful, and also has one of the most nicest bike paths in the city which can get you all the way to old Montreal. it’s full of pretty cool people, including tons of musicians, artists, students and young professionals.", home:"The Atwater Market is located at the southwestern corner of the neighbourhood. Little Burgundy is home to the North American arm of Ninja Tune records, many architecture and design offices, new restaurants, as well a longstanding antiques row along Notre-Dame West, formally organized as the 'Quartier des Antiquaires'.")

#description of district
#Le plateau :Originally a working-class francophone area, the Plateau has since evolved into a trendy and artistic neighbourhood that is becoming increasingly gentrified. Still maintaining its bohemian reputation, the Plateau has a youthful vibe and offers a variety of restaurants, cafes, bars, bakeries and trendy shops that have earned its reputation as the hippest area of Montreal.
#Mile-end : Mile End used to be known as just the northwestern corner of the Plateau, but now it is recognized as a separate neighbourhood. This is an ethnically and linguistically diverse district where you’ll hear a mélange of English, French, Italian, Portuguese and other languages. Like the Plateau, Mile End also has an artistic vibe, which has given rise to such musicians as Arcade Fire, Grimes, Plants and Animals and more.
#Hochelaga : Situated south and southwest of Montreal’s Olympic Stadium, the Hochelaga neighbourhood is one of the city’s few districts named for the original First Nations residents. Hochelega was the name of an Iroquoian village visited by French explorer Jacques Cartier in the 1530s, during his first trip along the St. Lawrence River. Nowadays, the population in this up-and-coming neighbourhood is a blend of working class francophones, students and recent immigrants. A notable feature of Hochelaga is Marché Maisonneuve, a public market housed within an early 20th-century stone pavilion.
#Rosemont : After Toronto, Montreal has the second-largest Italian population in Canada, and this long history of immigration has created a dynamic community just north of the Plateau. In this neighbourhood you’ll find a variety of Italian Canadian-owned shops and restaurants, in addition to the dynamic, world-class Jean-Talon Market, one of the oldest public markets in Montreal.
#Vieux-montreal : Vieux Montreal, or Old Montreal, is the most touristic neighbourhood of the city, and it is also the oldest. In this historic district, explore eclectic shops and galleries along narrow, cobble-stoned roadways and marvel at the old, beautiful architecture that dates back to the 17th century.
#Quartier Latien : West of the Village you can find the Quartier Latin, a small area next to the Université du Québec à Montréal (UQAM) campus. This neighbourhood has an energetic atmosphere and houses a concentration of bars, restaurants, theatres and other hangouts. It may be more active in the week hours of the night than by day. In contrast, the Quartier Latin is also home to the impressive Grande Bibliothèque du Quebec.

District.all.each do |district|
  # set_restaurants_score(district)
  # set_schools_score(district)
  # set_subways_score(district)
  # set_parks_score(district)
  # set_bikes_score(district)
  # set_parkings_score(district)
  # set_quiet_score(district)
  # set_dog_score(district)
  # set_bars_score(district)
  # set_cafes_score(district)
  # set_gyms_score(district)
end
