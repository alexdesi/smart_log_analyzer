# frozen_string_literal: true

require_relative 'lib/log_parser'
require_relative 'lib/log_analyzer'
require_relative 'lib/stats_printer'

def show_usage
  puts 'Smart Log Analyzer usage:'
  puts '  smart_log_analyzer filename'
  puts
  puts 'Arguments:'
  puts '  filename: the log file containing a page name and a IP address each line.'
  puts
  puts 'Example:'
  puts '  smart_log_analyzer data/webserver.log'
  puts '- - -'
end

if ARGV.length != 1
  show_usage
  return
end

filename = ARGV.first

begin
  parser = LogParser.new(filename)
rescue Errno::ENOENT
  puts "Ops, the file '#{filename}' not exist!"
  return
end

log_analyzer = LogAnalyzer.new(parser)

puts 'Total number of visit'
StatsPrinter.new(log_analyzer.total_visits).print_all_visits

puts '- - -'

StatsPrinter.new(log_analyzer.unique_total_views).print_unique_views
