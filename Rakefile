# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "awrence"
  gem.homepage = "http://github.com/futurechimp/awrence"
  gem.license = "MIT"
  gem.summary = %Q{Camelize your snake keys when working with JSON APIs}
  gem.description = %Q{Have you ever needed to automatically convert Ruby-style
    snake_case to CamelCase or camelBack hash keys?

    Awrence to the rescue.

    This gem recursively converts all snake_case keys in a hash
    structure to camelBack.  }
  gem.email = "dave.hrycyszyn@headlondon.com"
  gem.authors = ["Dave Hrycyszyn"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new
