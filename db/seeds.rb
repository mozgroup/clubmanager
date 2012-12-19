puts "Creating the regions"
region1 = Region.create(name: 'Westbury, NY')
region2 = Region.create(name: "Ameytville,NY")

puts "Creating the clubs"
club1 = region1.clubs.create(name: "Big Al's Family Fitness")
club2 = region2.clubs.create(name: "Sweat New York")

# Create the root admin account
puts "Creating the default users"
AdminUser.create!(:email => 'admin@holafriend.com', :password => 'nov8ordie', :password_confirmation => 'nov8ordie')
user = User.create(email: 'tad@holafriend.com', password: 'nov8ordie', password_confirmation: 'nov8ordie', employee_number: '100001', title: 'Admin', first_name: 'Tad', last_name: 'Preston')
user.clubs << [club1, club2]
user = User.create(email: 'rob@holafriend.com', password: 'nov8ordie', password_confirmation: 'nov8ordie', employee_number: '100002', title: 'Admin', first_name: 'Rob', last_name: 'Hatch')
user.clubs << [club1, club2]

