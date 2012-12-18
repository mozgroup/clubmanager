namespace :summary do
	
	desc "update the emails addresses in the db"
	task :add_monthly => :environment do
		Club.all.each do |club|
			club.monthly_summaries.create({ 
						month: Time.now.beginning_of_month, 
						business_days_in_month: 30,
						membership_goal: 50000,
						training_goal: 22000,
						juice_bar_goal: 10000,
						nursery_goal: 1000,
						membership_draft_expected: 77385,
						training_draft_expected: 31801
				})
		end
	end
end