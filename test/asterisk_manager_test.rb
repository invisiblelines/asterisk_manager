require File.join(File.dirname(__FILE__), 'test_helper')

class AsteriskManagerTest < Test::Unit::TestCase
  
  context "a new session" do
    
    setup do
      TCPSocket.stubs(:new).returns(@socket = mock("socket"))
      @socket.stubs(:print)
      @socket.stubs(:close)
    end
    
    should "create a new socket" do
       TCPSocket.expects(:new).returns(@socket)
       AsteriskManager.new("127.0.0.1")
     end
     
     should "return if no block is given" do
       @socket.expects(:print).never
       AsteriskManager.start("127.0.0.1", "tester", "secret")
     end
    
    should "login a new session" do
      @socket.expects(:print).with("Action: Login\r\nUsername: tester\r\nSecret: secret\r\n\r\n")
      AsteriskManager.start("127.0.0.1", "tester", "secret") { |asterisk| asterisk.ping }
    end
    
    should "yield the block" do
      @socket.expects(:print).with("Action: Ping\r\n\r\n")
      AsteriskManager.start("127.0.0.1", "tester", "secret") { |asterisk| asterisk.ping }
    end
    
    should "logoff at the end of the session" do
      @socket.expects(:print).with("Action: Logoff\r\n\r\n")
      AsteriskManager.start("127.0.0.1", "tester", "secret") { |asterisk| asterisk.ping }
    end
    
    should "ensure the socket is closed when the session is closed" do
      @socket.expects(:close)
      AsteriskManager.start("127.0.0.1", "tester", "secret") { |asterisk| asterisk.ping }
    end
    
  end
    
end
