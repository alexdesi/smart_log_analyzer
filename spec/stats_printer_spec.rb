# frozen_string_literal: true

require 'rspec'
require_relative '../lib/stats_printer'

describe StatsPrinter do
  subject(:printer) { described_class.new(page_visits) }

  let(:page_visits) { [['/a', 3], ['/b', 2]] }

  describe '#print_all_visits' do
    it 'prints correct lines' do
      expect do
        printer.print_all_visits
      end.to output("/a 3 visits\n/b 2 visits\n").to_stdout
    end
  end

  describe '#print_unique_views' do
    it 'prints correct lines' do
      expect do
        printer.print_unique_views
      end.to output("/a 3 unique views\n/b 2 unique views\n").to_stdout
    end
  end
end
