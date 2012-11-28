module Notifier
  class Events

    class << self
      def method_missing(method, *args)
        split_method = method.to_s.split('_',2)
        if split_method[0] == 'deliver'
          self.send(split_method[1].to_sym, args[0], args[1])
        else
          super(method, *args)
        end
      end

      protected

        def invitation(event, user)
          @event = event
          @send_to = user.full_name
          @author = event.organizer
          @subject = "[Calendar Event] #{event.subject}"

          deliver
        end

        def deliver
          template_name = caller[0][/`([^']*)'/, 1]
          body = ERB.new(load_template(template_name)).result(binding)
          message = Message.create(author_id: @author.id, send_to: @send_to, subject: @subject, body: body)
          message.deliver
        end

        def load_template(template_name)
          IO.read("#{Rails.root}/app/views/notifiers/events/#{template_name}.erb")
        end
    end
  end
end
