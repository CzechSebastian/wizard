require "json"
require "rest-client"

response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=45.523791,-73.599567&radius=1000&type=restaurant&key=#{ENV["GOOGLE_API_KEY"]}"
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

json_string = JSON.pretty_generate(restaurants) 

# File.write("#{Time.now.to_i}_restaurant_seed.json", json_string)







