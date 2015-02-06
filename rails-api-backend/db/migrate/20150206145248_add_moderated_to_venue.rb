class AddModeratedToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :moderated, :boolean
  end
end
