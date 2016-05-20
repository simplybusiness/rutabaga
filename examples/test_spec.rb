require 'spec_helper'

describe "should find the feature file using the root (and monkey patching the result)" do
  it "examples/test2.feature" do
    feature
  end

  step "that :first + :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i + @second.to_i - 1).to eq(result.to_i)
  end

end
