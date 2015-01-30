class AddModerationToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :moderated, :boolean
  	add_column :tags, :approved, :boolean
  end
end
