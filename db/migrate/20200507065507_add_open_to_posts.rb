class AddOpenToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :open, :integer
  end
end
