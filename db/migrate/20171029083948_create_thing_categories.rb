class CreateThingCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :thing_categories do |t|
      t.integer :thing_id
      t.integer :category_id

      t.timestamps
    end
  end
end
