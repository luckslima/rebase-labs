CREATE TABLE IF NOT EXISTS tests (
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
);
