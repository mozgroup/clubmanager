desc "This task is called by the Heroku scheduler add-on"
task :report_overdue => :environment do
  params = {:status => 'overdue'}
  puts "Updating Overdue status..."
  tasks = Task.search_by_params(params)
  TaskMailer.overdue_report(tasks).deliver
  puts "Overdue Total:#{tasks.size}"
  puts "done."
end
