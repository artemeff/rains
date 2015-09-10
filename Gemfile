source 'https://rubygems.org'

gemspec

group :test do
  gem 'codeclimate-test-reporter', require: nil
end

group :tools do
  gem 'rubocop', '~> 0.34'

  platform :mri do
    gem 'mutant', '>= 0.8.0', github: 'mbj/mutant', branch: 'master'
    gem 'mutant-rspec'
  end
end
