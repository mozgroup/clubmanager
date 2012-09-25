module SysLogger
  def self.included(base)
    base.instance_eval do
      has_many :sys_logs, :as => :loggable, dependent: :destroy do
        def add_log(msg_type, msg, actioner="SYSTEM")
          create!(actioned_by: actioner, message: msg, message_type: msg_type)
        end
      end
    end
  end

  def method_missing(method, *args)
    if method.to_s =~ /^log_/  # if the method called is a log method
      sys_logs.add_log(method.slice(/[^_]+$/).upcase, args[0], args[1])
    else
      super
    end
  end
end
