require 'rubygems'
require 'rake'
require 'fileutils'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name              = "giggly"
    gem.summary           = "wrapper for the gigya rest and javascript apis"
    gem.description       = "breaks the gigya web api down into idiomatic ruby for your coding pleasure."
    gem.email             = "somethingfamiliar@gmail.com"
    gem.homepage          = "http://github.com/sfamiliar/giggly"
    gem.authors           = ["Ben Vandgrift", "Adam Hunter"]
    gem.files             = FileList["[A-Z]*", "{examples,lib,test,javascripts}/**/*"]
    #gem.rubyforge_project = "giggly"
    
    gem.add_dependency('httparty', '0.4.5')
    gem.add_dependency('ruby-hmac', '0.3.2')
    
    gem.add_development_dependency('thoughtbot-shoulda', '>= 2.10.1')
    gem.add_development_dependency('jnunemaker-matchy', '0.4.0')
    gem.add_development_dependency('mocha', '0.9.4')
    gem.add_development_dependency('fakeweb', '>= 1.2.5')
    gem.add_development_dependency('redgreen', '>= 1.0.0')
  end
  
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "giggly #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

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

