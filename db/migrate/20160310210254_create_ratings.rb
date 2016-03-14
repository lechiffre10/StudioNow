class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :ratable, polymorphic: true, index: true
      t.integer :score, default: 0
      t.integer :rater_id

      t.timestamps null: false
    end
  end
end
