module Notifier
  class Tasks

    class << self

      def method_missing(method, *args)
        split_method = method.to_s.split('_',2)
        if split_method[0] == 'deliver'
          self.send(split_method[1].to_sym, args[0])
        else
          super(method, *args)
        end
      end

      protected

        def assigned_task_message(task)
          @task = task
          @send_to = task.assignee
          @author = task.owner
          @subject = "A task has been assigned to you"

          deliver
        end

        def claim_task_message(task)
          @task = task
          @send_to = task.owner
          @author = task.assignee
          @subject = "Task has been claimed"

          deliver
        end

        def completed_task_message(task)
          @task = task
          @send_to = task.owner
          @author = task.assignee
          @subject = "Task has been completed"

          deliver
        end

        def deliver
          template_name = caller[0][/`([^']*)'/, 1]
          body = ERB.new(load_template(template_name)).result(binding)
          message = Message.create(author_id: @author.id, send_to: @send_to.full_name, subject: @subject, body: body)
          message.deliver
        end

        def load_template(template_name)
          IO.read("#{Rails.root}/app/views/notifiers/tasks/#{template_name}.erb")
        end
    end

  end

end
