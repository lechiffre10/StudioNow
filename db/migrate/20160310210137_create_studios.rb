class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.integer :owner_id
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.float :lat, {:precision => 10, :scale => 6}
      t.float :lng, {:precision => 10, :scale => 6}
      t.text :description
      t.float :price
      t.string :website

      t.timestamps null: false
    end
  end
end
