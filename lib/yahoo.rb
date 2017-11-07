require 'json'

class Yahoo
  def initialize()
      @baseurl = "https://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch"
      # Load API Key
      File.open(Rails.root.join("lib","app_ids.json").to_s, "r") do |f|
          appids = JSON.load(f)
          yahoo = appids["yahoo"]
          @app_id = yahoo["app_id"]
      end
  end

  def create_request(jan_code)
    return @baseurl + "?appid=" + @app_id + "&jan=" + jan_code
  end
end
