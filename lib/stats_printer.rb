# frozen_string_literal: true

# This class print the outcomes of the LogAnalyzer
class StatsPrinter
  def initialize(page_visits)
    @page_visits = page_visits
  end

  def print_all_visits
    print_entries { |entry| "#{entry[0]} #{entry[1]} visits" }
  end

  def print_unique_views
    print_entries { |entry| "#{entry[0]} #{entry[1]} unique views" }
  end

  private

  def print_entries
    page_visits.each do |entry|
      puts(yield entry)
    end
  end

  attr_reader :page_visits
end
