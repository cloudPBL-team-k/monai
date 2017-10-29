class CreateExpendables < ActiveRecord::Migration[5.1]
  def change
    create_table :expendables do |t|
      t.integer :thing_id
      t.integer :user_id
      t.date :limit

      t.timestamps
    end
  end
end
