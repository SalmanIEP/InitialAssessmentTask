/// <reference types="cypress" />
import { Given, Then, And, When } from 'cypress-cucumber-preprocessor/steps';

let requestEndPoint = "register";

Given('the API endpoint is {string}', (endpoint) => {
    requestEndPoint = endpoint;
});

When('I make a POST request with valid email and password', () => {
    cy.fixture('registerData').then((data) => {
        const { email, password } = data.validUser;
        const options = {
            body: {
                "email": email,
                "password": password,
            }
        }
        cy.apiRequest('POST', requestEndPoint, options).as("response")
    });

});

Then('the response status code should be {string}', (statusCode) => {
    cy.get('@response').then((response) => {
        expect(statusCode).to.eq(parseInt(response.status));
    })
});

Then('the response should contain an authentication token', () => {
    cy.get('@response').then((response) => {
        expect(response.body.token).to.exist;
    })
});

When('I make a POST request with {string} to register', (scenario) => {
    cy.fixture('registerData').then((data) => {
        const { email, password } = data[scenario];
        const options = {
            body: {
                "email": email,
                "password": password,
            }
        }
        cy.apiRequest('POST', requestEndPoint, options).as("response")
    })
});

Then('the response should contain an error message indicating {string}', (errorMessage) => {
    cy.get('@response').then((response) => {
        expect(errorMessage).to.equal(response.body.error);
    })
});