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

  describe ".find_feature" do
    let(:subject) { Rutabaga::Util.find_feature(@description) }
    before do
      allow(File).to receive(:exists?).with('spec/rutabaga/existing.feature').and_return(true)
      allow(File).to receive(:exists?).with('spec/rutabaga/missing.feature').and_return(false)
      allow(File).to receive(:exists?).with(nil).and_return(false)
    end

    it "returns the file if it exists" do
      @description = 'spec/rutabaga/existing.feature'
      expect(subject).to eq('spec/rutabaga/existing.feature')
    end

    describe "looks for the feature in the spec's directory" do
      before do
        allow(File).to receive(:exists?).with('different.feature').and_return(false)
      end

      it "looks directly in the directory" do
        @description = 'different.feature'
        expect(File).to receive(:exists?).with(/spec\/rutabaga\/different\.feature\Z/).and_return(true)

        expect(subject).to match(/spec\/rutabaga\/different\.feature\Z/)
      end

      it "allows sub-directories" do
        allow(File).to receive(:exists?).with('subdirectory/different.feature').and_return(false)

        @description = 'subdirectory/different.feature'
        expect(File).to receive(:exists?).with(/spec\/rutabaga\/subdirectory\/different\.feature\Z/).and_return(true)

        expect(subject).to match(/spec\/rutabaga\/subdirectory\/different\.feature\Z/)
      end
    end

    describe "figures out the feature name from the spec name" do
      it "description is nil" do
        @description = nil
        allow(File).to receive(:exists?).with(/spec\/rutabaga\/util\.feature\Z/).and_return(true)
        expect(subject).to match(/spec\/rutabaga\/util\.feature\Z/)
      end

      it "description does not match a feature file" do
        @description = 'this is not a feature file'
        allow(File).to receive(:exists?).with(/this is not a feature file/).and_return(false)

        allow(File).to receive(:exists?).with(/spec\/rutabaga\/util\.feature\Z/).and_return(true)
        expect(subject).to match(/spec\/rutabaga\/util\.feature\Z/)
      end
    end

    describe "raises and error if the feature cannot be found" do
      before do
        allow(File).to receive(:exists?).and_return(false)
      end

      it "has a nil description" do
        @description = nil

        expect{subject}.to raise_error(/Feature file not found\. Tried: [\\\/\w]*\/spec\/rutabaga\/util\.feature/)
      end

      it "has a sentance description" do
        @description = "my life as a dog"

        expect{subject}.to raise_error(/Feature file not found\. Tried: [\\\/\w]*\/spec\/rutabaga\/util\.feature/)
      end

      it "has a filename description but the file doesn't exist" do
        @description = "example.feature"

        expect{subject}.to raise_error(/Feature file not found\. Tried: example\.feature, [\\\/\w]*example\.feature/)        
      end
    end
  end
end