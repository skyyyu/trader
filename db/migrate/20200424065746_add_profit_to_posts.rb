class AddProfitToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :profit, :text
  end
end
