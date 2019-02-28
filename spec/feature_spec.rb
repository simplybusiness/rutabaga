require 'spec_helper'

describe 'integration', :type => :integration do
  describe 'functionality' do
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

    it "executes features as blocks inside example groups" do
      expect(@result).to include('feature block inside a describe block')
    end

    it "should not show any pending steps" do
      expect(@result).not_to include('PENDING')
      expect(@result).not_to include('No such step')
    end

    it "prints out failures and successes" do
      expect(@result).to include('18 examples, 4 failures')
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
  end

  describe 'compatibility' do
    before(:all) do
      @result = %x(rspec -r rutabaga -fd examples/compatibility/*_spec.rb 2>&1)
    end

    it "passes all tests" do
      expect(@result).to include('2 examples, 0 failures')
    end

    it "runs feature blocks even if capybara/rspec is installed" do
      expect(@result).to include("capaybara rails does not overwrite the feature command")
    end

    it "preserves the type from the surrounding describe blocks (for example rspec rails example groups)" do
      expect(@result).to include("feature metadata type is preserved as parent_group")
    end

  end
end
