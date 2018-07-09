require "csv"
require_relative "patient"

class PatientsRepository
  def initialize(csv_file_path, rooms_repository)
    @rooms_repository = rooms_repository
    @csv_file_path = csv_file_path
    @patients = []
    @next_id = 1
    load_csv
  end

  def add_patient(patient)
    patient.id = @next_id
    @patients << patient
    @next_id += 1
  end

  def all
    @patients
  end

  private

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["id", "name", "cured", "blood_type", "room_id"]
      @patients.each do |patient|
        csv << [patient.id, patient.name, patient.cured, patient.blood_type, patient.room.id ]
      end
    end
  end


  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:cured] = row[:cured] == "true"
      @next_id = row[:id]
      patient = Patient.new(row)
      # row[:room_id] # => "1"
      room = @rooms_repository.find(row[:room_id].to_i)
      room.add_patient(patient)

      @patients << patient
    end
    @next_id += 1
  end
end

repo = PatientsRepository.new("patients.csv")
# p repo.all
a = Patient.new(name: "Arthur")

repo.add_patient(a)


p repo.all.first.room






