class CreateTdsCommonLibDatabaseBackupFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :tds_common_lib_database_backup_files do |t|
      t.string :file_name, null: false

      t.timestamps
    end

    add_reference :tds_common_lib_database_backup_files, :database_backup, foreign_key: { to_table: :tds_common_lib_database_backups, on_delete: :cascade }, null: false, index: { name: 'index_database_backup_files_on_database_backup_id' }
  end
end
