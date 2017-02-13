class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
    t.references :user, index: true, foreign_key: true
    t.string     :name
    t.text       :description
    t.string     :location
    t.string     :type
    t.date       :date
    t.time       :time
    t.time       :duration
    t.integer    :minpax
    t.integer    :maxpax

    t.timestamps
    end
  end
end
