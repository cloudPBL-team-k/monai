require 'httpclient'
require 'json'
require 'yahoo.rb'
require 'foursquare.rb'

class OuterApi
  def initialize()
  end

  def get_thing_from_outer_api(jan_code)
    client = HTTPClient.new
    yahoo = Yahoo.new
    request_url = yahoo.create_request(jan_code)
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

  # 緯度経度から周辺にあるFoursquareに登録されているスポットを検索
  def search_shop_with_location(latitude, longitude)
    client = HTTPClient.new
    foursquare = Foursquare.new
    request_url = foursquare.search_with_location_url(latitude, longitude)
    request = client.get(request_url)
    response = JSON.parse(request.body)
    venues = response["response"]["venues"]
    return venues
  end

  # 緯度経度と検索文字列から周辺のスポットを検索
  def search_shop_with_location_and_query(latitude, longitude, query)
    client = HTTPClient.new
    foursquare = Foursquare.new
    request_url = foursquare.search_with_query_url(latitude, longitude, query)
    request = client.get(request_url)
    response = JSON.parse(request.body)
    venues = response["response"]["venues"]
    return venues
  end
end
