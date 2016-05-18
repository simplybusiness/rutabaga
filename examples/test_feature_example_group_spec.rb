require 'spec_helper'

describe "test feature argument" do
  feature

  step "that :first + :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i + @second.to_i).to eq(result.to_i)
  end
end

feature "feature block" do
  step "that :first + :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i + @second.to_i).to eq(result.to_i)
  end
end

describe "should find the feature file using the root (and monkey patching the result)" do
  feature "examples/test2.feature"

  step "that :first + :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i + @second.to_i - 1).to eq(result.to_i)
  end
end

describe "causes a failing test" do
  feature "examples/test2.feature"

  step "that :first + :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i + @second.to_i).to eq(result.to_i)
  end
end

describe "finds a feature file given as parameter to the 'feature' method" do
  feature "examples/test3.feature"

  step "that :first * :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i * @second.to_i).to eq(result.to_i)
  end
end

describe "finds a feature file with a different name in the same directory" do
  feature "test3.feature"

  step "that :first * :second is calculated" do |first, second|
    @first = first
    @second = second
  end

  step "my result is :result" do |result|
    expect(@first.to_i * @second.to_i).to eq(result.to_i)
  end
end

describe "backgrounds are properly called" do
  feature "examples/test_background.feature"

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
