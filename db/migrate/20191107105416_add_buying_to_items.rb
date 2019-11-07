class AddBuyingToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :buying, :string
  end
end
