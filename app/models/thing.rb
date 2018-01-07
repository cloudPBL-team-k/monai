class Thing < ApplicationRecord
  has_many :expendables
  has_many :thing_aliases
  has_many :bought_thins
  has_many :buy_things

  # ユーザ別名取得
  def get_thing_with_alias
    return ThingAlias.joins(:thing)
                     .where(user_id: user_id)
                     .where(thing_id: thing_id)
                     .select("things.*,
                              thing_aliases.alias as alias_name")
  end
end
