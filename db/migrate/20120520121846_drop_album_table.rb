class DropAlbumTable < ActiveRecord::Migration
  def up
    drop_table :albums
  end

  def down
    create_table :producs do |t|
      t.timestamps
    end
  end
end
