class AddEmailAndNameAndVideoIdToFriends < ActiveRecord::Migration
  def change
    remove_column :friends, :video
    remove_column :friends, :photo
    remove_column :friends, :description
    add_column :friends, :video_id, :integer
    add_column :friends, :photo_id, :integer
    add_column :friends, :message_id, :integer
  end
end
