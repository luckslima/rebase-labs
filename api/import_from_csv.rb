require_relative 'lib/csv_importer'

if ARGV.empty?
  puts "Por favor, forneça o caminho do arquivo CSV como argumento."
  exit
end

file_path = ARGV[0]
db_config = {
  dbname: 'my_database',
  user: 'postgres',
  password: 'password',
  host: 'db'
}

begin
  csv_importer = CSVImporter.new(file_path, db_config)
  csv_importer.import
  puts "Importação concluída!"
rescue StandardError => e
  puts "Erro durante a importação: #{e.message}"
end