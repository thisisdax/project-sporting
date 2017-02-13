class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :image, :string
    add_column :users, :name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :min_age, :integer
    add_column :users, :gender, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :birthday, :date
  end
end
