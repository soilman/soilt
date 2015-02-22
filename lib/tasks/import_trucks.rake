require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :import_trucks => :environment do

    csv_file_path = 'db/fixtures/trucks.csv'

    CSV.foreach(csv_file_path) do |row|
      truck_count = 1
      Truck.create!({
        :company_id => row[0],
        :number => row[1],       
        :plate => row[2]       
      })
      truck_count += 1
      puts "Truck number #{truck_count} added!"
    end
  end
end

# 'rake csv:import_trucks' => to run this rake task
