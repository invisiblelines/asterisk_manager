require 'spec_helper'

describe AsteriskManager::Client do

  let(:socket) { instance_double('TCPSocket', print: true, close: true) }

  describe "a new session" do

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

  describe 'originating a call' do
    before do
      allow(TCPSocket).to receive(:new).and_return(socket)
    end

    let(:channel)   { 'SIP/101test' }
    let(:extension) { '8135551212' }
    let(:options) {
      {
        context: 'default',
        priority: 1,
        callerid: '3125551212'
      }
    }

    it 'sends an originate command' do
      expect(socket).to receive(:print).with("Action: Originate\r\nChannel: #{channel}\r\nContext: #{options[:context]}\r\nExten: #{extension}\r\nPriority: #{options[:priority]}\r\nCallerid: #{options[:callerid]}\r\n\r\n")
      AsteriskManager::Client.start('127.0.0.1', 'tester', 'secret') { |asterisk| asterisk.originate(channel, extension, options) }
    end
  end

  describe 'dbput' do
    let(:socket) { instance_double('TCPSocket', print: true, close: true) }

    before do
      allow(TCPSocket).to receive(:new).and_return(socket)
    end

    it 'sends a dbput command' do
      expect(socket).to receive(:print).with("Action: DBPut\r\nFamily: diverts\r\nKey: 0160\r\nVal: 299\r\n\r\n")
      AsteriskManager::Client.start('127.0.0.1', 'tester', 'secret') { |asterisk| asterisk.dbput('diverts', '0160', '299') }
    end
  end

end
