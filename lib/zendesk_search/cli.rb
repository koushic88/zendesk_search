require 'thor'
require 'highline/import'

module ZendeskSearch
  # Command line interface class to handle display of commands
  class CLI < Thor
    default_task :load

    desc 'Zendesk Search', 'Command line tool for Zendesk Search'
    option :path, default: 'dataset', desc: 'path to JSON files directory'
    def load
      @cli = HighLine.new

      say "Hello #{ENV['USER']}, Welcome to Zendesk Search!".blue
      say 'This interactive tool will make your search experience better.'.blue
      say 'We are loading your dataset now'.blue

      @load_instance = Load.instance
      @storage_instance = @load_instance.storage_instance

      # Loads the json files to storage
      load_main_menu if @load_instance.load_json(options[:path]) &&
                        Association.instance.load_config(options[:path])
    end

    no_commands do
      # Loads the main menu shell for the CLI, and it loops till it is exited.
      def load_main_menu
        loop do
          main_menu
        end
      end

      # Displays the prompt for the menu selection.
      def main_menu
        @cli.choose do |menu|
          menu.shell = true
          menu.prompt = 'Main Menu: Select option'
          menu.choice 'Press 1 to search Zendesk.' do
            search_menu
          end
          menu.choice 'Press 2 to view list of searchable fields.' do
            @storage_instance.all_search_terms
          end
          menu.choice 'Press 3 to exit program.' do
            exit(0)
          end
        end
      end

      # Handles the user input for the Zendesk Search operation.
      def get_search_input(resource)
        term = @cli.ask('Please enter the search term ', String) do |ques|
          ques.in = @storage_instance.search_terms(resource)
        end
        value = @cli.ask 'Please enter the search value'

        SearchAPI.search(resource, term, value)
      end

      # Displays all the Zendesk search options.
      def search_menu
        resources = @storage_instance.resources
        @cli.choose do |menu|
          menu.prompt = 'search: Select option'

          count = 0
          resources.each do |resource|
            menu.choice "Press #{count += 1} to search #{resource}." do
              get_search_input(resource.to_s)
            end
          end
        end
      end
    end
  end
end
