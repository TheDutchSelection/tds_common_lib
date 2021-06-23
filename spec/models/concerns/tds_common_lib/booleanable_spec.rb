require 'rails_helper'

module TdsCommonLib
  RSpec.describe Booleanable do

    let(:dummy_class) { Class.new { include TdsCommonLib::Booleanable } }
    let(:dummy_object) { dummy_class.new }

    describe '.is_boolean_value' do
      it 'should return true for true value' do
        expect(dummy_object.is_boolean_value(true)).to eq true
      end

      it 'should return true for 1 value' do
        expect(dummy_object.is_boolean_value(1)).to eq true
      end

      it 'should return true for "1" value' do
        expect(dummy_object.is_boolean_value('1')).to eq true
      end

      it 'should return true for "true" value' do
        expect(dummy_object.is_boolean_value('true')).to eq true
      end

      it 'should return true for false value' do
        expect(dummy_object.is_boolean_value(false)).to eq true
      end

      it 'should return true for 0 value' do
        expect(dummy_object.is_boolean_value(0)).to eq true
      end

      it 'should return true for "0" value' do
        expect(dummy_object.is_boolean_value('0')).to eq true
      end

      it 'should return true for "false" value' do
        expect(dummy_object.is_boolean_value('false')).to eq true
      end

      it 'should return false for another value' do
        expect(dummy_object.is_boolean_value('all')).to eq false
      end
    end

    describe '.to_boolean' do
      it 'should return true for true value' do
        expect(dummy_object.to_boolean(true)).to eq true
      end

      it 'should return false for nil value' do
        expect(dummy_object.to_boolean(nil)).to eq false
      end

      it 'should return false for empty string value' do
        expect(dummy_object.to_boolean('')).to eq false
      end

      it 'should return true for 1 value' do
        expect(dummy_object.to_boolean(1)).to eq true
      end

      it 'should return true for "1" value' do
        expect(dummy_object.to_boolean('1')).to eq true
      end

      it 'should return true for "true" value' do
        expect(dummy_object.to_boolean('true')).to eq true
      end

      it 'should return false for false value' do
        expect(dummy_object.to_boolean(false)).to eq false
      end

      it 'should return false for 0 value' do
        expect(dummy_object.to_boolean(0)).to eq false
      end

      it 'should return false for "0" value' do
        expect(dummy_object.to_boolean('0')).to eq false
      end

      it 'should return false for "false" value' do
        expect(dummy_object.to_boolean('false')).to eq false
      end
    end
  end
end
