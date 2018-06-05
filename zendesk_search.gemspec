lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zendesk_search/version'

Gem::Specification.new do |spec|
  spec.name          = 'zendesk_search'
  spec.version       = ZendeskSearch::VERSION
  spec.authors       = ['koushic']
  spec.email         = ['koushicbabuts@gmail.com']

  spec.summary       = %q{Zendesk Search Client}
  spec.description   = %q{Ruby CLI client for Zendesk search}
  spec.homepage      = ''
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ''
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = 'bin/zendesk_search'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.56.0'
  spec.add_runtime_dependency 'thor', '0.20.0'
  spec.add_runtime_dependency 'highline', '1.7.10'
  spec.add_runtime_dependency 'colorize', '0.8.1'
end
