require 'spec_helper'
require 'rutabaga'

describe Rutabaga::Util do
  describe "location of test from stack track" do
    it "finds the directory" do
      expect(subject.class.send(:extract_directory)).to match(/\/rutabaga\/spec\/rutabaga\Z/)
    end

    it "finds the feature" do
      expect(subject.class.send(:extract_feature)).to match(/\/rutabaga\/spec\/rutabaga\/util\.feature\Z/)
    end
  end
end
