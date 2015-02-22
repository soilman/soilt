require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :import_companies => :environment do

    csv_file_path = 'db/fixtures/companies.csv'

    CSV.foreach(csv_file_path) do |row|
      Company.create!({
        :name => row[0]
      })
      puts "Company added up in this piece!"
    end
  end
end

# 'rake csv:import_companies' => to run this rake task

