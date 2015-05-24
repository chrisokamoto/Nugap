source 'https://rubygems.org'

ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record. Não funciona no Heroku
#gem 'sqlite3'
#gem 'mysql'
gem "mysql2"

# Use SCSS for stylesheets
#gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
#gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
#gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
#gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'compass-rails'
gem 'uglifier', '>= 1.3.0'
#  gem 'jquery-ui-rails'
#  gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'

#  gem 'jquery-ui-rails'
gem 'jquery-datatables-rails', :github => 'rweng/jquery-datatables-rails'
gem "jquery-rails", "< 3.0.0"
gem 'autonumeric-rails'

#gem 'compass-rails', github: 'milgner/compass-rails', branch: 'rails4'
#gem 'compass-rails'
gem 'chosen-rails'

# PDF
gem 'prawn', :git => "https://github.com/prawnpdf/prawn.git", :ref => '8028ca0cd2'
#gem "prawn", "~> 0.12.0"
gem "prawnto_2", :require => "prawnto"

#Heroku
gem 'rails_12factor', group: :production

# Use ActiveModel has_secure_password

 gem "bcrypt-ruby", :require => "bcrypt"

 #newRelic
 gem 'newrelic_rpm'

 #dalli for caching
 gem 'memcachier'
 gem 'dalli'

 #filter on datatables
 gem "wice_grid", '3.4.3'

 gem "font-awesome-rails"



 #aipim
 #gem "aipim-rails", "~> 0.0.182"

 #group :development, :test do
#	gem 'rspec-rails', '~> 2.14.0'
#	gem 'simplecov', require: false
#	gem 'cucumber-rails', :require => false
#	gem 'database_cleaner', '~> 1.0.1'
#	gem 'selenium-webdriver'
#	gem "aipim-rails", "~> 0.0.182"
 #end

# Use unicorn as the app server
group :production do 
  gem 'unicorn'
  gem 'unicorn-worker-killer'  
end

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
