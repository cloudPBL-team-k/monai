require 'httpclient'
require 'json'
require 'yahoo.rb'

class OuterApi
  def initialize()
  end

  def get_thing_from_outer_api(jan_code)
    client = HTTPClient.new
    yahoo = Yahoo.new
    request_url = yahoo.create_request(jan_code)
    puts(request_url)
    request = client.get(request_url)
    response = JSON.parse(request.body)
    result_set = response["ResultSet"]
    total_result_available = result_set["totalResultsAvailable"]
    total_result_returned = result_set["totalResultsReturned"]
    if total_result_available.to_i != 0 || total_result_returned.to_i != 0
      first_result_position = result_set["firstResultPosition"]
      api_thing = result_set["0"]["Result"][first_result_position]
      thing = Thing.new
      thing.name = api_thing["Name"]
      thing.jancode = jan_code
      return thing
    end
    return nil
  end
end
