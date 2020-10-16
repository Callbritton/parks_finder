class ParksController < ApplicationController
  def index
    # The params[:state] come from the form in the welcome index.html
    state = params[:state]

    # the url: is the Base URL provided from the API
    conn = Faraday.new(url: "https://developer.nps.gov") do |faraday|
    # The "api_key" name is set by the API. "PARKS_API_KEY" is set
    # by me within the config/application.yml file to keep key secret
    # Pay especial attention to the .params or .headers (specified by API)
      faraday.params["api_key"] = ENV["PARKS_API_KEY"]
    end

    # The "/api/v1..." comes from the Curl provided by the API
    # The interpolation of #{state} is possible by setting
    # state to params[:state] above.
    response = conn.get("/api/v1/parks?stateCode=#{state}")

    # This will improve readability and access of the data within
    parsed = JSON.parse(response.body, symbolize_names: true)

    # Note! @parks takes the (parsed) argument to pass the parsed data
    # to the fetch_state_data method to iterate over it (at which time
    # that data is stored in initialized variables in the Park poros)
    @parks = fetch_state_data(parsed)

  end

  def fetch_state_data(parsed)
    parsed[:data].map do |data|
      Park.new(data)
    end
  end
end
