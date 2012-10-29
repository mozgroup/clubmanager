module Notifier
  class Tasks

    class << self

      def config
        @config ||= load_msg_params["tasks"]
      end

      def deliver_claim_task_message(task)
        msg_config = config['claim_task_message']
        message = Message.create(author_id: task.assignee_id, send_to: task.owner_full_name, subject: msg_config['subject'], body: msg_config['body'])
        message.deliver
      end

      def deliver_completed_task_message(task)
        msg_config = config['completed_task_message']
        message = Message.create(author_id: task.assignee_id, send_to: task.owner_full_name, subject: msg_config['subject'], body: msg_config['body'])
        message.deliver
      end

      def method_missing(method, *args)
        split_method = method.to_s.split('_',2)
        if split_method[0] == 'deliver' && !config[split_method[1]].blank?
          deliver_notification(config[split_method[1]], *args)
        else
          super(method, *args)
        end
      end

      private

        def load_msg_params
          filepath = File.expand_path("../../../config/notifiers/#{Rails.env}/", __FILE__)
          YAML.load(IO.read("#{filepath}/notifier.yml"))
        end

        def deliver_notification(msg_config, *args)
          task = args[0]
          message = Message.create(author_id: task.owner_id, send_to: task.assigned_to, subject: msg_config['subject'], body: msg_config['body'])
          message.deliver
        end

    end

  end

end
