class AddEntryIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :entry_id, :integer
  end
end
