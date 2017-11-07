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
    puts(response["ResultSet"]["0"]["Result"]["0"])
    thing = Thing.new
    # TODO ひどいデータの取り出し方なので良い感じに
    thing.name = response["ResultSet"]["0"]["Result"]["0"]["Name"]
    thing.jancode = jan_code
    return thing
  end
end
