# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
#for the tagcategory
csv_text = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = User.new
  t.email = row['email']
  t.password = row['password']
  t.last_sign_in_at = row['last_sign_in_at']

  t.save
  puts "#{t.email} saved"
end

puts "There are now #{User.count} rows in the user table"

csv_text = File.read(Rails.root.join('lib', 'seeds', 'events.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Event.new
  t.user_id = row['user_id']
  t.name = row['name']
  t.description = row['description']
  t.location = row['location']
  t.type_of_sport = row['type_of_sport']
  t.date = row['date']
  t.time = row['time']
  t.duration = row['duration']
  t.minpax = row['minpax']
  t.maxpax = row['maxpax']
  t.region = row['region']

  t.save
  puts "#{t.name} saved"
end

puts "There are now #{Event.count} rows in the event table"

csv_text = File.read(Rails.root.join('lib', 'seeds', 'attendings.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Attending.new
  t.user_id = row['user_id']
  t.event_id = row['event_id']

  t.save
  puts "#{t.user_id}, #{t.event_id} saved"
end

puts "There are now #{Attending.count} rows in the attending table"

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

csv_text = File.read(Rails.root.join('lib', 'seeds', 'event_tags.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = EventTag.new
  t.tag_id = row['tag_id']
  t.event_id = row['event_id']

  t.save
  puts "#{t.tag_id} saved"
end

puts "There are now #{EventTag.count} rows in the event_tags table"
