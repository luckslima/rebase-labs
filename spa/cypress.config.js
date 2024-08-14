const { defineConfig } = require("cypress");

module.exports = {
  e2e: {
    baseUrl: 'http://spa:4568',
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
    video: false
  },
};

