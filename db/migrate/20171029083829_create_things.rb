class CreateThings < ActiveRecord::Migration[5.1]
  def change
    create_table :things do |t|
      t.string :name
      t.integer :jancode

      t.timestamps
    end
  end
end
