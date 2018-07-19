require 'httparty'

class ScaffoldApiWrapper
  class RecipeError < StandardError; end

  API_KEY = ENV["GOOGLE_API_KEY"]

  def self.get_routes(locations)
    start_pt = locations["start_location"]
    end_pt = locations["end_location"]

    start_coords = "#{start_pt["lat"]}, #{start_pt["lng"]}"
    end_coords = "#{end_pt[:lat]}, #{end_pt[:lng]}"

    url="https://maps.googleapis.com/maps/api/directions/json?key=#{API_KEY}&origin=#{start_coords}&destination=#{end_coords}&mode=walking&alternatives=true"

    response = HTTParty.get(url).parsed_response
    return response
  end

  def self.get_routes_names(locations)
    start_coords = locations["start_location"]
    end_coords = locations["end_location"]

    url="https://maps.googleapis.com/maps/api/directions/json?key=#{API_KEY}&origin=#{start_coords}&destination=#{end_coords}&mode=walking&alternatives=true"

    response = HTTParty.get(url).parsed_response
    return response
  end

  private

  def self.raise_on_error(response)
    unless response["count"]
      raise RecipeError.new(response["error"])
    end
  end
end
