# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
#for the tagcategory
csv_text = File.read(Rails.root.join('lib', 'seeds', 'tag_category.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = TagCategory.new
  t.id = row['id']
  t.value = row['value']

  t.save
  puts "#{t.id}, #{t.value} saved"
end

puts "There are now #{TagCategory.count} rows in the tag_category table"

#for the tags
csv_text2 = File.read(Rails.root.join('lib', 'seeds', 'tags.csv'))
csv2 = CSV.parse(csv_text2, :headers => true, :encoding => 'ISO-8859-1')
csv2.each do |row|
  t = Tag.new
  t.id = row['id']
  t.value = row['value']
  t.tag_category_id = row['tag_category_id']

  t.save
  puts "#{t.id}, #{t.value}, #{t.tag_category_id} saved"
end

puts "There are now #{Tag.count} rows in the tags table"
