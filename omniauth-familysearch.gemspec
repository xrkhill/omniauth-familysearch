# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-familysearch/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Richard Hill']
  gem.email         = ['xrkhill@gmail.com']
  gem.description   = %q{OmniAuth strategy for FamilySearch OAuth2 API}
  gem.summary       = %q{OmniAuth strategy for FamilySearch OAuth2 API}
  gem.homepage      = 'https://github.com/xrkhill/omniauth-familysearch'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'omniauth-familysearch'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::FamilySearch::VERSION

  gem.add_runtime_dependency('multi_json')
  gem.add_runtime_dependency('faraday', '~> 0.8.9')
  gem.add_runtime_dependency('omniauth-oauth2', '~> 1.0')


  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
