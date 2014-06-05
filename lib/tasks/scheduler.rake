desc "This task is called by the Heroku scheduler add-on"
task :report_overdue => :environment do
  params = {:status => 'overdue'}
  puts "Updating Overdue status..."
  tasks = Task.search_by_params(params)
  tasks.each{|task|
    TaskMailer.overdue_task(task).deliver
  }
  TaskMailer.overdue_report(tasks).deliver
  puts "Overdue Total:#{tasks.size}"
  puts "done."
end
