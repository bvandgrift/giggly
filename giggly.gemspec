# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "giggly/version"

Gem::Specification.new do |s|
  s.name        = "giggly"
  s.version     = Giggly::VERSION
  s.authors     = ["Ben Vandgrift", "Adam Hunter", "Tom Quackenbush"]
  s.email       = ["somethingfamiliar@gmail.com"]
  s.homepage    = %q{http://github.com/sfamiliar/giggly}
  s.summary     = %q{wrapper for the gigya rest and javascript apis}
  s.description = %q{breaks the gigya web api down into idiomatic ruby for your coding pleasure.}

  s.rubyforge_project = "giggly_2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<httparty>, ["~> 0.8.0"])
  s.add_runtime_dependency(%q<ruby-hmac>, ["~> 0.4.0"])
  s.add_development_dependency(%q<thoughtbot-shoulda>, ["~> 2.11.1"])
  s.add_development_dependency(%q<jnunemaker-matchy>, ["~> 0.4.0"])
  s.add_development_dependency(%q<mocha>, ["~> 0.9.7"])
  s.add_development_dependency(%q<fakeweb>, ["~> 1.3.0"])
end

