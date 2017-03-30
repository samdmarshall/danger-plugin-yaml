# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name = 'danger-plugin-yaml'
  spec.version = DangerYAML::VERSION
  spec.authors = ['Samantha Marshall']
  spec.email = ['hello@pewpewthespells.com']
  spec.description = %q{plugin for danger to lint yaml files.}
  spec.summary = %q{uses yamllint for linting yaml files.}
  spec.homepage = 'https://github.com/samdmarshall/danger-plugin-yaml'
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'danger'

  # Let's you test your plugin via the linter
  spec.add_development_dependency "yard", '~> 0.8'
  
  # General ruby development
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  
  #  Testing support
  spec.add_development_dependency 'rspec', '~> 3.4'
  
  # Makes testing easy via `bundle exec guard`
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  
  # If you want to work on older builds of ruby
  spec.add_development_dependency 'listen', '3.0.7'
end
