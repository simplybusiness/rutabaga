require 'spec_helper'

describe 'formatter', :type => :integration do
  before(:all) do
    @result = %x(rspec -r rutabaga -r rspec_formatter/formatter.rb --format RspecFormatter::Formatter spec/features/fixture.feature examples/test_spec.rb 2>&1)
  end

  it "has the feature location" do
    expect(@result).to include("rspec_core_formatter:file_path: ./spec/features/fixture.feature")
  end

  it "has the rutabaga test location" do
    expect(@result).to include("rspec_core_formatter:file_path: ./examples/test_spec.rb")
  end
end
