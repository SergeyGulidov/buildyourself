# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(email:'s.gulidov@gmail.com',
	password: '459185468816', role: 1)

Category.create!(category_name_lv:"Sports", category_name_ru:"riga", category_slug:"sport")
Type.create!(type_name_lv:"Boks", type_name_ru:"boks", type_slug:"box")
Interval.create!(interval_name_lv:"Pusaudziem", interval_name_ru:"podrostkam", interval_slug:"juniors")
City.create!(city_name_lv:"Riga", city_name_ru:"riga", city_slug:"riga")
Country.create!(country_name_lv:"Latvija", country_name_ru:"latvija", country_slug:"latvia")