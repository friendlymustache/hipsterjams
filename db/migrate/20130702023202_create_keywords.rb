class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.integer :video_id
      t.integer :appearances, :default => 0
      t.integer :hipster, :default => 0
      t.string :name
      t.timestamps
    end
    
    unless column_exists? :videos, :keyword_id
      add_column :videos, :keyword_id, :integer
    end
  end
end