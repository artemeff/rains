# coding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'rains/version'

Gem::Specification.new do |gem|
  gem.name          = 'rains'
  gem.version       = Rains::VERSION
  gem.authors       = ['Yuri Artemev']
  gem.email         = ['i@artemeff.com']
  gem.summary       = 'Gem for doing OOP the right way'
  gem.description   = 'Contains some useful techniques and best-practices'
  gem.homepage      = 'https://github.com/artemeff/rains'
  gem.license       = 'MIT'
  gem.require_paths = ['lib']

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")

  gem.add_runtime_dependency 'virtus', '~> 1.0'
  gem.add_runtime_dependency 'assertion', '~> 0.2'
  gem.add_runtime_dependency 'inflecto', '~> 0.0'

  gem.add_development_dependency 'rake', '~> 10.3'
  gem.add_development_dependency 'rspec', '~> 3.3'
end
