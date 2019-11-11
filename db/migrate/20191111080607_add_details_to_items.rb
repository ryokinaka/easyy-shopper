class AddDetailsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :condition, :string
    add_column :items, :shipping, :string
    add_column :items, :region, :string
    add_column :items, :day, :string
  end
end
