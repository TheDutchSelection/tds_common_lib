require 'rails_helper'

module TdsCommonLib
  RSpec.describe DatabaseBackup, type: :model do

    describe '.new' do
      it 'should meet validations' do
        expect(DatabaseBackup.new).not_to be_valid
        expect(DatabaseBackup.new(is_active: nil)).not_to be_valid
        expect(DatabaseBackup.new(name: 'Test Database', database_name: 'test', is_active: true)).to be_valid
      end
    end

  end
end
