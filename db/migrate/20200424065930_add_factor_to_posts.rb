class AddFactorToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :factor, :text
  end
end
