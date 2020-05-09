class AddPostToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :date, :date
  end
end
