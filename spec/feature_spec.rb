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

  it "prints out failures and successes" do
    @result.should include('2 examples, 0 failures')
  end

end
