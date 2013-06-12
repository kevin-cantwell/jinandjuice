class AddAttachmentToVideo < ActiveRecord::Migration
  def change
    add_attachment :videos, :attachment
  end
end
