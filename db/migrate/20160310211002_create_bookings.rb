class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :availability_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_price
      t.boolean :confirmed

      t.timestamps null: false
    end

    add_index :bookings, :user_id
    add_index :bookings, :availability_id
  end
end
