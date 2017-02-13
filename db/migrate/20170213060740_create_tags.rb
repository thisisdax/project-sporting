class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
        t.string     :value
        t.references :tag_category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
