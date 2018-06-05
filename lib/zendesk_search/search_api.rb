module ZendeskSearch
  # This class will implement the search module. Any future search API
  # (Rest calls) can be implemented here
  class SearchAPI
    # This search API handles the search request to the data storage
    # @param resource Type of resource we want to search for eg., users
    # @param search_term Search field to filter the data
    # @param search_value Search value to match the data
    def self.search(resource, search_term, search_value)
      results = Load.instance.storage_instance.find_resource(resource,
                                                             search_term,
                                                             search_value)
      OutputFormatter.instance.display_results(results) if results
    end
  end
end
