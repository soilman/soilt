require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :import_facilities => :environment do

    csv_file_path = 'db/fixtures/facilities.csv'

    CSV.foreach(csv_file_path) do |row|
      Facility.create!({
        :name => row[0]
      })
      puts "Facility added up in this piece!"
    end
  end
end

# 'rake csv:import_companies' => to run this rake task

