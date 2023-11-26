Feature: Registration API

  Scenario: Successful registration with valid email and password
    Given the API endpoint is "register"
    When I make a POST request with valid email and password
    Then the response status code should be "200"
    And the response should contain an authentication token

  Scenario Outline: Unsuccessful registration with missing and invalid credentials
    Given the API endpoint is "register"
    When I make a POST request with "<scenario>" to register
    Then the response status code should be "<status_code>"
    And the response should contain an error message indicating "<error_message>"

    Examples: 
    | scenario        | status_code | error_message                                 |
    | missingPassword |         400 | Missing password                              |
    | missingEmail    |         400 | Missing email or username                                |
    | invalidEmail    |         400 | Note: Only defined users succeed registration |
