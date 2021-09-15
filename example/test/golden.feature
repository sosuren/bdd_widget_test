Feature: Golden Test
    
    Background:
        Given the app is running
		  And the user has permission

    After:
        # Just for the demo purpose, you may write "I don't see {'42'} text" to use built-in step instead.
        # See the list of built-in step below.
        And I do not see {'42'} text 
 
  Scenario: Users is able to create a New Home
    Given The user is registered 
    And The user is logged
    And The USER_MENU page is opened
    When The user tapped the +HOME button
    And The SAVE button is inactive
    And The user enters data in the create home form
        | Type of home A | Address                    | Adults |
        | House        | Nedre Storgate, 42 Drammen   | 2      |
        | House        | Nedre Storgate, 42 Drammen   | 2      |
    Then The SAVE button becomes active
    And The user tapped the SAVE button
    And The user is redirected to the MY_HOME page
    And The Home is created
    And The user enters data in the update home form
        | Type of home B | Address                    | Adults |
        | House        | Nedre Storgate, 42 Drammen   | 2      |
        | House        | Nedre Storgate, 42 Drammen   | 2      |
    And The Home is created

  Scenario: Users is able to update a New Home
    Given The user is registered 
    And The user is logged
    And The USER_MENU page is opened
    When The user tapped the +HOME button
    And The SAVE button is inactive
    And The user enters data in the create home form
        | Type of home C | Address                    | Adults |
        | House        | Nedre Storgate, 42 Drammen   | 2      |
    Then The SAVE button becomes active
    And The user tapped the SAVE button
    And The user is redirected to the MY_HOME page
    And The Home is created
    And The user enters data in the update home form
        | Type of home D | Address                    | Adults |
        | House        | Nedre Storgate, 42 Drammen   | 2      |

