# frozen_string_literal: true

require 'rspec'
require_relative '../lib/log_parser'

describe LogParser do
  it 'initializes the LogParser' do
    log_parser = LogParser.new('data/webserver.log')
    expect(log_parser).to be_a(LogParser)
  end

  describe '#next_entry' do
    it 'gets the next entry' do
      log_parser = LogParser.new('data/webserver.log')

      entry = log_parser.next_entry

      expect(entry.keys).to include(:page, :ip)
    end
  end

  describe 'when file does not exist' do
    it 'raises an exception' do
      expect do
        LogParser.new('non-existent-file.log')
      end.to raise_error(Errno::ENOENT)
    end
  end
end
