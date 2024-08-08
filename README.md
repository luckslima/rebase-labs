<div align="center">

  <h1 align="center">Desafio Rebase Labs</h1>

  <p align="justify">
    Projeto desenvolvido durante o Rebase Labs da turma 12.
    <br/>
  </p>
</div>

## Sobre o Projeto

Uma aplicação web para listagem de exames médicos.

### Tecnologias 

- Docker
- Ruby
- Javascript
- HTML
- CSS

## API

### Como Rodar? :arrow_forward:

- No terminal, clone o projeto:

  > git clone git@github.com:luckslima/rebase-labs.git

- Dentro da pasta do projeto, acesse a pasta da API:

  > cd api/

- Em seguida construa e inicie os containers:

  > docker-compose up

- E logo após importe o CSV para o banco de dados:

  > docker-compose exec app ruby import_from_csv.rb

Pronto! Agora é possível acessar a aplicação através da rota http://localhost:4567/ :wink:

### Endpoints

- 'GET /tests' 

> Nesse endpoint é retornado uma listagem de todos os exames médicos importados do CSV no formato JSON.

Exemplo de resposta:
```json
[
    {
        "id": "1",
        "cpf": "048.973.170-88",
        "nome_paciente": "Emilly Batista Neto",
        "email_paciente": "gerald.crona@ebert-quigley.com",
        "data_nascimento": "2001-03-11",
        "endereco_rua": "165 Rua Rafaela",
        "cidade": "Ituverava",
        "estado": "Alagoas",
        "crm_medico": "B000BJ20J4",
        "crm_medico_estado": "PI",
        "nome_medico": "Maria Luiza Pires",
        "email_medico": "denna@wisozk.biz",
        "token_resultado_exame": "IQCZ17",
        "data_exame": "2021-08-05",
        "tipo_exame": "hemácias",
        "limites_tipo_exame": "45-52",
        "resultado_tipo_exame": "97"
    },
    {
        "id": "2",
        "cpf": "048.973.170-88",
        "nome_paciente": "Emilly Batista Neto",
        "email_paciente": "gerald.crona@ebert-quigley.com",
        "data_nascimento": "2001-03-11",
        "endereco_rua": "165 Rua Rafaela",
        "cidade": "Ituverava",
        "estado": "Alagoas",
        "crm_medico": "B000BJ20J4",
        "crm_medico_estado": "PI",
        "nome_medico": "Maria Luiza Pires",
        "email_medico": "denna@wisozk.biz",
        "token_resultado_exame": "IQCZ17",
        "data_exame": "2021-08-05",
        "tipo_exame": "leucócitos",
        "limites_tipo_exame": "9-61",
        "resultado_tipo_exame": "89"
    },
    ...
]
```



