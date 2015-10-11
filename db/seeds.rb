# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
count = 0
15.times{
  TodoItem.create(:title => "To Do item count " + "#{count}", :description => "Item " + "#{count}" + " has to be finished.")
  count += 1
}
