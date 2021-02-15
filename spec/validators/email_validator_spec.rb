require 'rails_helper'

RSpec.describe EmailValidator do

  subject do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :email
      validates :email, email: true
    end.new
  end

  describe 'empty email addresses' do
    ['', nil].each do |email_address|
      describe "when email address is #{email_address}" do
        it 'does not add an error' do
          subject.email = email_address
          subject.validate
          expect(subject.errors[:email]).not_to include 'is not a valid email address'
        end
      end
    end
  end

  describe 'invalid email addresses' do
    ['nope', '@', 'foo@bar.com.', '.', ' '].each do |email_address|
      describe "when email address is #{email_address}" do

        it 'adds an error' do
          subject.email = email_address
          subject.validate
          expect(subject.errors[:email]).to include 'is not a valid email address'
        end
      end
    end
  end

  describe 'valid email addresses' do
    ['foo@bar.com', 'foo@bar.bar.co'].each do |email_address|
      describe "when email address is #{email_address}" do
        it 'does not add an error' do
          subject.email = email_address
          subject.validate
          expect(subject.errors[:email]).not_to include 'is not a valid email address'
        end
      end
    end
  end
end
