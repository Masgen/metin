class CreateVisuals < ActiveRecord::Migration
  def change
    create_table :visuals do |t|
      t.has_attached_file :picture
      t.references :album

      t.timestamps
    end
  end
end
