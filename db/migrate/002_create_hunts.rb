class CreateHunts < ActiveRecord::Migration
  def self.up
    create_table :hunts do |t|
      t.string :name
      t.integer :member_id
      t.string :location
      t.string :description
      t.string :difficulty
      t.string :directions
      t.string :length
      t.float :longitude
      t.float :latitude
      t.integer :view_level

      t.timestamps
    end
  end

  def self.down
    drop_table :hunts
  end
end
