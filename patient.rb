class Patient
  attr_reader :name, :cured, :blood_type
  attr_accessor :room, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @cured = attributes[:cured] || false
    @blood_type = attributes[:blood_type]
  end

  # BEHAVIOR
  def cure
    @cured = true
  end
end

# ben = Patient.new(name: "Ben", cured: false, blood_type: "A")
# g = Patient.new(name: "George")
# p ben.name
# p g
