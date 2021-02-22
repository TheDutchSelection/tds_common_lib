require 'rails_helper'

RSpec.describe IbanValidator do

  subject do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :iban
      validates :iban, iban: true
    end.new
  end

  describe 'empty iban addresses' do
    ['', nil].each do |iban_address|
      describe "when iban address is #{iban_address}" do
        it 'does not add an error' do
          subject.iban = iban_address
          subject.validate
          expect(subject.errors[:iban]).not_to include 'is not a valid IBAN address'
        end
      end
    end
  end

  describe 'invalid IBAN addresses' do
    [
      'nope',
      'GB94BARC20201530093459',
      'GB96BARC202015300934591',
      'GB12BARC20201530093A59',
      'GB78BARCO0201530093459',
      'US64SVBKUS6S3300958879',
      '.',
      ' '
    ].each do |iban_address|
      describe "when iban address is #{iban_address}" do

        it 'adds an error' do
          subject.iban = iban_address
          subject.validate
          expect(subject.errors[:iban]).to include 'is not a valid IBAN address'
        end
      end
    end
  end

  describe 'valid IBAN addresses' do
    ['GB33BUKB20201555555555', 'GB94BARC10201530093459'].each do |iban_address|
      describe "when iban address is #{iban_address}" do
        it 'does not add an error' do
          subject.iban = iban_address
          subject.validate
          expect(subject.errors[:iban]).not_to include 'is not a valid IBAN address'
        end
      end
    end
  end
end
