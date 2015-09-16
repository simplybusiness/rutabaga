Feature: Test that background steps are properly called

Background:
  Given we add 10

Scenario: ensures the feature is called
Given that 2 * 4 is calculated
Then my result is 18
