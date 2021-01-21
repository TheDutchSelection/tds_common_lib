FactoryBot.define do
  factory :database_backup, class: 'TdsCommonLib::DatabaseBackup' do
    sequence(:name) { |n| "Database backup#{n}"}
    database_name { 'some_database' }
    is_active { true }
  end
end
