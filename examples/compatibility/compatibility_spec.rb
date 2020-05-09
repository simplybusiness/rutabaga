# frozen_string_literal: true

require 'spec_helper'
require 'capybara/rspec'

describe 'capaybara rails does not overwrite the feature command' do
  feature '../test2.feature' do
    step 'that :first + :second is calculated' do |first, second|
      @first = first
      @second = second
    end

    step 'my result is :result' do |result|
      expect(@first.to_i + @second.to_i - 1).to eq(result.to_i)
    end
  end
end
