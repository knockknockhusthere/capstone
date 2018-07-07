
class Computations

  def orthogonal_projection(line,scaffold)

  end

  def total_scaffold_distance(route_steps)
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))
    #
    # covered_distance = 0
    #
    # route_steps.each do |step|
    #   beg_coords = [
    #     step["start_location"]["lat"], step["start_location"]["lng"]
    #   ]
    #   end_coords = [
    #     step["end_location"]["lat"], step["end_location"]["lng"]
    #   ]
    #
    #   line = [beg_coords, end_coords]
    #   puts "for line (#{line}), please compute all coords:"
    #   scaffolds["data"].each do |scaffold|
    #     scaf_coords = [
    #       scaffold["latitude_point"],
    #       scaffold["longitude_point"]
    #     ]
    #
    #     puts "scaffold coordinates: #{scaf_coords}"
        # orthogonal_projection(line, scaf_coords)
        #line equation
        # check scaffold distance from line
        # if true, add to covered_distance
        return scaffolds
    #   end
    # end

    # return covered_distance
  end

  def calculate_scaffolding_percentages(routes)

    routes.each do |route|
      # covered_distance = total_scaffold_distance(route["legs"][0]["steps"]) * 0.3048
      # # covered_distance of scaffolding in feet, coverted to meters to match google maps
      # total_distance = route["legs"][0]["distance"]["value"]
      #
      # route["covered_percent"] = covered_distance / total_distance

      Computations.total_scaffold_distance(route["legs"][0]["steps"])
    end

  end
end
