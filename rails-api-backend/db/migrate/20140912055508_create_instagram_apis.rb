class CreateInstagramApis < ActiveRecord::Migration
  def change
    create_table :instagram_apis do |t|
      t.integer :new_media_count
      t.integer :last_seen_instagram_id

      t.timestamps
    end
  end
end
