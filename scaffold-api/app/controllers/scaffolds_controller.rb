class ScaffoldsController < ApplicationController

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

     routes_result = ScaffoldApiWrapper.get_routes(locations)
    #
    # hello = routes_result["routes"]
    #
    # top_route = Computations.find_best_route(routes_result["routes"])

    render json: routes_result
  end

# private
#  def media_params
#    params.require(:work).permit(:title, :author, :description, :publication_year)
#  end
end
