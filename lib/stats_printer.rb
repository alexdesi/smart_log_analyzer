class StatsPrinter
  def self.print_all_visits(page_visits)
    page_visits.each do |entry|
      puts "#{entry[0]} #{entry[1]} visits"      
    end
  end
end
