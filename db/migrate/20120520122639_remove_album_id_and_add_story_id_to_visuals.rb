class RemoveAlbumIdAndAddStoryIdToVisuals < ActiveRecord::Migration
  def up
    remove_column :visuals, :album_id
    add_column :visuals, :story_id, :integer
  end

  def down
    remove_column :visuals, :story_id, :integer
    add_column :visuals, :album_id, :integer
  end
end
