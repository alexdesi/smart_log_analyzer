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

  # Note: if the row does not match with the regex, it just skips it
  #       and does not raise error (fault tollerant approach).
  def next_entry
    line = log.gets
    return nil unless line
    return nil unless (matches = line.match(VISIT_REGEX))

    {
      page: matches[:page],
      ip: matches[:ip]
    }
  end

  private

  attr_reader :log
end
