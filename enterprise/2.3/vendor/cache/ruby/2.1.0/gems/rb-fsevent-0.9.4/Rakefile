# -*- encoding: utf-8 -*-
require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

namespace(:spec) do
  desc "Run all specs on multiple ruby versions"
  task(:portability) do
    versions = %w[1.8.7-p371 1.9.3-p362 2.0.0-dev rbx-2.0.0-dev jruby-1.7.1]
    versions.each do |version|
      # system <<-BASH
      #   bash -c 'source ~/.rvm/scripts/rvm;
      #            rvm #{version};
      #            echo "--------- version #{version} ----------\n";
      #            bundle install;
      #            rake spec'
      # BASH
      system <<-BASH
        bash -c 'export PATH="$HOME/.rbenv/bin:$PATH";
                 [[ `which rbenv` ]] && eval "$(rbenv init -)";
                 [[ ! -a $HOME/.rbenv/versions/#{version} ]] && rbenv install #{version};
                 rbenv shell #{version};
                 rbenv which bundle 2> /dev/null || gem install bundler;
                 bundle install;
                 rake spec;'
      BASH
    end
  end
end
