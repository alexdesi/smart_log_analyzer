# frozen_string_literal: true

require 'rspec'
require_relative '../lib/log_analyzer'

describe LogAnalyzer do
  let(:log_parser) { double }

  # describe '#page_visits' do
  #   context 'when a unique IP visits a page multiple times' do
  #     it 'counts only unique visits pages' do
  #       allow(log_parser).to receive(:next_entry).and_return(
  #         { page: '/a', ip: '1.1.1.1' },
  #         { page: '/a', ip: '2.2.2.2' },
  #         { page: '/b', ip: '9.9.9.9' },
  #         { page: '/a', ip: '1.1.1.1' }, # page '/a' has been already visited by '1.1.1.1'
  #         nil
  #       )
  #       analyzer = described_class.new(log_parser)

  #       expect(analyzer.page_visits).to eq(
  #         ['/a', '1.1.1.1'] => 2,
  #         ['/a', '2.2.2.2'] => 1,
  #         ['/b', '9.9.9.9'] => 1
  #       )
  #     end
  #   end
  # end

  describe '#total_visits' do
    it 'returns empty hash when there are not entries' do
      allow(log_parser).to receive(:next_entry).and_return(nil)

      analyzer = described_class.new(log_parser)

      expect(analyzer.total_visits).to eq([])
    end

    it 'counts the total number of visits per page' do
      allow(log_parser).to receive(:next_entry).and_return(
        { page: '/a', ip: '1.1.1.1' },
        { page: '/b', ip: '2.2.2.2' },
        { page: '/a', ip: '3.3.3.3' },
        nil
      )
      analyzer = described_class.new(log_parser)

      expect(analyzer.total_visits).to eq(
        [
          ['/a', 2],
          ['/b', 1]
        ]
      )
    end

    context 'when a visitors (an IP) visits the same page multiple times' do
      it 'counts all the visits' do
        allow(log_parser).to receive(:next_entry).and_return(
          { page: '/a', ip: '1.1.1.1' },
          { page: '/a', ip: '2.2.2.2' },
          { page: '/b', ip: '9.9.9.9' },
          { page: '/a', ip: '1.1.1.1' }, # page '/a' has been already visited by '1.1.1.1'
          nil
        )
        analyzer = described_class.new(log_parser)

        expect(analyzer.total_visits).to eq(
          [
            ['/a', 3],
            ['/b', 1]
          ]
        )
      end
    end
  end

  describe '#unique_total_visits' do
    it 'returns empty hash when there are not entries' do
      allow(log_parser).to receive(:next_entry).and_return(nil)

      analyzer = described_class.new(log_parser)

      expect(analyzer.total_visits).to eq([])
    end

    context 'when a unique IP visits a page multiple times' do
      it 'counts only unique visit per IP' do
        allow(log_parser).to receive(:next_entry).and_return(
          { page: '/a', ip: '1.1.1.1' },
          { page: '/a', ip: '2.2.2.2' },
          { page: '/b', ip: '9.9.9.9' },
          { page: '/a', ip: '1.1.1.1' }, # page '/a' has been already visited by '1.1.1.1'
          nil
        )
        analyzer = described_class.new(log_parser)

        expect(analyzer.unique_total_visits).to eq(
          [
            ['/a', 2], # from IP '1.1.1.1' and '2.2.2.2'
            ['/b', 1]
          ]
        )
      end
    end
  end

  describe '#histogram' do
    it 'returns the page view count histogram' do
      allow(log_parser).to receive(:next_entry).and_return(
        { page: '/a', ip: '1.1.1.1' },
        { page: '/b', ip: '2.2.2.2' },
        { page: '/a', ip: '3.3.3.3' },
        nil
      )

      analyzer = described_class.new(log_parser)

      expect(analyzer.histogram).to eq(
        '/a 2\n' \
        '/b 1'
      )
    end
  end
end
