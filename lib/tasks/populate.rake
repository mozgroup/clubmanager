namespace :populate	do 

	desc "populates the database with dummy users"
	task :users => :environment do
		puts 'Creating dummy users'
		99.times do |i|
		  first_name = Faker::Name.first_name
		  last_name = Faker::Name.last_name
		  email = "#{first_name}.#{last_name}@holaclub.com"
		  password = "p@ssw0Rd"
		  employee_number = "10000#{i+2}"
		  title = Faker::Name.title
		  club = Club.find(rand(1..2))
		  club.users.create!(email: email, password: password, password_confirmation: password, employee_number: employee_number, title: title, first_name: first_name, last_name: last_name)
		end
	end

	desc "populates the database with dummy messages"
	task :messages => :environment do
		puts "Creating the messages"
		200.times do |i|
		  author = User.find(rand(1..100))
		  send_to = User.find(rand(1..100))
		  copy_to = User.find(rand(1..100))
		  blind_copy_to = User.find(rand(1..100))
		  
		  message = author.authored_messages.create(
		    send_to: send_to.full_name,
		    copy_to: copy_to.full_name,
		    blind_copy_to: blind_copy_to.full_name,
		    subject: Faker::Lorem.sentence(rand(3..10)),
		    body: Faker::Lorem.paragraphs(rand(1..4)),
		    importance: ((rand(1..7) % 2) == 0 ? 'important' : 'normal')
		  )
		  message.deliver if rand(1..2) == 2

		end
	end
end