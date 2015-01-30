class DropGenresGigsTable < ActiveRecord::Migration
  def change
  	drop_table :genres_gigs
  end
end
