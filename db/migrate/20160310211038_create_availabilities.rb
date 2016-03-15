class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :studio_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end

    add_index :availabilities, :studio_id
  end
end
