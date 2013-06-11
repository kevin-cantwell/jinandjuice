class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :entry_id
      t.text :message
      t.timestamps
    end
  end
end
