# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cg_common}
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Benjamin Thouret", "David Fugere", "Nicolas Buduroi"]
  s.date = %q{2011-06-28}
  s.description = %q{Currently include:
 * a feedback link helper to create ticket in cg-project}
  s.email = ["bthouret@codegenome.com", "dfugere@codegenome.com", "nbuduroi@gmail.com"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".gitignore",
    "Gemfile",
    "README.md",
    "Rakefile",
    "VERSION",
    "cg_common.gemspec",
    "lib/cg_common.rb",
    "lib/cg_common/cg_project_config.rb",
    "lib/cg_common/development_mail_interceptor.rb",
    "lib/cg_common/feedbacks_helper.rb",
    "lib/cg_common/railtie.rb",
    "lib/cg_common/version.rb",
    "test/helper.rb",
    "test/test_jeweler_test.rb"
  ]
  s.homepage = %q{https://github.com/codegenome/cg_common}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{cg_common}
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{A bunch of common code that should be used in every project.}
  s.test_files = ["test/helper.rb", "test/test_jeweler_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cg_common>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<cg_common>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<cg_common>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

