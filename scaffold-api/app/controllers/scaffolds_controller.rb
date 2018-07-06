require 'pry'

class ScaffoldsController < ApplicationController
  # def root
  # end

  def index
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))

    # locations = params[:query]

    locations = {
      "start_location": {
        "lat": 40.7551951,
        "lng": -73.98390049999999
      },
      "end_location": {
        "lat": 40.7699309,
        "lng": -73.99268739999999
      }
    }

    # routes_result = ScaffoldApiWrapper.get_routes(locations)
    #
    # hello = routes_result["routes"]
    #
    # top_route = Computations.find_best_route(routes_result["routes"])

    render json: scaffolds
  end
end
