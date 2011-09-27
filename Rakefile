require 'rubygems'
require 'rake'
require 'fileutils'

require "bundler/gem_tasks"

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end

task :default => :test

def copy_js(source, destination)
  destination ||= '.'
  FileUtils.cp File.join(File.dirname(__FILE__), 'javascripts', source), destination
  puts "wrote #{source} to #{destination}"
end

namespace :giggly do
  desc "writes out the giggly-socialize.js api wrapper in the given directory. ex) rake giggly:js IN=path/to/write (IN defaults to the current directory)"
  task :js do
    copy_js 'giggly-socialize.js', ENV['IN']
  end
  
  desc "writes out the minified version of giggly-socialize"
  task :"js:min" do
    copy_js 'giggly-socialize-min.js', ENV['IN']
  end
end

