class AddHighToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :high, :integer
  end
end
