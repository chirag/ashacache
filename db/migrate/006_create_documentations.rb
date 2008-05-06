class CreateDocumentations < ActiveRecord::Migration
  def self.up
    create_table :documentations do |t|
      t.string :title
      t.text :body
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :documentations
  end
end
