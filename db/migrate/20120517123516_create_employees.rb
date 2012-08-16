class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.has_attached_file :photograph

      t.timestamps
    end
  end
end
