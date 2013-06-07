class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.string :name
      t.string :sort_id
      t.integer :sort_order

      t.timestamps
    end
  end
end
