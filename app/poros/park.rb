class Park
  attr_reader :name, :description, :directions, :hours, :id

  def initialize(data)
    @id = data[:id]
    @name = data[:fullName]
    @description = data[:description]
    @directions = data[:directionsInfo]
    @hours = data[:operatingHours].first[:standardHours]
  end
end
