module TdsCommonLib
  class DatabaseBackup < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :database_name, presence: true
    validates :is_active, inclusion: { in: [true, false] }

    has_many :files, -> { order(id: :desc) }, dependent: :destroy, class_name: 'TdsCommonLib::DatabaseBackupFile'

    broadcasts

    def run
      files.new.create_file
    end

    def delayed_run
      TdsCommonLib::RunDatabaseBackupJob.perform_later(id)
    end
  end
end
