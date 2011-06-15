# -*- Encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cg_common/version"

Gem::Specification.new do |s|
  s.name        = "cg_common"
  s.version     = CgCommon::VERSION
  s.authors     = ["Benjamin Thouret",
                   "David Fugere",
                   "Nicolas Buduroi"]
  s.email       = ["bthouret@codegenome.com",
                   "dfugere@codegenome.com",
                   "nbuduroi@gmail.com"]
  s.homepage    = "https://github.com/codegenome/cg_common"
  s.summary     = %q{A bunch of common code that should be used in every project.}
  s.description = %q{Currently include:
 * a feedback link helper to create ticket in cg-project}

  s.rubyforge_project = "cg_common"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
