# coding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'rains/version'

Gem::Specification.new do |spec|
  spec.name          = 'rains'
  spec.version       = Rains::VERSION
  spec.authors       = ['Yuri Artemev']
  spec.email         = ['i@artemeff.com']

  spec.summary       = %q{Gem for doing OOP the right way}
  spec.description   = %q{Contains some useful techniques and best-practices}
  spec.homepage      = 'https://github.com/artemeff/rains'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0').reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'virtus', '~> 1.0'
  spec.add_runtime_dependency 'assertion', '~> 0.2'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
