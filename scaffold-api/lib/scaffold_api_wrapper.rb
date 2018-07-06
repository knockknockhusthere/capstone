require 'httparty'

class ScaffoldApiWrapper

  API_KEY = ENV["GOOGLE_API_KEY"]

  def self.get_routes(locations)
    start_pt = locations[:start_location]
    end_pt = locations[:end_location]

    start_coords = "#{start_pt[:lat]}, #{start_pt[:lng]}"
    end_coords = "#{end_pt[:lat]}, #{end_pt[:lng]}"

    url="https://maps.googleapis.com/maps/api/directions/json?key=#{API_KEY}&origin=#{start_coords}&destination=#{end_coords}&mode=walking&alternatives=true"

    response = HTTParty.get(url).parsed_response
    return response
  end

end
