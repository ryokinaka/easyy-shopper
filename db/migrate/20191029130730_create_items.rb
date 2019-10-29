class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :image
      t.string :title
      t.string :category
      t.integer :price
      t.text :explanation
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
