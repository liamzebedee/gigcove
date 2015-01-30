class AddApprovedToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :approved, :boolean
  end
end
