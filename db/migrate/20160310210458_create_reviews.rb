class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :reviewable, polymorphic: true, index: true
      t.text :content
      t.integer :reviewer_id

      t.timestamps null: false
    end

    add_index :reviews, :reviewer_id
    add_index :reviews, [:reviewable_id, :reviewable_type]
  end
end
