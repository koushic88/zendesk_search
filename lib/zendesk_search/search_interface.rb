module ZendeskSearch
  # This interface class will enforce the implementation of search module
  class SearchInterface
    def all_search_terms
      raise 'implementation not defined!'
    end

    def search_terms(_resource)
      raise 'implementation not defined!'
    end

    def find_resource(_resource, _search_term, _search_value)
      raise 'implementation not defined!'
    end
  end
end
