class ChangeJancodeIntToString < ActiveRecord::Migration[5.1]
  def up
      change_column :things, :jancode, :string
  end

  def down
      change_column :things, :jancode, :integer
  end
end
