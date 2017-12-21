class CreateThingAliases < ActiveRecord::Migration[5.1]
  def change
    create_table :thing_aliases do |t|
      t.integer :thing_id
      t.integer :user_id
      t.string :alias

      t.timestamps
    end
  end
end
