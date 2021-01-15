# frozen_string_literal: true

# This class analyze the log
class LogAnalyzer
  def initialize(log_parser)
    @log_parser = log_parser
  end

  def total_visits
    visits_grouped_by_page
      .map { |page, visits| [page, visits.sum { |visit| visit[1] }] }
      .sort_by { |_page, visits| -visits }
  end

  def unique_total_views
    visits_grouped_by_page
      .map { |page, visits| [page, visits.count] }
      .sort_by { |_page, visits| -visits }
  end

  private

  attr_reader :log_parser

  # Output example:
  # {
  #   ['/a', '1.1.1.1'] => 2,
  #   ['/a', '2.2.2.2'] => 1,
  #   ...
  # }
  def page_ip_visit_counts
    return @page_ip_visit_counts if @page_ip_visit_counts

    result = {}
    while (entry = log_parser.next_entry)
      page_ip = [entry[:page], entry[:ip]]

      result[page_ip] ||= 0
      result[page_ip] += 1
    end

    @page_ip_visit_counts = result
    result
  end

  # Output example:
  #   {"/a"=>[[["/a", "1.1.1.1"], 2], [["/a", "2.2.2.2"], 1]],
  #    "/b"=>[[["/b", "9.9.9.9"], 1]]}
  def visits_grouped_by_page
    page_ip_visit_counts
      .group_by { |page_ip, _item| page_ip.first }
  end
end
