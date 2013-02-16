require 'net/imap'

class ImapReader
  def initialize(params = {})
    @host = params[:host]
    @port = params[:port] || '143'
    @username = params[:username]
    @password = params[:password]

    @imap = Net::IMAP.new(params[:host], { port: params[:port] })
    @capability = @imap.capability

    @imap.authenticate(auth_type, params[:username], params[:password])
  end

  def folders
    @imap.list('','%').collect { |folder| folder.name }
  end

  private

    def auth_type
      capability = @imap.capability

      if capability.include?('AUTH=LOGIN')
        'LOGIN'
      else
        'CRAM-MD5'
      end
    end

end
