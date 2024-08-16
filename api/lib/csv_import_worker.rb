require 'sidekiq'
require_relative 'csv_importer'
require_relative '../app'

class CSVImportWorker
  include Sidekiq::Worker

  def perform(file_path)
    begin
      csv_importer = CSVImporter.new(file_path, Sinatra::Application.settings.db_config)
      csv_importer.import
    ensure
      File.delete(file_path) if File.exist?(file_path)
    end
  end
end
