# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cg_common}
  s.version = "1.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Benjamin Thouret}, %q{David Fugere}, %q{Nicolas Buduroi}]
  s.date = %q{2011-07-07}
  s.description = %q{Currently include:
 * a feedback link helper to create ticket in cg-project}
  s.email = [%q{bthouret@codegenome.com}, %q{dfugere@codegenome.com}, %q{nbuduroi@gmail.com}]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".gitignore",
    "Gemfile",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/views/layouts/footer/_version.html.erb",
    "cg_common.gemspec",
    "examples/README.md",
    "examples/cg_project.yml",
    "examples/monit/delayed_job.erb",
    "examples/monit/monitrc.erb",
    "examples/monit/mysql.erb",
    "examples/monit/nginx.erb",
    "examples/monit/server.erb",
    "examples/monit/sphinx.erb",
    "examples/monit/sshd.erb",
    "examples/rails-env.css",
    "lib/cg_common.rb",
    "lib/cg_common/capistrano.rb",
    "lib/cg_common/capistrano/tasks/cg.rb",
    "lib/cg_common/capistrano/tasks/db.rb",
    "lib/cg_common/capistrano/tasks/delayed_job.rb",
    "lib/cg_common/capistrano/tasks/deploy.rb",
    "lib/cg_common/capistrano/tasks/monit.rb",
    "lib/cg_common/capistrano/tasks/sphinx.rb",
    "lib/cg_common/capistrano/templates/maintenance.erb",
    "lib/cg_common/cg_project_config.rb",
    "lib/cg_common/development_mail_interceptor.rb",
    "lib/cg_common/helpers.rb",
    "lib/cg_common/railtie.rb",
    "test/helper.rb",
    "test/test_jeweler_test.rb"
  ]
  s.homepage = %q{https://github.com/codegenome/cg_common}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{cg_common}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A bunch of common code that should be used in every project.}
  s.test_files = [%q{test/helper.rb}, %q{test/test_jeweler_test.rb}]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cg_common>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano-ext>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano_colors>, [">= 0"])
      s.add_runtime_dependency(%q<erubis>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<cg_common>, [">= 0"])
      s.add_dependency(%q<capistrano>, [">= 0"])
      s.add_dependency(%q<capistrano-ext>, [">= 0"])
      s.add_dependency(%q<capistrano_colors>, [">= 0"])
      s.add_dependency(%q<erubis>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<cg_common>, [">= 0"])
    s.add_dependency(%q<capistrano>, [">= 0"])
    s.add_dependency(%q<capistrano-ext>, [">= 0"])
    s.add_dependency(%q<capistrano_colors>, [">= 0"])
    s.add_dependency(%q<erubis>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

