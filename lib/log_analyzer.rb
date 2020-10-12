# frozen_string_literal: true

# This class analyze the log
class LogAnalyzer
  def initialize(log)
    @log = log
  end

  def views
    result = {}

    @log.each_line do |line|
      page, ip = line.split
      result[page] ||= 0
      result[page] += 1
    end
    result
  end

  def histogram
    ordered_view.map do |page, count|
      "#{page} #{count}"
    end.join('\n')
  end

  private

  def ordered_view
    views.sort_by { |_page, count| -count }
  end
end
