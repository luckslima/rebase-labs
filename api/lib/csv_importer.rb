require 'pg'
require 'csv'

class CSVImporter
  def initialize(tempfile)
    @tempfile = tempfile
    @conn = PG.connect(
      dbname: 'my_database',
      user: 'postgres',
      password: 'password',
      host: 'db'
    )
  end

  def import
    CSV.foreach(@tempfile, headers: true, col_sep: ';') do |row|
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
    end
  end
end
