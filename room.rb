require_relative "patient"
require "pry"
class Room
  # STATE
  attr_reader :patients
  attr_accessor :id
  def initialize(attributes = {})
    @id = attributes[:id]
    @capacity = attributes[:capacity]
    @patients = attributes[:patients] || []
  end

  # BEHAVIOR
  def add_patient(patient)
    if !full?
      @patients << patient
      patient.room = self
    else
      fail Exception, "Room is full!"
    end
  end

  def full?
    @capacity == @patients.length
  end
end

room = Room.new(capacity: 0)
ben = Patient.new(name: "Ben", cured: false, blood_type: "A")

room.add_patient(ben)
p room.patients

p ben.room








