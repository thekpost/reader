class AddCols29430ToAppKeys < ActiveRecord::Migration
  def change
    add_column :app_keys, :favicon, :text
  end
end
