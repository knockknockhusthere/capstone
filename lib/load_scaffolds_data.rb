require 'json'
require 'open-uri'
require 'httparty'

URL = 'https://maps.googleapis.com/maps/api/directions/json?key=AIzaSyDHdXHS6ynAo-86jHWfE-WnJJgKM5R7qjs&origin=40.7699479,-73.9909748&destination=40.7554261,-73.9866257&mode=walking&alternatives=true'

class LoadScaffoldsData

  def self.load_scaffolds()
    uri = URI.parse('http://timothymartin76.cartodb.com/api/v2/sql?q=SELECT%20*%20FROM%20active_sheds2&amp;format=CSV')
    str = uri.read
    json = JSON.parse(str, :headers=>true)

    scaffold_entry = {}

    scaffolds = json["rows"]

    return scaffolds
  end

  def self.load_manhattan()
    all_scaffolds = LoadScaffoldsData.load_scaffolds()

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

  def self.write_file()
    response = ""
    json_data = {}

    json_data["data"] = LoadScaffoldsData.load_manhattan()

    file_location = File.join(Rails.root, 'lib', 'assets', 'scaffolds.json')

    File.open(file_location,"w") do |file|
      file.write(json_data.to_json)
      response += "JSON file updated"
      file.close
      response += " and closed! "
    end

    response += "\n There are currently #{ json_data['data'].length } active sidewalk sheds in Manhattan."
    return response
  end
end

# def parse_scaffolds()
#
# end
#
# def send_to_api()
#   response = HTTParty.get(URL).parsed_response
#   return response
# end
