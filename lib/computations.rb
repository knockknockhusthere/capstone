require 'matrix'

LATITUDE_DEGREE = 111321.4944
# 365,228ft in 1 degree latitude, differences across longitude is negligible
# converted to meters to match GMAPS = 111,321.5
LONGITUDE_DEGREE = 110639.814778621
#cosine of latitude, using 40.73 as an estimate for NYC
#multiplied by 69.172 miles, converted to meters (1609.34 meters per mile)
MAX_DIFF = 7.62
# 7.62m is roughly 25ft
METERS_PER_FT = 0.3048

class Computations

  def self.calculate_scaffolding_percentages(routes)

    routes.each do |route|
      covered_distance = total_scaffold_distance(route["legs"][0]["steps"])
      # covered_distance of scaffolding in meters

      total_distance = route["legs"][0]["distance"]["value"]
      route["covered_percent"] = covered_distance / total_distance

      # return "covered_distance is #{covered_distance}, total route distance is #{total_distance}. Therefore the percentage covered is: #{'%.2f' % ((covered_distance / total_distance) * 100) }%!"
    end

    return routes
  end

  def self.orthogonal_projection(line,scaffold_pt)

    #line = [[3, 7], [8, 13]]
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
    # result = [u, v, u.inner_product(v), u_norm]

    change = (u * (u.inner_product(v) / u_norm)).to_a

    intersect = [start_pt[0] + change[0], start_pt[1] + change[1]]

    return intersect
  end

  def self.distance_between_pts(intersect, scaf)
    lat_diff = (intersect[0] - scaf[0]) * LATITUDE_DEGREE
    lng_diff = (intersect[1] - scaf[1]) * LONGITUDE_DEGREE

    distance = Math.sqrt((lat_diff**2) + (lng_diff**2))
    return distance
  end

  def self.total_scaffold_distance(route_steps)
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))

    data = JSON.parse(scaffolds)

    covered_distance = 0

    route_steps.each do |step|
      beg_coords = [
        step["start_location"]["lat"], step["start_location"]["lng"]
      ]
      end_coords = [
        step["end_location"]["lat"], step["end_location"]["lng"]
      ]

      line = [beg_coords, end_coords]

      step_covered_distance = 0

      data["data"].each do |scaffold|
        scaf_coords = [
          scaffold["latitude_point"],
          scaffold["longitude_point"]
        ]

        closest_pt = Computations.orthogonal_projection(line, scaf_coords)
        distance_from_route = Computations.distance_between_pts(closest_pt, scaf_coords)

        if distance_from_route < MAX_DIFF

          step_covered_distance += scaffold["sidewalk_shed_linear_feet"] * METERS_PER_FT
        end
      end

      add_dist = step_covered_distance < step['distance']['value'] ? step_covered_distance : step['distance']['value']
      covered_distance += add_dist
    end

    return covered_distance.to_f
  end

  def self.calculate_region(routes_data)
    latitudes = []
    longitudes = []

    lat_sum = 0
    lng_sum = 0

    routes_num = routes_data.length

    routes_data.each do |route|

      northeast = route['bounds']['northeast']
      southwest = route['bounds']['southwest']

      latitudes << northeast['lat']
      latitudes << southwest['lat']
      longitudes << northeast['lng']
      longitudes << southwest['lng']

      mid_lat = (northeast['lat'] + southwest['lat']) / 2
      mid_lng = (northeast['lng'] + southwest['lng']) / 2

      lat_sum += mid_lat
      lng_sum += mid_lng
    end

    min_lat = latitudes.min
    min_lng = longitudes.min
    max_lat = latitudes.max
    max_lng = longitudes.max

    routes_data.each do |route|

      route['region'] = {
          'latitude' => (lat_sum / routes_num),
          'longitude' => (lng_sum / routes_num),
          'latitudeDelta' => ((max_lat - min_lat) * 1.10),
          'longitudeDelta' => ((max_lng - min_lng) * 1.10)
          # 10% increase to create a border
      }
    end
    return routes_data
  end

end
