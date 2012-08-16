class RemoveAlbumIdFromStory < ActiveRecord::Migration
  def up
    remove_column :stories, :album_id
  end

  def down
    add_column :stories, :album_id, :references
  end
end
