require 'pg'
require 'csv'

class CSVImporter
  def initialize(file_path, db_config)
    @file_path = file_path
    @conn = PG.connect(db_config)
  end

  def import
    CSV.foreach(@file_path, headers: true, col_sep: ';') do |row|
      begin
        @conn.exec_params(
          "INSERT INTO tests (
            cpf, nome_paciente, email_paciente, data_nascimento, endereco_rua, cidade, estado,
            crm_medico, crm_medico_estado, nome_medico, email_medico, token_resultado_exame,
            data_exame, tipo_exame, limites_tipo_exame, resultado_tipo_exame
          ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)",
          [
            row['cpf'], row['nome paciente'], row['email paciente'], row['data nascimento paciente'],
            row['endereço/rua paciente'], row['cidade paciente'], row['estado patiente'], row['crm médico'],
            row['crm médico estado'], row['nome médico'], row['email médico'], row['token resultado exame'],
            row['data exame'], row['tipo exame'], row['limites tipo exame'], row['resultado tipo exame']
          ]
        )
      rescue PG::Error => e
        puts "Erro ao inserir linha: #{e.message}"
      end
    end
  end
end