require 'spec_helper'

describe 'integration', :type => :integration do
  before do
    @result = %x(rspec -r rutabaga -fs examples/*_spec.rb)
  end

  it "shows the correct description" do
    @result.should include('ensures the feature is called')
    @result.should include('that 2 + 2 is calculated')
    @result.should include('my result is 4')
  end

  it "should not show any pending steps" do
    @result.should_not include('PENDING')
    @result.should_not include('No such step')
  end

  it "prints out failures and successes" do
    @result.should include('8 examples, 1 failure')
  end

  it "should find features relative to the root" do
    @result.should_not include('Feature file not found')
  end

  it "finds the .feature file given as parameter to the 'feature' method" do
    @result.should include('that 2 * 4 is calculated')
    @result.should include('my result is 8')
  end

  it "should scope steps to describe blocks" do
    @result.should_not include('Turnip::Ambiguous')
  end

end
