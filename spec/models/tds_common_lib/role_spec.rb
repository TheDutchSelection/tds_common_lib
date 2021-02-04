require 'rails_helper'

module TdsCommonLib
  RSpec.describe Role, type: :model do

    describe '.roles' do

      before do
        TdsCommonLib.configure do |config|
          config.user_roles = {
            'ClientUser' => {
              admin: [],
              data: [
                :view_this,
                :view_that
              ]
            },
            'User' => {
              admin: [],
              editor: [
                :edit_this,
                :edit_that,
                :delete_something
              ]
            }
          }
        end
      end

      it 'should return the roles for a user type' do
        expect(Role.roles('ClientUser')).to eq admin: [],
                                               data: [
                                                 :view_this,
                                                 :view_that
                                               ]
        expect(Role.roles('User')).to eq admin: [],
                                         editor: [
                                           :edit_this,
                                           :edit_that,
                                           :delete_something
                                         ]
      end

    end

    describe '#permissions' do

      let(:role_1) { FactoryBot.build(:role, name: 'data', user_type: 'ClientUser') }
      let(:role_2) { FactoryBot.build(:role, name: 'editor', user_type: 'User') }

      before do
        TdsCommonLib.configure do |config|
          config.user_roles = {
            'ClientUser' => {
              admin: [],
              data: [
                :view_this,
                :view_that
              ]
            },
            'User' => {
              admin: [],
              editor: [
                :edit_this,
                :edit_that,
                :delete_something
              ]
            }
          }
        end
      end

      it 'should return the permissions for a role' do
        expect(role_1.permissions).to eq [:view_this, :view_that]
        expect(role_2.permissions).to eq [:edit_this, :edit_that, :delete_something]
      end

    end

  end
end
