
class Computations
  def total_scaffold_distance(route_steps)
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))

    covered_distance = 0

    route_steps.each do |step|
      scaffolds["data"].each do |scaffold|
        #line equation
        # check scaffold distance from line
        # if true, add to covered_distance
      end
    end

    return covered_distance
  end

  def self.calculate_scaffolding_percentages(routes)

    routes.each do |route|
      covered_distance = check_for_scaffold(route["legs"][0]["steps"]) * 0.3048
      # covered_distance of scaffolding in feet, coverted to meters to match google maps
      total_distance = route["legs"][0]["distance"]["value"]

      route["covered_percent"] = covered_distance / total_distance
    end

  end
end
