class CreateTdsCommonLibDatabaseBackups < ActiveRecord::Migration[6.1]
  def change
    create_table :tds_common_lib_database_backups do |t|
      t.string :name, null: false
      t.string :database_name, null: false
      t.boolean :is_active, null: false

      t.timestamps
    end

    add_index :tds_common_lib_database_backups, :name, unique: true
  end
end
