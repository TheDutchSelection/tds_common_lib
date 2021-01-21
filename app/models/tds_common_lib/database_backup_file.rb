module TdsCommonLib
  class DatabaseBackupFile < ApplicationRecord

    mount_uploader :file, TdsCommonLib::DatabaseBackupFileUploader, mount_on: :file_name

    belongs_to :database_backup

    TEMP_DATABASE_BACKUP_DIRECTORY = Rails.root.join('tmp/database_backups/').to_s

    def create_file
      unless file_name.present?
        temp_backup_file_name = create_backup_file
        File.open(temp_backup_file_name) do |f|
          self.file = f
        end

        save
      end
    end

    def self.clear_temp_files
      FileUtils.rm_rf(TEMP_DATABASE_BACKUP_DIRECTORY)
    end

    private

    def create_backup_file
      result = ''
      connection = ActiveRecord::Base.connection_db_config
      config = connection.configuration_hash
      if connection.present?
        system_command = 'PGPASSWORD=' + config[:password].to_s + ' pg_dump ' +
          '-h ' + config[:host] + ' ' +
          '-U ' + config[:username] + ' ' +
          '-w ' +
          '-Z6 ' +
          '-p ' + config[:port].to_s + ' ' +
          '-f ' + temp_backup_file_name + ' ' +
          '-Fc ' + database_backup.database_name
        system(system_command)
        result = temp_backup_file_name
      end

      result
    end

    def backup_file_file_name
      @backup_file_file_name ||= "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{database_backup.database_name}"
    end

    def temp_backup_file_name
      directory_name = TEMP_DATABASE_BACKUP_DIRECTORY
      FileUtils.mkdir_p(directory_name) unless File.exists?(directory_name)

      directory_name + backup_file_file_name
    end

  end
end
