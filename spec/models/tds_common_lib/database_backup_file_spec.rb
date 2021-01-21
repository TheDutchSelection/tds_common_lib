require 'rails_helper'

module TdsCommonLib
  RSpec.describe DatabaseBackupFile, type: :model do

    let(:database_backup) { FactoryBot.create(:database_backup, name: 'Test Database', database_name: ActiveRecord::Base.connection_db_config.configuration_hash[:database]) }

    describe '.create' do
      it 'should create a database backup output' do
        expect(database_backup.files.count).to eq 0

        database_backup.run

        database_backup_file = database_backup.files.first
        expect(database_backup.files.count).to eq 1
        expect(database_backup_file).to be_a(DatabaseBackupFile)
        expect(database_backup_file.file).to be_a(TdsCommonLib::DatabaseBackupFileUploader)
        expect(database_backup_file.file_name).to include(ActiveRecord::Base.connection_db_config.configuration_hash[:database])
      end
    end
  end
end
