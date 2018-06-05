require 'yaml'

module ZendeskSearch
  # Class to load the associations between resources
  class Association
    attr_accessor :association_config

    def initialize
      @association_config = {}
    end

    def self.instance
      @instance
    end

    def load_config(directory)
      @association_config = YAML.load_file("#{directory}/associations.yml")
    rescue StandardError => e
      puts 'Unexpected error happened while loading! '\
      "Please try again. #{e.message}".red
      nil
    end

    @instance = Association.new

    private_class_method :new
  end
end
