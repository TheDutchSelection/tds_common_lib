class CreateTdsCommonLibAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :tds_common_lib_abilities do |t|
      t.bigint :user_id, null: false
      t.string :user_type, null: false
      t.string :permission, null: false

      t.timestamps
    end

    add_index :tds_common_lib_abilities, [:user_id, :user_type, :permission], name: "index_abilities", unique: true
  end
end
