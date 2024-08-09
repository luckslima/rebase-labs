<div align="center">

  <h1 align="center">Desafio Rebase Labs</h1>

  <p align="justify">
    Projeto desenvolvido durante o Rebase Labs da turma 12.
    <br/>
  </p>
</div>

## Sobre o Projeto

Uma pequena aplicação web para listagem de exames médicos.

### Tecnologias 

- Docker
- Ruby
- Javascript
- HTML
- CSS

### Como Rodar a app? :arrow_forward:

- No terminal, clone o projeto:

  > git clone git@github.com:luckslima/rebase-labs.git

- Em seguida, dentro da pasta do projeto, construa e inicie os containers:

  > docker-compose up --build

- E logo após importe o CSV para o banco de dados:

  > docker-compose exec api ruby import_from_csv.rb

Pronto! Agora é possível acessar a aplicação através da rota http://localhost:4567/ :wink:

- TESTES:

- Para executar os testes da API rode o comando:

  > docker-compose exec api rspec

## API

### Endpoints

- 'GET /tests' 

> Nesse endpoint é retornado uma listagem de todos os exames médicos importados do CSV no formato JSON e agrupados pelo token.

Exemplo de resposta:
```json
[
    {
        "result_token": "IQCZ17",
        "result_date": "2021-08-05",
        "cpf": "048.973.170-88",
        "name": "Emilly Batista Neto",
        "email": "gerald.crona@ebert-quigley.com",
        "birthday": "2001-03-11",
        "doctor": {
            "crm": "B000BJ20J4",
            "crm_state": "PI",
            "name": "Maria Luiza Pires"
        },
        "tests": [
            {
                "type": "hemácias",
                "limits": "45-52",
                "result": "97"
            },
            {
                "type": "leucócitos",
                "limits": "9-61",
                "result": "89"
            },
            {
                "type": "plaquetas",
                "limits": "11-93",
                "result": "97"
            },
            {
                "type": "hdl",
                "limits": "19-75",
                "result": "0"
            },
            {
                "type": "ldl",
                "limits": "45-54",
                "result": "80"
            },
            {
                "type": "vldl",
                "limits": "48-72",
                "result": "82"
            },
            {
                "type": "glicemia",
                "limits": "25-83",
                "result": "98"
            },
            {
                "type": "tgo",
                "limits": "50-84",
                "result": "87"
            },
            {
                "type": "tgp",
                "limits": "38-63",
                "result": "9"
            },
            {
                "type": "eletrólitos",
                "limits": "2-68",
                "result": "85"
            },
            {
                "type": "tsh",
                "limits": "25-80",
                "result": "65"
            },
            {
                "type": "t4-livre",
                "limits": "34-60",
                "result": "94"
            },
            {
                "type": "ácido úrico",
                "limits": "15-61",
                "result": "2"
            }
        ]
    },
    ...
]
```

- 'GET /tests/:token' 

> Nesse endpoint é retornado detalhes de um exame médico através do token informado nos parametros.

Exemplo de resposta:
```json
{
    "result_token": "0W9I67",
    "result_date": "2021-07-09",
    "cpf": "048.108.026-04",
    "name": "Juliana dos Reis Filho",
    "email": "mariana_crist@kutch-torp.com",
    "birthday": "1995-07-03",
    "doctor": {
        "crm": "B0002IQM66",
        "crm_state": "SC",
        "name": "Maria Helena Ramalho"
    },
    "tests": [
        {
            "type": "hemácias",
            "limits": "45-52",
            "result": "28"
        },
        {
            "type": "leucócitos",
            "limits": "9-61",
            "result": "91"
        },
        {
            "type": "plaquetas",
            "limits": "11-93",
            "result": "18"
        },
        {
            "type": "hdl",
            "limits": "19-75",
            "result": "74"
        },
        {
            "type": "ldl",
            "limits": "45-54",
            "result": "66"
        },
        {
            "type": "vldl",
            "limits": "48-72",
            "result": "41"
        },
        {
            "type": "glicemia",
            "limits": "25-83",
            "result": "6"
        },
        {
            "type": "tgo",
            "limits": "50-84",
            "result": "32"
        },
        {
            "type": "tgp",
            "limits": "38-63",
            "result": "16"
        },
        {
            "type": "eletrólitos",
            "limits": "2-68",
            "result": "61"
        },
        {
            "type": "tsh",
            "limits": "25-80",
            "result": "13"
        },
        {
            "type": "t4-livre",
            "limits": "34-60",
            "result": "9"
        },
        {
            "type": "ácido úrico",
            "limits": "15-61",
            "result": "78"
        }
    ]
}
```

