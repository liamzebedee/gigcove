class AddTagsToGig < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :tags_gigs, id: false do |t|
      t.belongs_to :tag
      t.belongs_to :gig
    end
  end
end
