class AddVideoSourceToStories < ActiveRecord::Migration
  def change
    add_column :stories, :video_source, :string
  end
end
