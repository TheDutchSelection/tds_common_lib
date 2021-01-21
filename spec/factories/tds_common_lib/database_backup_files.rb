FactoryBot.define do
  factory :database_backup_file, class: 'TdsCommonLib::DatabaseBackupFile' do
    file_name { 'my-file' }
    database_backup
  end
end
