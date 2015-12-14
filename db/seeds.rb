# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
BaseStock.seed_stocks_from_file("./lib/tickersNASDAQ.txt")

k_michael = User.create(
	username: "kmichaelkills",
	first_name: "Krombopulos",
	last_name: "Michael",
	email: "kmichaelkills@gmail.com")

r_sanchez = User.create(
	username: "wubbalubbadub",
	first_name: "Rick",
	last_name: "Sanchez",
	email: "r_sanchez@gmail.com")

m_smith = User.create(
	username: "the_one_true_morty",
	first_name: "Morty",
	last_name: "Smith",
	email: "theonetruemorty@gmail.com")

squanch_group = Group.create(
	name: "The Squanchers",
	start_date: Time.now,
	end_date: Time.now.end_of_day.advance(months: 1),
	starting_total: 10000,
	max_size: 3
	)

User.all.each do |user|
	user.participations.create(
		group_id: Group.all.first.id)

	user.portfolios.create(
		group_id: Group.all.first.id)
end



