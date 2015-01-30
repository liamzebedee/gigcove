class AddApprovedToPerformance < ActiveRecord::Migration
  def change
    add_column :performances, :approved, :boolean, :default => false
  end
end
