# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'tad@holafriend.com', password: 'nov8ordie', password_confirmation: 'nov8ordie', employee_number: '100001', title: 'Admin', first_name: 'Tad', last_name: 'Preston')

puts "Creating the users"
99.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{first_name}.#{last_name}@hola_club.com"
  password = "p@ssw0Rd"
  employee_number = "10000#{i+2}"
  title = Faker::Name.title
  User.create!(email: email, password: password, password_confirmation: password, employee_number: employee_number, title: title, first_name: first_name, last_name: last_name)
end

puts "Createing the messages"
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

  if rand(1..2) == 2
    message.deliver
  end
end
