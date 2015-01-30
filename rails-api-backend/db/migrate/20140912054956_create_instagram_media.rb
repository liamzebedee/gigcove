class CreateInstagramMedia < ActiveRecord::Migration
  def change
    create_table :instagram_media do |t|
      t.text :link
      t.integer :instagram_id
      t.datetime :created_time

      t.timestamps
    end
  end
end
