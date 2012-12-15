namespace :users do
	
	desc "update the emails addresses in the db"
	task :update_email => :environment do
		User.all.each {|user| user.update_column('email', "#{user.first_name}.#{user.last_name}@holaclub.com".downcase) unless user.id == 1 }
	end
end