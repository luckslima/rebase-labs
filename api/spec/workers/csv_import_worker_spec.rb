require 'spec_helper'
require_relative '../../lib/csv_import_worker'
require_relative '../../lib/csv_importer'

RSpec.describe CSVImportWorker do
  let(:file_path) { 'spec/fixtures/test.csv' }
  let(:permanent_path) { './uploads/test.csv' }

  before do
    FileUtils.mkdir_p('./uploads')
    FileUtils.cp(file_path, permanent_path)
  end

  it 'processes the CSV file and inserts data into the database' do
    expect {
      Sidekiq::Testing.inline! do
        CSVImportWorker.perform_async(permanent_path)
      end
    }.to change {
      conn = PG.connect(
        dbname: 'test_database',
        user: 'postgres',
        password: 'password',
        host: 'test_db'
      )
      result = conn.exec("SELECT COUNT(*) FROM tests")
      result[0]['count'].to_i
    }.by(5)
    
    expect(File.exist?(permanent_path)).to be_falsey
  end
end
