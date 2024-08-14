describe('Home Page', () => {
  it('should load successfully', () => {
    cy.visit('http://localhost:4568')
    cy.contains('Buscar por Token')
  })
})