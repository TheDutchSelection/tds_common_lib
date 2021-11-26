require 'rails_helper'

module TdsCommonLib
  RSpec.describe Backend::AbilityHelper, type: :helper do

    describe '.has_permission?' do
      let(:user_1) { double('user') }
      let(:user_2) { double('client_user') }
      let(:user_3) { double('user') }
      let(:user_4) { double('user') }
      let(:user_5) { double('user') }
      let(:user_class_1) { double('User') }
      let(:user_class_2) { double('ClientUser') }
      let!(:ability_1) { FactoryBot.create(:ability, user_id: 1, user_type: 'User', permission: 'something_user_1_can_do') }
      let!(:ability_2) { FactoryBot.create(:ability, user_id: 1, user_type: 'ClientUser', permission: 'something_client_user_1_can_do') }
      let!(:ability_3) { FactoryBot.create(:ability, user_id: 2, user_type: 'User', permission: 'something_user_2_can_do') }


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
        allow(user_4).to receive(:id) { 3 }
        allow(user_4).to receive(:class) { user_class_1 }
        allow(user_4).to receive(:role) { ['admin', 'something'] }
        allow(user_5).to receive(:id) { 4 }
        allow(user_5).to receive(:class) { user_class_1 }
        allow(user_5).to receive(:role) { ['member', 'something'] }
        allow(user_class_1).to receive(:name) { 'User' }
        allow(user_class_2).to receive(:name) { 'ClientUser' }
      end

      it 'should return if a user has a specific permission' do
        expect(helper.has_permission?(user_1, :something_user_1_can_do)).to eq true
        expect(helper.has_permission?(user_1, :something_client_user_1_can_do)).to eq false
        expect(helper.has_permission?(user_1, :something_user_2_can_do)).to eq false
        expect(helper.has_permission?(user_1, :unknown_action)).to eq false
        expect(helper.has_permission?(user_2, :something_client_user_1_can_do)).to eq true
        expect(helper.has_permission?(user_2, :something_user_1_can_do)).to eq false
        expect(helper.has_permission?(user_2, :something_user_2_can_do)).to eq false
        expect(helper.has_permission?(user_2, :unknown_action)).to eq false
        expect(helper.has_permission?(user_3, :something_user_2_can_do)).to eq true
        expect(helper.has_permission?(user_3, :something_user_1_can_do)).to eq true
        expect(helper.has_permission?(user_3, :something_client_user_1_can_do)).to eq true
        expect(helper.has_permission?(user_3, :unknown_action)).to eq true
        expect(helper.has_permission?(user_4, :unknown_action)).to eq true
        expect(helper.has_permission?(user_5, :unknown_action)).to eq false
      end
    end
  end
end
