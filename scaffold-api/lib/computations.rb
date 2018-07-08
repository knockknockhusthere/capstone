require 'matrix'

class Computations

  def self.orthogonal_projection(line,scaffold_pt)

    # line = [[3, 7], [8, 13]]
    # scaffold_pt = [4, 9]

    start_pt = line[0]
    end_pt = line[1]

    u_x = end_pt[0] - start_pt[0]
    u_y = end_pt[1] - start_pt[1]
    v_x = scaffold_pt[0] - start_pt[0]
    v_y = scaffold_pt[1] - start_pt[1]

    u = Vector[u_x, u_y]
    v = Vector[v_x, v_y]


    u_norm = (Math.sqrt(u_x**2 + u_y**2))**2
    result = [u,v,u.inner_product(v), u_norm]

    change = (u * (u.inner_product(v) / u_norm)).to_a

    intersect = [start_pt[0] + change[0], start_pt[1] + change[1]]

    return intersect
  end

  def self.distance_between_pts(intersect, scaf)
    lat_diff = intersect[0] - scaf[0]
    lng_diff = intersect[1] - scaf[1]

    distance = Math.sqrt((lat_diff**2) + (lng_diff**2))
    return dist
  end

  def self.total_scaffold_distance(route_steps)
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))

    data = JSON.parse(scaffolds)

    covered_distance = []

    route_steps.each do |step|
      beg_coords = [
        step["start_location"]["lat"], step["start_location"]["lng"]
      ]
      end_coords = [
        step["end_location"]["lat"], step["end_location"]["lng"]
      ]

      line = [beg_coords, end_coords]

      data["data"].each do |scaffold|
        scaf_coords = [
          scaffold["latitude_point"],
          scaffold["longitude_point"]
        ]

        closest_pt = Computations.orthogonal_projection(line, scaf_coords)
        distance_from_route = Computations.distance_between_pts(closest_pt, scaf_coords)

        # covered_distance << results
        # line equation
        # check scaffold distance from line
        # if true, add to covered_distance

      end
    end

    return covered_distance
  end

  def self.calculate_scaffolding_percentages(routes)

    routes.each do |route|
      # covered_distance = total_scaffold_distance(route["legs"][0]["steps"]) * 0.3048
      # # covered_distance of scaffolding in feet, coverted to meters to match google maps
      # total_distance = route["legs"][0]["distance"]["value"]
      #
      # route["covered_percent"] = covered_distance / total_distance

      return Computations.total_scaffold_distance(route["legs"][0]["steps"])
    end

  end
end
