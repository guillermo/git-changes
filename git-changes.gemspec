# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git-changes/version"

Gem::Specification.new do |s|
  s.name        = "git-changes"
  s.version     = Git::Changelog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Guillermo Álvarez Fernández <guillermo@cientifico.net>"]
  s.email       = ["guillermo@cientifico.net"]
  s.homepage    = ""
  s.summary     = %q{Generate a changelog based on git log.}
  s.description = %q{It taks the output from git-log, parses it, and output with the standard format of changelog.}

  s.rubyforge_project = "git-changelog"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency("ruby-debug")
  s.add_development_dependency("rake")
  s.add_development_dependency("bundler")
end
