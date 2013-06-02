class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.text :raw_info
      t.string :provider
      t.string :token
      t.string :refresh_token
      t.datetime :expires_at
      t.string :uid

      t.timestamps
    end
  end
end
