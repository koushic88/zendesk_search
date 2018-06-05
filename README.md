# ZendeskSearch
 
 This is a basic search command line application. We use hash as a storage mechanism to store the parsed JSON data. The code   is designed in such a way that the storage mechanism can be changed as needed depending on scalability. 

## Requirements
   Make sure bundler is installed (gem install bundler)
   Ruby 2+
   
Clone this repo to your machine

```ruby
git clone https://github.com/koushic88/zendesk_search.git
```

Navigate to the project directory And then execute:

    $ bundle install

## Usage

To run the program, execute this command

  $ bundle exec bin/zendesk_search

If you run into issues starting the executable, it is most probably has to do with file permissions in the system.

    $ chmod +x script/delayed_job

To run the rspec test, execute this command

    $ bundle exec rspec

To run the lint, execute this command

    $ rubocop

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/koushic88/zendesk_search. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ZendeskSearch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/koushic88/zendesk_search/blob/master/CODE_OF_CONDUCT.md).
