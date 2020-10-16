class SearchFacade
  def self.fetch_state_data(state)
    # Change argument to state to receive params[:state] from controller
    # Add ParkService.park_information to tie in service
    parsed = ParkService.park_information(state)
    
    parsed[:data].map do |data|
      Park.new(data)
    end
  end
end
