class AddCols94385ToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :last_starred_at, :datetime
  end
end
