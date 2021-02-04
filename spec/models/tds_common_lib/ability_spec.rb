require 'rails_helper'

module TdsCommonLib
  RSpec.describe Ability, type: :model do

    describe '.new' do
      it 'should meet validations' do
        expect(Ability.new).not_to be_valid
        expect(Ability.new(user_id: 1)).not_to be_valid
        expect(Ability.new(user_id: 1, user_type: 'User')).not_to be_valid
        expect(Ability.new(user_id: 1, user_type: 'User', permission: 'some_permission')).to be_valid
      end
    end

    describe '.user_has_permission?' do

      let(:user_1) { double('user') }
      let(:user_2) { double('client_user') }
      let(:user_3) { double('user') }
      let(:user_class_1) { double('User') }
      let(:user_class_2) { double('ClientUser') }
      let!(:ability_1) { FactoryBot.create(:ability, user_id: 1, user_type: 'User', permission: 'something_user_1_can_do') }
      let!(:ability_2) { FactoryBot.create(:ability, user_id: 1, user_type: 'ClientUser', permission: 'something_client_user_1_can_do') }
      let!(:ability_3) { FactoryBot.create(:ability, user_id: 2, user_type: 'User', permission: 'something_user_2_can_do') }

      before do
        allow(user_1).to receive(:id) { 1 }
        allow(user_1).to receive(:class) { user_class_1 }
        allow(user_2).to receive(:id) { 1 }
        allow(user_2).to receive(:class) { user_class_2 }
        allow(user_3).to receive(:id) { 2 }
        allow(user_3).to receive(:class) { user_class_1 }
        allow(user_class_1).to receive(:name) { 'User' }
        allow(user_class_2).to receive(:name) { 'ClientUser' }

      end

      it 'should return true if a user has a certain permission' do
        expect(Ability.user_has_permission?(user_1, :something_user_1_can_do)).to eq true
        expect(Ability.user_has_permission?(user_2, :something_client_user_1_can_do)).to eq true
        expect(Ability.user_has_permission?(user_3, :something_user_2_can_do)).to eq true
        expect(Ability.user_has_permission?(user_2, :something_user_1_can_do)).to eq false
        expect(Ability.user_has_permission?(user_3, :something_user_1_can_do)).to eq false
      end

    end

    describe '.create_abilities_from_role' do

      let(:user_1) { double('user') }
      let(:user_2) { double('client_user') }
      let(:user_3) { double('user') }
      let(:user_class_1) { double('User') }
      let(:user_class_2) { double('ClientUser') }

      before do
        allow(user_1).to receive(:id) { 1 }
        allow(user_1).to receive(:class) { user_class_1 }
        allow(user_1).to receive(:role) { 'editor' }
        allow(user_2).to receive(:id) { 1 }
        allow(user_2).to receive(:class) { user_class_2 }
        allow(user_2).to receive(:role) { 'data' }
        allow(user_3).to receive(:id) { 2 }
        allow(user_3).to receive(:class) { user_class_1 }
        allow(user_3).to receive(:role) { 'admin' }
        allow(user_class_1).to receive(:name) { 'User' }
        allow(user_class_2).to receive(:name) { 'ClientUser' }

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

      it 'should create the correct abilities' do
        abilities = Ability.all

        expect(abilities.count).to eq 0

        Ability.create_abilities_from_role(user_1)
        Ability.create_abilities_from_role(user_2)
        Ability.create_abilities_from_role(user_3)

        abilities.reload

        expect(abilities.count).to eq 5
        expect(Ability.user_has_permission?(user_1, :edit_this)).to eq true
        expect(Ability.user_has_permission?(user_1, :edit_that)).to eq true
        expect(Ability.user_has_permission?(user_1, :delete_something)).to eq true
        expect(Ability.user_has_permission?(user_2, :view_this)).to eq true
        expect(Ability.user_has_permission?(user_2, :view_this)).to eq true
      end

    end

    describe '.reset_abilities_from_role' do

      let(:user) { double('user') }
      let(:user_class) { double('User') }
      let!(:ability_1) { FactoryBot.create(:ability, user_id: 1, user_type: 'User', permission: 'delete_this') }
      let!(:ability_2) { FactoryBot.create(:ability, user_id: 1, user_type: 'User', permission: 'delete_that') }

      before do
        allow(user).to receive(:id) { 1 }
        allow(user).to receive(:class) { user_class }
        allow(user).to receive(:role) { 'editor' }
        allow(user_class).to receive(:name) { 'User' }

        TdsCommonLib.configure do |config|
          config.user_roles = {
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

      it 'should create the correct abilities' do
        abilities = Ability.all

        expect(abilities.count).to eq 2
        expect(Ability.user_has_permission?(user, :delete_this)).to eq true
        expect(Ability.user_has_permission?(user, :delete_that)).to eq true

        Ability.reset_abilities_from_role(user)

        abilities.reload

        expect(abilities.count).to eq 3
        expect(Ability.user_has_permission?(user, :edit_this)).to eq true
        expect(Ability.user_has_permission?(user, :edit_that)).to eq true
        expect(Ability.user_has_permission?(user, :delete_something)).to eq true
        expect(Ability.user_has_permission?(user, :delete_this)).to eq false
        expect(Ability.user_has_permission?(user, :delete_that)).to eq false
      end

    end

  end
end
