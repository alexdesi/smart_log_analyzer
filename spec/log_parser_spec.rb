# frozen_string_literal: true

require 'rspec'
require_relative '../lib/log_parser'

# rubocop:disable Metrics/BlockLength
describe LogParser do
  subject(:log_parser) { LogParser.new(filename) }

  it 'initializes the LogParser' do
    log_parser = LogParser.new('spec/fixtures/webserver_sample.log')
    expect(log_parser).to be_a(LogParser)
  end

  describe '#next_entry' do
    context 'when the log file exists' do
      let(:filename) { 'spec/fixtures/webserver_sample.log' }

      it 'gets the next entry' do
        entry = log_parser.next_entry

        expect(entry.keys).to include(:page, :ip)
      end
    end

    context 'when there are invalid entries in the log' do
      let(:filename) { 'spec/fixtures/webserver_with_errors.log' }

      it 'skip the invalid entries' do
        result = []
        4.times { result << log_parser.next_entry }

        expect(result.compact).to eq([
                                       { ip: '1.1.1.1', page: '/a' },
                                       { ip: '2.2.2.2', page: '/b' }
                                     ])
      end
    end

    context 'when file does not exist' do
      let(:filename) { 'non-existent-file.log' }

      it 'raises an exception' do
        expect do
          LogParser.new(filename)
        end.to raise_error("Ops, the file '#{filename}' not exist!")
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
