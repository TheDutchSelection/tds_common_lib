require 'rails_helper'

module TdsCommonLib
  RSpec.describe RunDatabaseBackupJob do
    let!(:database_backup) { FactoryBot.create(:database_backup, name: 'Test Database', database_name: ActiveRecord::Base.connection_db_config.configuration_hash[:database]) }
    let!(:database_backup_file) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }

    describe :perform do

      it 'should create a database backup input' do
        expect { RunDatabaseBackupJob.perform_now(database_backup.id) }.to change(DatabaseBackupFile, :count).by(1)
      end

      context 'when database backup input reached 10' do
        let!(:database_backup_file_2) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }
        let!(:database_backup_file_3) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }
        let!(:database_backup_file_4) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }
        let!(:database_backup_file_5) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }
        let!(:database_backup_file_6) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }
        let!(:database_backup_file_7) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }
        let!(:database_backup_file_8) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }
        let!(:database_backup_file_9) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }
        let!(:database_backup_file_10) { FactoryBot.create(:database_backup_file, database_backup: database_backup) }

        it 'should limit database backup input to 10' do
          oldest_id = database_backup_file.id
          RunDatabaseBackupJob.perform_now(database_backup.id)

          expect(database_backup.reload.files.count).to eq 10
          expect(DatabaseBackupFile.exists?(oldest_id)).to eq false
        end
      end
    end

  end
end
