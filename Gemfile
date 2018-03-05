source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
# Use mysql2 as the database for Active Record
gem 'mysql2'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'rack-cors', :require => 'rack/cors'

# webscale
gem 'graphql'
gem 'graphiql-rails', :git => 'https://github.com/GraphQL-Query-Planner/graphiql-rails.git'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

gem 'graphql-analyzer'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'ffaker'
end

group :test do
  gem 'rspec-rails'
  gem 'db-query-matchers'
  gem 'factory_girl_rails'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
