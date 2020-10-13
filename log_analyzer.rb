# frozen_string_literal: true

require_relative 'lib/log_parser'
require_relative 'lib/log_analyzer'
require_relative 'lib/stats_printer'

FILENAME = 'data/webserver.log'

parser = LogParser.new(FILENAME)

log_analyzer = LogAnalyzer.new(parser)

puts 'Total number of visit'
StatsPrinter.new(log_analyzer.total_visits).print_all_visits

puts '- - -'

StatsPrinter.new(log_analyzer.unique_total_views).print_unique_views
