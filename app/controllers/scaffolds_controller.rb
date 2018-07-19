class ScaffoldsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))

    render json: scaffolds

  end

  def evaluate_routes

  # beg: 40.7551951, -73.98390049999999
  # end:  40.7699309, -73.99268739999999

    # locations = {
    #   "start_location": {
    #     "lat": 40.7551951,
    #     "lng": -73.98390049999999
    #   },
    #   "end_location": {
    #     "lat": 40.7699309,
    #     "lng": -73.99268739999999
    #   }
    # }
    #
    # locations = {
    #   start_location: "1 Bryant Park, New York",
    #   end_location: "Madison Square Park"
    # }

    # locations = scaf_params
    #
    routes_result = ScaffoldApiWrapper.get_routes_names(scaf_params)

    # routes_result = ScaffoldApiWrapper.get_routes(params[:start_location],params[:end_location])
    print_output = Computations.calculate_scaffolding_percentages(routes_result["routes"])
    results = {results: print_output}

    render json: results
    # render json: params[:start_location]
    # render json: locations

  end

  def update_data()
    response = {response: LoadScaffoldsData.write_file()}

    render json: response
  end


private

  def scaf_params
    params.permit(:start_location, :end_location)
  end

end
