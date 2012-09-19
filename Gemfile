source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'thin', '~> 1.4.1'
gem 'bcrypt-ruby', '~> 3.0.1'
gem 'devise', '~> 2.1.2'
gem 'activeadmin', '~> 0.5.0'
gem "meta_search", "~> 1.1.3"
gem 'faker', '~> 1.0.1'

group :development, :test do
  gem 'sqlite3', '~> 1.3.5'
  gem 'rspec-rails', '>= 2.10.1'
  gem 'factory_girl_rails', '~> 4.0.0'
end

gem 'annotate', '~> 2.5.0', group: :development


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.4'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
  gem 'therubyracer'
end

gem 'jquery-rails'

group :test do
  gem 'email_spec', '>= 1.2.1'
  gem 'cucumber-rails', '>= 1.3.0', require: false
  gem 'shoulda-matchers', '~> 1.3.0'
# gem 'webrat', '~> 0.7.3'
  gem 'database_cleaner', '~> 0.8.0'
  gem 'capybara', '>= 1.1.2'
  gem 'launchy', '>= 2.1.0'
end

group :production do
  gem 'pg', '~> 0.12.2'
end
