class AddLowToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :low, :integer
  end
end
