class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.text :content

      t.timestamps
    end
  end
end
