class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :user_id, null: false
      t.string :name, null: false, default: "" 

      t.timestamps
      t.index :user_id
    end
  end
end
