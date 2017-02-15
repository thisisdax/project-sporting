class AddRegionToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :region, :integer
  end
end
