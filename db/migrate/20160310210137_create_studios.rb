class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.integer :owner_id
      t.string :full_address
      t.float :latitude, {:precision => 10, :scale => 6}
      t.float :longitude, {:precision => 10, :scale => 6}
      t.text :description
      t.integer :price
      t.string :website

      t.timestamps null: false
    end
    add_index :studios, :owner_id
  end
end
