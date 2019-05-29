require "json"
require "rest-client"

# def set_restaurant_score(district)
	response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=45.523791,-73.599567&radius=1000&type=restaurant&key=AIzaSyCts7bn5lhpEAqj4ePBF3zjJkO9m6XSVZw"
	results = JSON.parse(response)

	last_page_token = results["next_page_token"]

	restaurants = []

	restaurants << results["results"]


	while last_page_token != nil
		sleep 2

		response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyCts7bn5lhpEAqj4ePBF3zjJkO9m6XSVZw&pagetoken=#{last_page_token}"
		results = JSON.parse(response)

		last_page_token = results["next_page_token"]

		restaurants << results["results"]
	end

	json_string = JSON.pretty_generate(restaurants) 

# 	district.update()
# end

File.write("#{Time.now.to_i}_restaurant_seed.json", json_string)









