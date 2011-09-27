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
# 
# begin
#   require 'rcov/rcovtask'
#   Rcov::RcovTask.new do |test|
#     test.libs << 'test'
#     test.pattern = 'test/**/*_test.rb'
#     test.verbose = true
#   end
# rescue LoadError
#   task :rcov do
#     abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
#   end
# end
# 
# 
task :default => :test
# 
# require 'rake/rdoctask'
# Rake::RDocTask.new do |rdoc|
#   if File.exist?('VERSION.yml')
#     config = YAML.load(File.read('VERSION.yml'))
#     version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
#   else
#     version = ""
#   end
# 
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "giggly #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

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

