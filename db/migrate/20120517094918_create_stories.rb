class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :content
      t.string :video
      t.references :album
      t.string :title
      t.datetime :event_date

      t.timestamps
    end
    add_index :stories
  end
end
