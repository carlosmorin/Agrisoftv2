source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'aws-sdk-s3', require: false
gem 'mini_magick'

gem 'slim-rails'
gem 'simple_form', '~> 5.0', '>= 5.0.1'
gem 'link_to_action', '~> 0.3.0'
gem 'will_paginate', '~> 3.2', '>= 3.2.1'
gem 'paranoia', '~> 2.4', '>= 2.4.2'
gem 'paper_trail', '~> 10.3', '>= 10.3.1'
gem 'active_storage_validations'
gem 'devise'
gem 'nested_form', '~> 0.3.2'
gem 'cocoon', '~> 1.2', '>= 1.2.14'
gem 'sassc-rails'
gem 'rails-i18n'
gem 'country_select'
gem 'breadcrumbs_on_rails'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'rubyzip'
gem 'axlsx'
gem 'axlsx_rails'
gem 'axlsx_styler', '~> 1.0'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'master' # Previously '4-0-dev' or '4-0-maintenance' branch
  end
  gem "database_cleaner"
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry', '~> 0.12.2'
  gem 'awesome_print', '~> 1.8'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
