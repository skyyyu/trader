class AddCloseToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :close, :integer
  end
end
