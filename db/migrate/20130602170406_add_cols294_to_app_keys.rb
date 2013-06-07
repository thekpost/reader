class AddCols294ToAppKeys < ActiveRecord::Migration
  def change
    add_column :app_keys, :rss_last_modified_at, :datetime
  end
end
