# frozen_string_literal: true

require_relative 'lib/mews/version'

Gem::Specification.new do |spec|
  spec.name = 'mews'
  spec.version = Mews::VERSION
  spec.authors = ['José']
  spec.email = ['jose.izquierdo.n@proton.me']

  spec.summary = 'A gem for retrieving exchange rates between different currencies.'
  spec.description = <<-DESC
    This gem provides an easy-to-use interface for obtaining exchange rates between currencies.
    You can integrate it into your application to perform currency conversions effortlessly and efficiently.
    Explore the world of international finance with ease!
  DESC
  spec.homepage = 'https://mews.com/pos_dev_team'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0'

  spec.metadata['allowed_push_host'] = 'https://mews.com/pos_dev_team'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://mews.com/pos_dev_team'
  spec.metadata['changelog_uri'] = 'https://mews.com/pos_dev_team'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.glob('{lib/**/*,exe/*,data/*}') + ['mews.gemspec']

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
