# frozen_string_literal: true

# This class reads the weblog and allows to read
# the visit (page and IP) line by line
class LogParser
  def initialize(filename)
    @log = File.open(filename)
  end

  def next_entry
    line = log.gets
    page, ip = line.split

    {
      page: page,
      ip: ip
    }
  end

  private

  attr_reader :log
end
