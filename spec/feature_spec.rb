require 'spec_helper'

describe 'integration', :type => :integration do
  before do
    @result = %x(rspec -r rutabaga -fd examples/*_spec.rb)
  end

  it "shows the correct description" do
    expect(@result).to include('ensures the feature is called')
    expect(@result).to include('that 2 + 2 is calculated')
    expect(@result).to include('my result is 4')
  end

  it "should not show any pending steps" do
    expect(@result).not_to include('PENDING')
    expect(@result).not_to include('No such step')
  end

  it "prints out failures and successes" do
    expect(@result).to include('10 examples, 1 failure')
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

end
