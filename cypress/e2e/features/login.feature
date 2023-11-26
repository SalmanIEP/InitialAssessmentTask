Feature: Login API

  Scenario: Successful login with valid credentials
    Given the API endpoint is "login"
    When I make a POST request with valid username and password
    Then the response status code should be "200"
    And the response should contain a valid authentication token

  Scenario Outline: Unsuccessful login with invalid credentials
    Given the API endpoint is "login"
    When I make a POST request with "<scenario>" to login
    Then the response status code should be "<status_code>"
    And the response should contain an error message indicating "<error_message>"

    Examples: 
      | scenario         | status_code | error_message             |
      | invalidUser      |         400 | user not found            |
      | invalidPassword  |         401 | Invalid credentials       |
      | emptyCredentials |         400 | Missing email or username |
      | nonExistingUser  |         400 | user not found            |
