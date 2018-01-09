require 'json'
require 'uri'

class Foursquare
  def initialize()
      @baseurl = "https://api.foursquare.com/v2/venues/search"
      # Load API Key
      File.open(Rails.root.join("lib","app_ids.json").to_s, "r") do |f|
          appids = JSON.load(f)
          foursquare = appids["foursquare"]
          @client_id = foursquare["client_id"]
          @client_secret = foursquare["secret"]
      end
  end

  def search_with_location_url(latitude, longitude)
    uri = URI(@baseurl)
    uri.query = {
      ll: latitude.to_s + "," + longitude.to_s,
      client_id: @client_id,
      client_secret: @client_secret,
      v: 20180109
    }.to_param
    return uri.to_s
  end

  def search_with_query_url(latitude, longitude, query)
    uri = URI(@baseurl)
    escaped_query = URI.escape(query)
    uri.query = {
      ll: latitude.to_s + "," + longitude.to_s,
      client_id: @client_id,
      client_secret: @client_secret,
      v: 20180109
    }.to_param
    return uri.to_s + "&query=" + escaped_query
  end
end
