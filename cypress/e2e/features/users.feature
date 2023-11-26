Feature: Users

  Scenario: Retrieve list of users with default page
    Given the API endpoint is "users"
    When I make a GET request without specifying the page
    Then the response status code should be "200"
    And the response should contain a list of users for the page "1"
    And the response content must follow the required schema as "usersList"

  Scenario Outline: Retrieve list of users for a specific page
    Given the API endpoint is "users"
    When I make a GET request with the page parameter set to "<PageNumber>"
    Then the response status code should be "<StausCode>"
    And the response should contain a list of users for the page "<PageNumber>"
    And the response content must follow the required schema as "usersList"

    Examples: 
      | PageNumber | StausCode |
      |          2 |       200 |
      |          1 |       200 |

  Scenario Outline: Retrieve single user detail
    Given the API endpoint is "users"
    When I make a GET request for user having id as "<userID>"
    Then the response status code should be "<StausCode>"
    And the response should contain following user details
      | id   | email   | first_name   | last_name   |
      | <id> | <email> | <first_name> | <last_name> |
   And the response content must follow the required schema as "singleUser"

    Examples: 
      | userID | StausCode | id | email                    | first_name | last_name |
      |      2 |       200 |  2 | janet.weaver@reqres.in   | Janet      | Weaver    |
      |      7 |       200 |  7 | michael.lawson@reqres.in | Michael    | Lawson    |

  Scenario Outline: Non existing user
    Given the API endpoint is "users"
    When I make a GET request for user having id as "<userID>"
    Then the response status code should be "<StausCode>"

    Examples: 
      | userID | StausCode |
      |     45 |       404 |
      | @@     |       404 |
      |     -1 |       404 |
      |      0 |       404 |

  Scenario Outline: Create New User
    Given the API endpoint is "users"
    When I make a POST request to create a new user with name as "<name>" and job as "<job>"
    Then the response status code should be "<StausCode>"
    And the new user must be created successfully with following details
      | name   | job   |
      | <name> | <job> |
    And the response content must follow the required schema as "createUser"

    Examples: 
      | name  | job                    | StausCode |
      | test1 | QA Automation Engineer |       201 |
      | test2 | SDET                   |       201 |

  Scenario Outline: Update User
    Given the API endpoint is "users"
    When I make a PUT request to update user details having id as "<userID>"
    Then the response status code should be "<StausCode>"
    And the user details must be updated successfully
    And the response content must follow the required schema as "updateUser"

    Examples: 
      | StausCode | userID |
      |       200 |      1 |
      |       200 |      2 |


  Scenario Outline: Delete User
    Given the API endpoint is "users"
    When I make a Delete request to delete user details having id as "<userID>"
    Then the response status code should be "<StausCode>"

    Examples: 
      | StausCode | userID |
      |       204 |      1 |
      |       204 |      2 |

