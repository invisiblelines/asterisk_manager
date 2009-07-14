require "socket"

# = Overview:
#
# A block based DSL for interacting with the Asterisk Manager through a TCP connection.

# = Usage:
#
# AsteriskManager.start('host', 'user', 'secret') do |asterisk|
#   asterisk.dial('SIP/123testphone', '7275551212')
# end

class AsteriskManager
  
  # <tt>host</tt>:: Asterisk host/IP.
  # <tt>port</tt>:: Defaults to 5038
  
  def initialize(host, port=5038)
    @host   = host
    @port   = port
    @socket = TCPSocket.new(@host, @port)
  end
  
  class << self
    
    # Convience method for new().start() 
    #
    # <tt>host</tt>:: Asterisk host/IP.
    # <tt>username</tt>:: Asterisk username.
    # <tt>secret</tt>:: Asterisk secret.
    # <tt>port</tt>:: Defaults to 5038
    
    def start(host, username, secret, port=5038, &block)
      new(host, port).start(username, secret, &block)
    end
    
  end
  
  # Logs in, yields the block, then logs off and closes the socket
  # <tt>host</tt>:: Asterisk host/IP.
  # <tt>username</tt>:: Asterisk username.
  
  # TODO: Check authentication response, flag logged in or raise error
  def start(username, secret, &block)
    return unless block_given?
    begin
      login(username, secret)
      return yield(self)
    ensure
      logout
      @socket.close
    end
  end
  
  # Sends the ping command
  
  def ping
    send_action "Ping"
  end
  
  # Dials the extension from the channel.
  # Required fields are:
  # <tt>channel</tt>:: Your Asterisk device.
  # <tt>extension</tt>:: The number to dial.
  # Options
  # <tt>context</tt>:: Context
  # <tt>priority</tt>:: Priority
  # <tt>caller_id</tt>:: Caller ID

  def originate(channel, extension, options={})
    options = {:context => "phones", :priority => 1, :callerid => "Asterisk Automatic Wardial"}.merge(options)
    send_action "Originate", {
      :channel  => channel,
      :context  => options[:context],
      :exten    => extension,
      :priority => options[:priority],
      :callerid => options[:callerid],
    }
  end
    
  protected
  
    # <tt>username</tt>:: Asterisk manager username.
    # <tt>secret</tt>:: Asterisk manager secret.
  
    def login(username, secret)
      send_action "Login", { 
        :username => username,
        :secret   => secret
      }
    end

    def logout
      send_action "Logoff"
    end
    
    # Send the action and options follow by extra new line.
    
    def send_action(action, options={})
      action = "Action: #{action}\r\n"
      action += options.map { |k,v| "#{k.to_s.capitalize}: #{v}"}.join("\r\n")
      action += options.any? ? "\r\n\r\n" : "\r\n"
      @socket.print(action)
    end
  
end