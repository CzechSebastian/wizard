require "json"
require "rest-client"

response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=45.4831706,-73.6701374&radius=10000&type=restaurant&key=AIzaSyDuAEacEDldR2S-gfL2d5JWMGYzhl28G4g"
results = JSON.parse(response)

last_page_token = results["next_page_token"]

restaurants = []

restaurants << results["results"]


while last_page_token != nil
	sleep 5

	response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyDuAEacEDldR2S-gfL2d5JWMGYzhl28G4g&pagetoken=#{last_page_token}"
	results = JSON.parse(response)

	puts "========================================================================================================="
	p results

	last_page_token = results["next_page_token"]

	restaurants << results["results"]
end

json_string = JSON.pretty_generate(restaurants) 

File.write("#{Time.now.to_i}_restaurant_seed.json", json_string)






