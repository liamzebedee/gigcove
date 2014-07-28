class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.datetime :time
      t.integer :gig_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
