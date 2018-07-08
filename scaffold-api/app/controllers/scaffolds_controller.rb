class ScaffoldsController < ApplicationController

  def index
    # scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))
    #
    # render json: scaffolds

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

    routes_result = ScaffoldApiWrapper.get_routes(locations)

    # render json: routes_result

    print_output = Computations.calculate_scaffolding_percentages(routes_result["routes"])

    render json: print_output

  end
end
