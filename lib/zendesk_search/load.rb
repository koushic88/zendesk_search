require 'json'

module ZendeskSearch
  # Factory class that takes care of loading the json files to the storage.
  # In future when we want to scale the application,
  # we can choose to have different storage mechanism that best suits the needs.
  class Load
    def self.instance
      @instance
    end

    # Instantiates and memoize the HashStorage instance.
    # Type of storage mechanism used is hidden, and
    # can be changed to support any storage mechanism.
    def storage_instance
      @storage_instance ||= HashStorage.instance
    end

    # This factory method takes care of creating the
    # data storage from the JSON files.
    def load_json(directory)
      data = {}

      begin
        json_files = Dir["#{directory}/*.json"]

        if json_files.count.zero?
          puts "No json files found in the directory #{directory}"
          return nil
        end
        json_files.each do |file|
          data[File.basename(file, '.json')] = JSON.parse(File.read(file))
        end

        storage_instance.data = data
      rescue StandardError => e
        puts "Unexpected error happened! Please try again. #{e.message}".red
        return nil
      end
    end

    @instance = Load.new

    private_class_method :new
  end
end
