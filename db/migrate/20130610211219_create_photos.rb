class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :entry_id
      t.text :url
      t.timestamps
    end
    add_attachment :photos, :attachment
  end
end
