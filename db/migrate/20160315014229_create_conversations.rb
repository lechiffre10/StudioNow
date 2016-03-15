class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :originator_id
      t.integer :recipient_id

      t.timestamps null: false
    end
  end
end
