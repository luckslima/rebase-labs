describe('SPA Navigation Tests', () => {

  beforeEach(() => {
    cy.visit('/');
  });

  it('Should display the table header correctly', () => {
    cy.get('table thead tr th').should('have.length', 6);
    cy.get('table thead tr th').eq(0).should('contain', 'Token');
    cy.get('table thead tr th').eq(1).should('contain', 'Data');
    cy.get('table thead tr th').eq(2).should('contain', 'CPF');
    cy.get('table thead tr th').eq(3).should('contain', 'Nome');
    cy.get('table thead tr th').eq(4).should('contain', 'Médico');
    cy.get('table thead tr th').eq(5).should('contain', 'CRM');
  });

  it('Should display a message when there is no data', () => {
    cy.intercept('GET', 'http://api:4567/tests', {
      statusCode: 200,
      body: []
    }).as('getTests');

    cy.visit('/');
    cy.wait('@getTests');
    cy.get('#no-data-message').should('be.visible');
  });

  it('Should search and display test details', () => {
    const testToken = '123456';
    const testData = {
      result_token: testToken,
      result_date: '2024-08-01',
      cpf: '123.456.789-00',
      name: 'Paciente Teste',
      email: 'teste@teste.com',
      birthday: '1990-01-01',
      doctor: {
        name: 'Dr. Teste',
        crm: '123456',
        crm_state: 'SP'
      },
      tests: [
        { type: 'Tipo 1', result: 'Resultado 1', limits: 'Limites 1' },
        { type: 'Tipo 2', result: 'Resultado 2', limits: 'Limites 2' }
      ]
    };

    cy.intercept('GET', `http://api:4567/tests/${testToken}`, {
      statusCode: 200,
      body: testData
    }).as('getTest');

    cy.get('#token-input').type(testToken);
    cy.get('form#search-form').submit();

    cy.wait('@getTest');
    cy.get('#search-result').should('be.visible');
    cy.get('#search-result .card').should('contain', testData.result_token);
    cy.get('#search-result .card').should('contain', testData.result_date);
    cy.get('#search-result .card').should('contain', testData.cpf);
    cy.get('#search-result .card').should('contain', testData.name);
    cy.get('#search-result .card').should('contain', testData.email);
    cy.get('#search-result .card').should('contain', testData.birthday);
    cy.get('#search-result .card').should('contain', testData.doctor.name);
    cy.get('#search-result .card').should('contain', testData.doctor.crm);
    cy.get('#search-result .card').should('contain', testData.doctor.crm_state);

    testData.tests.forEach(test => {
      cy.get('#search-result .card').should('contain', `${test.type}: ${test.result} (${test.limits})`);
    });
  });

  it('Should display error message when test is not found', () => {
    const invalidToken = 'invalid_token';

    cy.intercept('GET', `http://api:4567/tests/${invalidToken}`, {
      statusCode: 404
    }).as('getInvalidTest');

    cy.get('#token-input').type(invalidToken);
    cy.get('form#search-form').submit();

    cy.wait('@getInvalidTest');
    cy.get('#search-result').should('be.visible');
    cy.get('#search-result').should('contain', 'Exame não encontrado. Verifique o token e tente novamente.');
  });
});
