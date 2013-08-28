source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.12'
gem 'pg'
gem 'jquery-rails'
gem 'draper'
gem 'devise'
gem 'cancan'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'wicked'
gem 'coderay', require: 'coderay'
gem 'htmlmin', require: 'htmlmin'
gem 'delayed_job_active_record'
gem 'newrelic_rpm'
gem 'ghazel-daemons' # See https://github.com/collectiveidea/delayed_job/issues/3

gem 'capistrano'
gem 'capistrano-helpers'
gem 'rvm-capistrano'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

group :development do
  gem 'lol_dba'
  gem 'rails_best_practices'
  gem 'quiet_assets'
  gem 'capistrano'
  gem 'capistrano-helpers'
end

group :development, :test do
  gem "rspec-rails", "~> 2.0"
  gem 'fabrication'
  gem 'simplecov', :require => false
  gem 'launchy'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara'
  #gem 'poltergeist'
  gem 'selenium-webdriver'
end
