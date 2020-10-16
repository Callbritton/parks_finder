class ParkService
  def self.park_information(state)
    response = conn.get("/api/v1/parks?stateCode=#{state}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    #moved wholesale from the controller
    Faraday.new(url: "https://developer.nps.gov") do |faraday|
      faraday.params["api_key"] = ENV["PARKS_API_KEY"]
    end
  end

end
