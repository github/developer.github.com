source "https://rubygems.org"
gemspec

gem "rake"

group :development, :test do
  gem "rspec", "~> 2.11"

  gem "sinatra", :git => "https://github.com/sinatra/sinatra.git"
  gem "json"
  gem "mime-types", "~> 1.18"

  unless ENV["CI"]
    gem "guard-rspec", "~> 0.7"
    gem 'rb-fsevent', '~> 0.9.1'
  end
end

group :perf do
  gem "patron", "~> 0.4"
  gem "curb", "~> 0.8.0"
end
