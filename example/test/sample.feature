Feature: Counter Feature

    Background:
        Given the user is in the home page

    Scenario: User should see login form
        Given the user is in the home page
        When user taps login button
        Then user should see login form

    Scenario: Add button increments the counter
        Given the user is in the home page
        When user taps login button
        Then user should see login form
        When user enters these data in the login form
            | Type of home | Address                      | Adults |
            | House A      | Nedre Storgate, 42 Drammen   | 2      |
        Then user should see these results in the home page
            | Type of home | Address                      | Adults |
            | House A      | Nedre Storgate, 42 Drammen   | 2      |

    Scenario: Divide button increments the counter
        Given the user is in the home page
        When user taps login button
        Then user should see login form
        When user enters these data in the login form
            | Type of home | Address                      | Adults |
            | House X      | Nedre Storgate, 42 Drammen   | 2      |
            | House Y      | Nedre Storgate, 42 Drammen   |        |
        Then user should see these results in the home page
            | Type of home | Address                      | Adults |
            | House X      | Nedre Storgate, 42 Drammen   | 2      |
            | House Y      | Nedre Storgate, 42 Drammen   |        |

    # Scenario: Built-in steps
    #     And I don't see {Icons.add} icon
    #     And I don't see {'text'} rich text
    #     And I don't see {'text'} text
    #     And I don't see {Container} widget
    #     And I enter {'text'} into {1} input field
    #     And I see disabled elevated button
    #     And I see enabled elevated button
    #     And I see exactly {4} {Container} widgets
    #     And I see {Icons.add} icon
    #     And I see multiple {'text'} texts
    #     And I see multiple {Container} widgets
    #     And I see {'text'} rich text
    #     And I see {'text'} text
    #     And I tap {Icons.add} icon
    #     And I wait
    #     And I dismiss the page