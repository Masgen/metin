class RemoveTitleFromAlbums < ActiveRecord::Migration
  def up
    remove_column :albums, :title
  end

  def down
    add_column :albums, :title, :string
  end
end
