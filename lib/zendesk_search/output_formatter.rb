require 'yaml'

module ZendeskSearch
  # Class to format and display the search results
  class OutputFormatter
    def self.instance
      @instance
    end

    def display_results(output)
      puts output.to_yaml
    end

    @instance = OutputFormatter.new
    private_class_method :new
  end
end
