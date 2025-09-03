# frozen_string_literal: true

require 'spec_helper'
require 'rutabaga'

describe Rutabaga::Util do
  describe 'location of test from stack track' do
    subject(:util_class) { described_class }

    it 'finds the directory' do
      expect(util_class.send(:extract_directory)).to match(%r{/rutabaga/spec/rutabaga\Z})
    end

    it 'finds the feature' do
      features = util_class.send(:extract_features)
      expect(features[0]).to match(%r{/rutabaga/spec/rutabaga/util\.feature\Z})
      expect(features[1]).to match(%r{/rutabaga/spec/rutabaga/util\.rutabaga\Z})
    end
  end

  describe '.find_feature' do
    subject(:found_feature) { Rutabaga::Util.find_feature(@description) }

    before do
      allow(File).to receive(:exist?).with('spec/rutabaga/existing.feature').and_return(true)
      allow(File).to receive(:exist?).with('spec/rutabaga/missing.feature').and_return(false)
      allow(File).to receive(:exist?).with(nil).and_return(false)
    end

    it 'returns the file if it exists' do
      @description = 'spec/rutabaga/existing.feature'
      expect(found_feature).to eq('spec/rutabaga/existing.feature')
    end

    describe "looks for the feature in the spec's directory" do
      before do
        allow(File).to receive(:exist?).with('different.feature').and_return(false)
      end

      it 'looks directly in the directory' do
        @description = 'different.feature'
        expect(File).to receive(:exist?)
          .with(%r{spec/rutabaga/different\.feature\Z})
          .and_return(true)

        expect(found_feature).to match(%r{spec/rutabaga/different\.feature\Z})
      end

      it 'allows sub-directories' do
        allow(File).to receive(:exist?).with('subdirectory/different.feature')
                                       .and_return(false)

        @description = 'subdirectory/different.feature'
        expect(File).to receive(:exist?)
          .with(%r{spec/rutabaga/subdirectory/different\.feature\Z})
          .and_return(true)

        expect(found_feature).to match(%r{spec/rutabaga/subdirectory/different\.feature\Z})
      end
    end

    describe 'figures out the feature name from the spec name' do
      it 'description is nil' do
        @description = nil
        allow(File).to receive(:exist?).with(%r{spec/rutabaga/util\.feature\Z})
                                       .and_return(true)
        expect(found_feature).to match(%r{spec/rutabaga/util\.feature\Z})
      end

      it 'description does not match a feature file' do
        @description = 'this is not a feature file'
        allow(File).to receive(:exist?).with(/this is not a feature file/)
                                       .and_return(false)

        allow(File).to receive(:exist?).with(%r{spec/rutabaga/util\.feature\Z})
                                       .and_return(true)
        expect(found_feature).to match(%r{spec/rutabaga/util\.feature\Z})
      end

      it 'description does not match a feature file but matches a rutabaga file' do
        @description = 'this is not a feature file'
        allow(File).to receive(:exist?).with(/this is not a feature file/).and_return(false)

        allow(File).to receive(:exist?).with(%r{spec/rutabaga/util\.feature\Z})
                                       .and_return(false)
        allow(File).to receive(:exist?).with(%r{spec/rutabaga/util\.rutabaga\Z})
                                       .and_return(true)

        expect(found_feature).to match(%r{spec/rutabaga/util\.rutabaga\Z})
      end

      it 'handles paths with spaces' do
        @description = '/User/person/Internet plugins/feature.feature'
        allow(File).to receive(:exist?).with(@description).and_return(true)

        expect(found_feature).to eq(@description)
      end

      it 'allows the .feature extension' do
        @description = 'example.feature'
        allow(File).to receive(:exist?).with(@description).and_return(true)

        expect(found_feature).to include(@description)
      end

      it 'allows the .rutabaga extension' do
        @description = 'example.rutabaga'
        allow(File).to receive(:exist?).with(@description).and_return(true)

        expect(found_feature).to include(@description)
      end
    end

    describe 'raises an error if the feature cannot be found' do
      before do
        allow(File).to receive(:exist?).and_return(false)
      end

      it 'has a nil description' do
        @description = nil

        expect { found_feature }.to raise_error(%r{Feature file not found\. Tried: .*/spec/rutabaga/util\.feature})
      end

      it 'has a sentance description' do
        @description = 'my life as a dog'

        expect { found_feature }.to raise_error(%r{Feature file not found\. Tried: .*/spec/rutabaga/util\.feature})
      end

      it "has a filename description but the file doesn't exist" do
        @description = 'example.feature'

        expect { found_feature }.to raise_error(/Feature file not found\. Tried: example\.feature, .*example\.feature/)
      end

      it 'raises an error if the filename does not end in feature' do
        @description = 'example.other'
        allow(File).to receive(:exist?).with(@description).and_return(true)

        expect { found_feature }.to raise_error(%r{Feature file not found\. Tried: .*/spec/rutabaga/util\.feature})
      end
    end
  end
end
