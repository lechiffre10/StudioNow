class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :studio_id
      t.attachment :media

      t.timestamps null: false
    end
  end
end
