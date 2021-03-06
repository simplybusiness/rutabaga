# frozen_string_literal: true

require 'spec_helper'

describe 'should find feature file using root (and monkey patch result)' do
  feature 'examples/test2.feature'

  step 'that :first + :second is calculated' do |first, second|
    @first = first
    @second = second
  end

  step 'my result is :result' do |result|
    expect(@first.to_i + @second.to_i - 1).to eq(result.to_i)
  end
end
