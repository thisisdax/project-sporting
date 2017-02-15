class ChangeTypeOfSportTypeInEvents < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :type_of_sport, 'integer USING CAST(type_of_sport AS integer)'
  end
end
