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
      if result[page]
        result[page] += 1
      else
        result[page] = 1
      end
    end
    result
  end
end
