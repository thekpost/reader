class AddColorsToAppKeys < ActiveRecord::Migration
  def change
    add_column :app_keys, :colour, :string
  end
end
