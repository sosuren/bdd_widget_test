Feature: Authentication

    Scenario: I should be able to login with valid credential
        Given I am in the login page
        When I enter these data in the login form
            | Username | Password    | Should Remember Password |
            |  auser   | shomehash   |          true            |
            |  auser   | shomehash   |          true            |
        Then I should see these results in the home page
            | First Name | Last Name | Is Adult |
            |    One     |  User     |    Yes   |
            |    One     |  User     |    Yes   |

    Scenario: I should be able to signup
        Given I am in the signup page
        When I enter these data in the signup form
            | First Name | Last Name | Is Adult | Username | Password    |
            |    One     |  User     |    No    |  auser   | shomehash   |
        Then I should see these results in the home page
            | First Name | Last Name | Is Adult |
            |    One     |  User     |    No   |
