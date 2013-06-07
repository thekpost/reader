class AddCurrentStarToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :current_star, :string, :default => 'star0'
  end
end
