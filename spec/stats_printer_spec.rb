# frozen_string_literal: true

require 'rspec'
require_relative '../lib/stats_printer'

describe StatsPrinter do
  describe '#print_all_visits' do
    it 'prints correct line' do
      page_visits = [
        [ '/a', 3],
        [ '/b', 2]
      ]

      described_class.print_all_visits(page_visits)

      expect{
        described_class.print_all_visits(page_visits)
      }.to output("/a 3 visits\n/b 2 visits\n").to_stdout
    end
  end

  describe '#print_unique_views' do
  end
end
