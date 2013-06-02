class AddCols39490ToAppKeys < ActiveRecord::Migration
  def change
    add_column :app_keys, :categories, :text
    add_column :app_keys, :html_url, :text
    add_column :app_keys, :sort_id, :string
  end
end
