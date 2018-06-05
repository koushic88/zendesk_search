require 'zendesk_search/search_interface'

module ZendeskSearch
  # Singleton storage class to hold the parsed JSON data in hash
  class HashStorage < SearchInterface
    attr_accessor :data

    def initialize
      @data = {}
    end

    def self.instance
      @instance
    end

    # This method returns the list of supported resources in the program.
    # These are typically name of the JSON files.
    def resources
      @data.keys
    end

    # This method returns all the search terms available for all the resources.
    def all_search_terms
      @data.each do |key, value|
        puts "The search terms available for #{key} "\
        "are #{value[0].keys}".to_yaml
      end
    end

    # This method returns the search terms for the given resource.
    # @param resource The type of resource the user is searching for
    # @return Array of search terms for the resource
    def search_terms(resource)
      return nil unless resources.include? resource
      @data[resource][0].keys
    end

    # Searches for the entity with the passed in parameters.
    # @param resource The type of resource the user is searching for.
    # @param search_term Search field to filter the data
    # @param search_value Search value to match the data
    def find_resource(resource, search_term, search_value)
      return nil unless resources.include? resource
      entities = @data[resource].select do |entity|
        entity[search_term].to_s == search_value.to_s
      end
      if entities.count.zero?
        puts 'No matching entities found for the given search criteria'
        return nil
      end

      return entities unless Association.instance.association_config[resource]
      include_associated_data(entities, resource)
    end

    private

    # Includes the associated data for the given entities.
    # @param entities The list of entities to find the associated data
    # @param resource The type of resource the user is searching for
    def include_associated_data(entities, resource)
      associations = Association.instance.association_config[resource]
      entities.each do |entity|
        associated_data = {}
        associations.each do |association|
          associated_data[association['association_name']] =
            filter_associated_data(association['source'],
                                   association['associated_term'],
                                   entity[association['term']],
                                   association['display_terms'])
        end

        entity['associated_data'] = associated_data
      end
    end

    # Filters the associated data with given input params.
    # @param resource Associated resource tied to the entity
    # @param search_term Associated search field in the resource
    # to filter the data
    # @param search_value Associated search value to match the data
    def filter_associated_data(resource, search_term, search_value,
                               display_terms)
      filtered_data = @data[resource].select do |entity|
        entity[search_term].to_s == search_value.to_s
      end

      filtered_data.map do |data|
        data.select { |key, _| display_terms.include? key }
      end
    end

    @instance = HashStorage.new

    private_class_method :new
  end
end
