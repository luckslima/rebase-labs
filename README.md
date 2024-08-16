<div align="center">

  <h1 align="center">Desafio Rebase Labs</h1>

  <p align="justify">
    Projeto desenvolvido durante o Rebase Labs da turma 12.
    <br/>
  </p>
</div>

## Sobre o Projeto

Uma pequena aplicação web para listagem de exames médicos.

## Estrutura do Projeto

- **API**: Servidor backend para gerenciar exames e importar arquivos CSV.
- **SPA**: Aplicação frontend para buscar e exibir dados dos exames.

## Pré-requisitos

- Docker
- Docker Compose

### Tecnologias 

- Ruby
- Javascript
- HTML
- CSS
- Bootstrap

### Como Rodar a app? :arrow_forward:

- No terminal, clone o projeto:

  > git clone git@github.com:luckslima/rebase-labs.git

- Em seguida, dentro da pasta do projeto, construa e inicie os containers:

  > docker-compose up --build

Pronto! Agora é possível acessar a aplicação através da rota http://localhost:4567/ :wink:

- Testes:

- Para executar os testes da API rode o comando:

  > docker-compose exec api rspec

- Para executar os testes da SPA rode o comando:

  > docker-compose exec spa npx cypress run

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
        }
    ]
}
```

- 'POST /import' 

> Esse endpoint permite a importação assíncrona de um arquivo CSV com exames médicos.

Exemplo de corpo da requisição:

```
{file: arquivo.csv}
```

Exemplo de resposta em caso de sucessso:

```
status: 200
body: "Importação iniciada em background!"
```

Exemplo de resposta em caso de erro:

```
status: 400
body: 'Arquivo CSV não encontrado'
```

## SPA

A SPA (Single Page Application) é responsável pela interface do usuário da aplicação, permitindo a interação com os dados dos exames médicos através de uma interface web.

### Funcionalidades

- **Importação de CSV:** Permite a importação de exames médicos a partir de um arquivo CSV que contenha todos os dados necessários para a exibição.
- **Listagem de exames:** Após a importação do csv é possível ver a lista exames que contem o Token do exame, a data do resultado, o CPF do paciente, o nome do paciente, o nome do médico e o seu respectivo CRM.
- **Busca por Token:** Permite a busca de exames médicos utilizando um token específico, mostrando assim mais detalhes daquele exame específico, como por exemplo os resultados do exame. 

### Tecnologias Utilizadas

- HTML 
- JavaScript
- CSS
- Bootstrap
- Cypress

### Como Rodar a SPA?

1. **Iniciar a Aplicação:**

   Após iniciar os containers com `docker-compose up --build`, a SPA estará disponível em [http://localhost:4568/](http://localhost:4568/).

2. **Interação com a SPA:**

   - **Buscar Exames:** Utilize o campo de busca para inserir o token do exame e visualize os detalhes.
   - **Importar Exames:** Utilize o campo de upload para enviar um arquivo CSV e importar exames para a base de dados.