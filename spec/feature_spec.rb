require 'spec_helper'

describe 'integration', :type => :integration do
  before(:all) do
    @result = %x(rspec -r rutabaga -fd examples/*_spec.rb 2>&1)
  end

  it "shows the correct description" do
    expect(@result).to include('ensures the feature is called')
    expect(@result).to include('that 2 + 2 is calculated')
    expect(@result).to include('my result is 4')
  end

  it "executes features as an argument" do
    expect(@result).to include('test feature argument')
  end

  it "executes features as blocks/example groups" do
    expect(@result).to include('feature block')
  end

  it "should not show any pending steps" do
    expect(@result).not_to include('PENDING')
    expect(@result).not_to include('No such step')
  end

  it "prints out failures and successes" do
    expect(@result).to include('15 examples, 3 failures')
  end

  it "should find features relative to the root" do
    expect(@result).not_to include('Feature file not found')
  end

  it "finds the .feature file given as parameter to the 'feature' method" do
    expect(@result).to include('that 2 * 4 is calculated')
    expect(@result).to include('my result is 8')
  end

  it "should scope steps to describe blocks" do
    expect(@result).not_to include('Turnip::Ambiguous')
  end

  it "should provide failure messages that allow a specific scenario to be run" do
    expect(@result).to include("rspec ./examples/test_feature_example_group_spec.rb[1:1:1:4:1]")
  end

  it "should have a feature deprecation warning" do
    expect(@result).to include("Calling `feature` from an `it` block is deprecated.")
  end
end
