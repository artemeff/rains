source 'https://rubygems.org'

gemspec

gem 'rubocop', '~> 0.34'

group :test do
  gem 'codeclimate-test-reporter', require: nil
end

group :tools do
  platform :mri do
    gem 'mutant', '>= 0.8.0', github: 'mbj/mutant', branch: 'master'
    gem 'mutant-rspec'
  end
end
