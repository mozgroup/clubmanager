desc "This task is called by the Heroku scheduler add-on"
task :report_overdue => :environment do
  params = {:status => 'overdue'}
  puts "Updating Overdue status..."
  tasks = Task.search_by_params(params).order(:name)
  tasks.group_by{|task| task.owner.nil? ? '' : task.owner.email}.each{|to_email, tasks|
    TaskMailer.overdue_report('workflow.forwarding@gmail.com', 'Overdue Tasks (Owner)', tasks).deliver
  }
  tasks.group_by{|task| task.assignee.nil? ? '' : task.assignee.email}.each{|to_email, tasks|
    TaskMailer.overdue_report('workflow.forwarding@gmail.com', 'Overdue Assignments', tasks).deliver
  }
to_email = 'workflow.forwarding@gmail.com'
#to_email = 'ericam@bigalsfamilyfitness.com, franka@bigalsfamilyfitness.com'
  TaskMailer.overdue_report(to_email, 'Overdue Tasks Report', tasks).deliver
  puts "Overdue Total:#{tasks.size}"
  puts "done."
end
