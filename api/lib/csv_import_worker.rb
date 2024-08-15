require 'sidekiq'
require_relative 'csv_importer'

class CSVImportWorker
  include Sidekiq::Worker

  def perform(file_path)
    puts "CSVImportWorker started with file: #{file_path}"
    csv_importer = CSVImporter.new(file_path)
    csv_importer.import
    puts "CSVImportWorker finished processing file: #{file_path}"
  end
end
