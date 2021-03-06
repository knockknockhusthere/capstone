class ScaffoldsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))

    render json: scaffolds

  end

  def evaluate_routes

    routes_result = ScaffoldApiWrapper.get_routes_names(scaf_params)
    all_routes_array = routes_result["routes"]

    print_output = Computations.calculate_scaffolding_percentages(routes_result["routes"])
    # results = {results: print_output}

    results_with_region = Computations.calculate_region(routes_result['routes'])
    # render json:routes_result["routes"]
    render json: results_with_region

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
