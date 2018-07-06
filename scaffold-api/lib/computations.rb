
class Computations
  def total_scaffold_distance()
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))


  end

  def self.find_best_route(routes)

    routes.each do |route|
      covered_distance = check_for_scaffold(route["steps"])

      route["covered_distance"] = covered_distance
    end

  end
end
