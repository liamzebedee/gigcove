class RenameTagsGigsTable < ActiveRecord::Migration
  def change
  	rename_table :tags_gigs, :gigs_tags
  end
end
