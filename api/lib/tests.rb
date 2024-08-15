require 'pg'

class Tests
  def initialize(db_connection)
    @conn = db_connection
  end

  def all
    result = @conn.exec("SELECT * FROM tests")
    grouped_tests = group_by_token(result)
    grouped_tests
  end

  def find_by_token(token)
    result = @conn.exec_params("SELECT * FROM tests WHERE token_resultado_exame = $1", [token])
    grouped_tests = group_by_token(result)
    grouped_tests.first
  end

  private

  def group_by_token(result)
    grouped = result.each_with_object({}) do |row, hash|
      token = row['token_resultado_exame']
      hash[token] ||= {
        "result_token" => token,
        "result_date" => row['data_exame'],
        "cpf" => row['cpf'],
        "name" => row['nome_paciente'],
        "email" => row['email_paciente'],
        "birthday" => row['data_nascimento'],
        "doctor" => {
          "crm" => row['crm_medico'],
          "crm_state" => row['crm_medico_estado'],
          "name" => row['nome_medico']
        },
        "tests" => []
      }
      hash[token]["tests"] << {
        "type" => row['tipo_exame'],
        "limits" => row['limites_tipo_exame'],
        "result" => row['resultado_tipo_exame']
      }
    end
    grouped.values
  end
end
