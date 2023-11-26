/// <reference types="cypress" />
import { Given, Then, When } from 'cypress-cucumber-preprocessor/steps';
var requestEndPoint;


Given('the API endpoint is {string}', (endpoint) => {
    requestEndPoint = endpoint;
});

When('I make a POST request with valid username and password', () => {
    cy.fixture('loginData').then((data) => {
        const { email, password } = data.validUser;
        cy.loginRequest(email, password, requestEndPoint).as("response")
    });

});

When('I make a POST request with {string} to login', (scenario) => {
    cy.fixture('loginData').then((data) => {
        const { email, password } = data[scenario];
        cy.loginRequest(email, password, requestEndPoint).as("response")
    })

});

Then('the response status code should be {string}', (statusCode) => {
    cy.get('@response').then((response) => {
        expect(response.status).to.eq(parseInt(statusCode));
    })
});

Then('the response should contain a valid authentication token', () => {
    cy.get('@response').then((response) => {
        expect(response.body.token).to.to.exist;
    })
});

Then('the response should contain an error message indicating {string}', (message) => {
    cy.get('@response').then((response) => {
        expect(response.body.error).to.equal(message);
    })
});