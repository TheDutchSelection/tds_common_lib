require 'rails_helper'

module TdsCommonLib
  RSpec.describe RunDatabaseBackupsJob do

    describe :perform do

      let!(:database_backup_1) { FactoryBot.create(:database_backup) }
      let!(:database_backup_2) { FactoryBot.create(:database_backup) }

      before do
        allow(DatabaseBackup).to receive(:all).and_return([database_backup_1, database_backup_2])
      end

      it 'should queue all database backups' do
        expect(database_backup_1).to receive(:delayed_run).exactly(1).times
        expect(database_backup_2).to receive(:delayed_run).exactly(1).times

        RunDatabaseBackupsJob.perform_now
      end
    end
  end
end
