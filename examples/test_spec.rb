require 'spec_helper'

describe "test" do
	it "should run feature" do
		feature
	end

	step "that :first + :second is calculated" do |first, second|
		@first = first
		@second = second
	end

	step "my result is :result" do |result|
		result.to_i.should == @first.to_i + @second.to_i
	end
end