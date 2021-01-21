require 'rails_helper'

module TdsCommonLib
  RSpec.describe RecordsLimitable do

    describe '.limit_records_by_type' do

      before do
        8.times { FactoryBot.create(:database_backup_file) }
      end

      it 'should limit the given collection that has not a type to the max given' do
        collection = DatabaseBackupFile.all
        RunDatabaseBackupJob.perform_later.limit_records_by_type(collection, 2)

        expect(collection.size).to eq 8
        expect(DatabaseBackupFile.all.size).to eq 2
      end
    end

  end
end