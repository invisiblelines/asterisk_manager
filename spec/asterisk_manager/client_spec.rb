require 'spec_helper'

describe AsteriskManager::Client do

  describe "a new session" do

    let(:socket) { instance_double('TCPSocket', print: true, close: true) }

    before do
      allow(TCPSocket).to receive(:new).and_return(socket)
    end

    it "creates a new socket" do
      expect(TCPSocket).to receive(:new).and_return(socket)
      AsteriskManager::Client.new("127.0.0.1")
    end

    it "returns if no block is given" do
      expect(socket).not_to receive(:print)
      AsteriskManager::Client.start("127.0.0.1", "tester", "secret")
    end

    it "logs in at the start of a session" do
      expect(socket).to receive(:print).with("Action: Login\r\nUsername: tester\r\nSecret: secret\r\n\r\n")
      AsteriskManager::Client.start('127.0.0.1', 'tester', 'secret') { |asterisk| asterisk.ping }
    end

    it "yields the block" do
      expect(socket).to receive(:print).with("Action: Ping\r\n\r\n")
      AsteriskManager::Client.start("127.0.0.1", "tester", "secret") { |asterisk| asterisk.ping }
    end

    it "logs off at the end of the session" do
      expect(socket).to receive(:print).with("Action: Logoff\r\n\r\n")
      AsteriskManager::Client.start("127.0.0.1", "tester", "secret") { |asterisk| asterisk.ping }
    end

    it "ensures the socket is closed when the session is closed" do
      expect(socket).to receive(:close)
      AsteriskManager::Client.start("127.0.0.1", "tester", "secret") { |asterisk| asterisk.ping }
    end

  end

end
