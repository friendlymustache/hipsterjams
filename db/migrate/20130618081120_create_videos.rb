class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :id
      t.string :name
      t.integer :hipster, :default => 0

      t.timestamps
    end
  end
end
