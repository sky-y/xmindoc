# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "xmindoc/version"

Gem::Specification.new do |s|
  s.name        = "xmindoc"
  s.version     = Xmindoc::VERSION
  s.authors     = ["Yuki Fujiwara"]
  s.email       = ["sky.y.0079@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Exports XMind Mindmap to any documents with Pandoc.}
  s.description = %q{Exports XMind Mindmap to any documents with Pandoc.}

  s.rubyforge_project = "xmindoc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
