# frozen_string_literal: true

# This class reads the weblog and allows to read
# the visit (page and IP) line by line
class LogParser
  VISIT_REGEX = %r{(?<page>[\w/]+)\s(?<ip>\d+\.\d+\.\d+\.\d+)$}.freeze

  def initialize(filename)
    @log = File.open(filename)
  rescue Errno::ENOENT
    abort "Ops, the file '#{filename}' not exist!"
  end

  def next_entry
    line = log.gets
    unless line
      File.close(log)
      return nil
    end

    return nil unless (matches = line.match(VISIT_REGEX))

    {
      page: matches[:page],
      ip: matches[:ip]
    }
  end

  private

  attr_reader :log
end
