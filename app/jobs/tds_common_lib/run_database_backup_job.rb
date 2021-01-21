module TdsCommonLib
  class RunDatabaseBackupJob < ApplicationJob

    include TdsCommonLib::RecordsLimitable

    queue_as :default

    def perform(database_backup_id)
      database_backup = TdsCommonLib::DatabaseBackup.find(database_backup_id)
      database_backup.run
      cleanup_database_backup_files(database_backup)
    end

    private


    def cleanup_database_backup_files(database_backup)
      database_backup_files = database_backup.files.order(id: :desc)
      limit_records_by_type(database_backup_files, 10)
    end
  end
end