class ChangeLocationTypeInEvents < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :location, 'integer USING CAST(location AS integer)'
  end
end
