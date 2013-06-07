class CreateTagEntries < ActiveRecord::Migration
  def change
    create_table :tag_entries do |t|
      t.integer :app_key_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
