class AddColsToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :categories, :text
    add_column :feed_entries, :author, :string
  end
end
