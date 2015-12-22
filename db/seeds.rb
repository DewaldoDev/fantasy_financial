
BaseStock.seed_stocks_from_file("./public/tickersNASDAQ.txt")

User.create(
	username: "kmichaelkills",
	first_name: "Krombopulos",
	last_name: "Michael",
	email: "kmichaelkills@gmail.com")

User.create(
	username: "wubbalubbadub",
	first_name: "Rick",
	last_name: "Sanchez",
	email: "r_sanchez@gmail.com")

User.create(
	username: "the_one_true_morty",
	first_name: "Morty",
	last_name: "Smith",
	email: "theonetruemorty@gmail.com")

User.all.each do |user|
	user.participations.create(
		group_id: squanch_group.id)

	user.portfolios.create(
		group_id: squanch_group.id,
		cash: squanch_group.starting_total)

end
