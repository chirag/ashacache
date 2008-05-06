class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :body
      t.integer :hunt_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
