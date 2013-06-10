class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.text :email
      t.text :video
      t.text :photo
      t.text :description
      t.timestamps
    end
  end
end
