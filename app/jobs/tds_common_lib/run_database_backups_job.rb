module TdsCommonLib
  class RunDatabaseBackupsJob < ApplicationJob

    queue_as :default

    def perform
      database_backups = TdsCommonLib::DatabaseBackup.all

      database_backups.each do |database_backup|
        database_backup.delayed_run
      end
    end

  end
end