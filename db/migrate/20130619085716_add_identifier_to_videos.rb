class AddIdentifierToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :identifier, :string
  end
end
