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
    expect(@first.to_i + @second.to_i).to eq(result.to_i)
  end
end

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

describe "causes a failing test" do
  it "examples/test2.feature" do
    feature
  end

  step "that :first + :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i + @second.to_i).to eq(result.to_i)
  end

end

describe "finds a feature file given as parameter to the 'feature' method" do
  it "implements the named feature" do
    feature "examples/test3.feature"
  end

  step "that :first * :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i * @second.to_i).to eq(result.to_i)
  end

end

describe "backgrounds are properly called" do
  it "implements the named feature" do
    feature "examples/test_background.feature"
  end

  step "we add :initial" do |initial|
    @initial = 10
  end

  step "that :first * :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@initial.to_i + @first.to_i * @second.to_i).to eq(result.to_i)
  end

end