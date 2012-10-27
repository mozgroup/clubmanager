class Notifier
  attr_accessor :to, :from, :subject, :body

  def initialize(args = nil)
    unless args.nil?
      @to = args[:to]
      @copy_to = args[:copy_to]
      @blind_copy_to = args[:blind_copy_to]
      @from = args[:from]
      @subject = args[:subject]
      @body = args[:body]
    end

    @message_params = load_msg_params
  end

  def method_missing(method)
    if method.to_s =~ /^deliver_/
      split_method = method.to_s.split('_',2)
    else
      super(method)
    end
  end

  private

    def load_msg_params
      filepath = "#{Rails.root}/config/notifier.yml"
      File.exists?(filepath) ? YAML.load(IO.read(filepath)) : {}
    end

end
