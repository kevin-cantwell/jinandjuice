class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :email
      t.text :name
      t.integer :message_id
      t.integer :photo_id
      t.integer :video_id
      t.timestamps
    end
  end
end
