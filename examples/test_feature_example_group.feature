Feature: Test that rspec will call the feature

Scenario: ensures the feature is called
Given that 2 + 2 is calculated
Then my result is 4

Scenario Outline: ensures the outline feature is called with one failing example which can be called individually
Given that <a> + <b> is calculated
Then my result is <c>

Examples:
| a | b | c  |
| 1 | 1 | 2  |
| 2 | 2 | 4  |
| 3 | 3 | 5  |
