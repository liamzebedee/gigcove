class RemoveTimeFromPerformance < ActiveRecord::Migration
  def change
    remove_column :performances, :time, :datetime
  end
end
