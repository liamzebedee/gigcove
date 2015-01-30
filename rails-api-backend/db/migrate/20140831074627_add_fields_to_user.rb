class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :gender, :string
  end
end
