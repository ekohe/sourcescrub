# frozen_string_literal: true

require_relative 'lib/sourcescrub/version'

Gem::Specification.new do |spec|
  spec.name          = 'sourcescrub'
  spec.version       = Sourcescrub::VERSION
  spec.authors       = ['Encore Shao']
  spec.email         = ['encore@ekohe.com']

  spec.summary       = 'Sourcescrub is a ruby wrapper based on Source Scrub API.'
  spec.description   = 'Sourcescrub is a ruby wrapper based on Source Scrub API.'
  spec.homepage      = 'https://github.com/ekohe/sourcescrub'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ekohe/sourcescrub'
  spec.metadata['changelog_uri'] = 'https://github.com/ekohe/sourcescrub/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'

  # VCR for testing APIs
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  # Rubocop - rubocop --auto-gen-config
  spec.add_development_dependency 'rubocop'
  # For debug binding.pry
  spec.add_development_dependency 'pry'
end
