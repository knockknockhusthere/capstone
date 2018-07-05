require 'json'
require 'open-uri'
require 'pry'


def load_scaffolds
  uri = URI.parse('http://timothymartin76.cartodb.com/api/v2/sql?q=SELECT%20*%20FROM%20active_sheds2&amp;format=CSV')
  str = uri.read
  json = JSON.parse(str, :headers=>true)


  scaffold_entry = {}

  scaffolds = json["rows"]

  return scaffolds
end

def load_manhattan
  all_scaffolds = load_scaffolds

  manhattan_scaffolds = all_scaffolds.select { |scaf|
    scaf["borough_name"] == "MANHATTAN"
  }

  trimmed_manhattan_scaffolds = []

  manhattan_scaffolds.map { |scaf|
    scaf.delete("the_geom")
    scaf.delete("the_geom_webmercator")
    scaf.delete("job_number")
    scaf.delete("count_permits")
    scaf.delete("age")
    scaf.delete("permit_expiration_date")
    scaf.delete("construction_material")
    scaf.delete("bin_number")
    scaf.delete("community_board")
    scaf.delete("block")
    scaf.delete("lot")
    scaf.delete("applicant_business_name")
    scaf.delete("procert")
    scaf.delete("source")
    scaf.delete("activity")

    trimmed_manhattan_scaffolds << scaf
  }

  return trimmed_manhattan_scaffolds
end

json_data = {}

json_data["data"] = load_manhattan

File.open("./scaffolds.json","w") do |file|
  file.write(json_data.to_json)
  puts "json file updated!"
end
