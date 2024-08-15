require 'pg'
require 'csv'

class CSVImporter
  def initialize(file_path)
    @file_path = file_path
    @conn = PG.connect(
      dbname: 'my_database',
      user: 'postgres',
      password: 'password',
      host: 'db'
    )
  end

  def import
    @conn.exec("DROP TABLE IF EXISTS tests") 
    @conn.exec("CREATE TABLE tests (
      id SERIAL PRIMARY KEY,
      cpf VARCHAR(20),
      nome_paciente VARCHAR(100),
      email_paciente VARCHAR(100),
      data_nascimento DATE,
      endereco_rua VARCHAR(100),
      cidade VARCHAR(50),
      estado VARCHAR(50),
      crm_medico VARCHAR(20),
      crm_medico_estado VARCHAR(5),
      nome_medico VARCHAR(100),
      email_medico VARCHAR(100),
      token_resultado_exame VARCHAR(20),
      data_exame DATE,
      tipo_exame VARCHAR(50),
      limites_tipo_exame VARCHAR(20),
      resultado_tipo_exame VARCHAR(20)
    )")

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
