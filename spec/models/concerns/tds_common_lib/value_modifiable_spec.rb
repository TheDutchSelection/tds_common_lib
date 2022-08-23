require 'rails_helper'

module TdsCommonLib
  RSpec.describe ValueModifiable do

    let(:dummy_class) { Class.new { include TdsCommonLib::ValueModifiable } }
    let(:dummy_object) { dummy_class.new }

    describe '.add_as_array' do
      it 'should return an array with the compacted values' do
        expect(dummy_object.add_as_array(1, 2)).to eq [1, 2]
      end

      it 'should return an array with the compacted values' do
        expect(dummy_object.add_as_array([1, 'something'], 2)).to eq [1, 'something', 2]
      end

      it 'should return an array with the compacted values' do
        expect(dummy_object.add_as_array([1, 'something'], [2])).to eq [1, 'something', 2]
      end
    end

    describe '#value_to_array' do
      it 'should return the array if the value is an Array already' do
        value = [:a, :b]
        expect(dummy_object.value_to_array(value)).to eq [:a, :b]
      end

      it 'should return the flattened array if the value is an Array already' do
        value = [nil]
        expect(dummy_object.value_to_array(value)).to eq []
      end

      it 'should return an empty array if the value nil' do
        expect(dummy_object.value_to_array(nil)).to eq []
      end

      it 'should return an array with the value if the value is a integer' do
        value = 1
        expect(dummy_object.value_to_array(value)).to eq [1]
      end

      it 'should return an array with the value if the value is a string' do
        value = 'ape'
        expect(dummy_object.value_to_array(value)).to eq ['ape']
      end

      it 'should return an array with the value if the value is a string' do
        value = ''
        expect(dummy_object.value_to_array(value)).to eq []
      end
    end
  end
end
