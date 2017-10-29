class CreateBuyThings < ActiveRecord::Migration[5.1]
  def change
    create_table :buy_things do |t|
      t.integer :thing_id
      t.integer :user_id
      t.integer :num

      t.timestamps
    end
  end
end
