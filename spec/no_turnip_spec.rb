require 'spec_helper'

describe 'no_turnip', :type => :integration do
  describe 'turnip disabled' do
    before(:all) do
      @result = %x(rspec -r rutabaga -r rutabaga/no_turnip examples/test.feature 2>&1)
    end

    it "should raise an error when trying to call turnip features directly" do
      expect(@result).to include("Calling features directly has been disabled by rutabaga")
      expect(@result).to include("rutabaga/no_turnip")
    end

    it "has the correct file pattern" do
      result = %x(rspec -r rutabaga/no_turnip -r rutabaga examples/test_pattern_spec.rb)
      expect(result).to include("RSpec.configuration.pattern: **{,/*/**}/*_spec.rb\n")
      result = %x(rspec -r rutabaga -r rutabaga/no_turnip -r rutabaga examples/test_pattern_spec.rb)
      expect(result).to include("RSpec.configuration.pattern: **{,/*/**}/*_spec.rb\n")
      result = %x(rspec -r rutabaga/no_turnip examples/test_pattern_spec.rb)
      expect(result).to include("RSpec.configuration.pattern: **{,/*/**}/*_spec.rb\n")
    end
  end

  describe 'turnip enabled' do
    describe "in correct directory" do
      it "should be able to call features directly" do
        @result = %x(rspec -r rutabaga/turnip spec/features/fixture.feature 2>&1)
        expect(@result).to include("No such step")
      end

      it "rutabaga turnip is the default" do
        @result = %x(rspec -r rutabaga spec/features/fixture.feature 2>&1)
        expect(@result).to include("No such step")
      end
    end

    describe "outside of the correct directory" do
      # rspec -r rutabaga/turnip examples/test_feature_example_group.feature
      # rspec -r rutabaga/turnip spec/features/fixture.feature
      before(:all) do
        @result = %x(rspec -r rutabaga examples/test.feature 2>&1)
      end

      it "warns about the directory" do
        expect(@result).to include("WARNING: Features can only be called from turnip enable directories")
      end
    end

    it "has the correct file pattern" do
      result = %x(rspec -r rutabaga examples/test_pattern_spec.rb)
      expect(result).to include("RSpec.configuration.pattern: **{,/*/**}/*_spec.rb,features/**/*.feature\n")
      result = %x(rspec -r rutabaga/turnip -r rutabaga examples/test_pattern_spec.rb)
      expect(result).to include("RSpec.configuration.pattern: **{,/*/**}/*_spec.rb,features/**/*.feature\n")
      result = %x(rspec -r rutabaga -r rutabaga/turnip -r rutabaga examples/test_pattern_spec.rb)
      expect(result).to include("RSpec.configuration.pattern: **{,/*/**}/*_spec.rb,features/**/*.feature\n")
      result = %x(rspec -r rutabaga/turnip examples/test_pattern_spec.rb)
      expect(result).to include("RSpec.configuration.pattern: **{,/*/**}/*_spec.rb,features/**/*.feature\n")
    end
  end
end
