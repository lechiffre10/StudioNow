class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :reviewable, polymorphic: true, index: true
      t.text :content
      t.integer :reviewer_id

      t.timestamps null: false
    end
  end
end
