require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name        = "cg_common"
  gem.authors     = ["Benjamin Thouret",
                   "David Fugere",
                   "Nicolas Buduroi"]
  gem.email       = ["bthouret@codegenome.com",
                   "dfugere@codegenome.com",
                   "nbuduroi@gmail.com"]
  gem.homepage    = "https://github.com/codegenome/cg_common"
  gem.summary     = %q{A bunch of common code that should be used in every project.}
  gem.description = %q{Currently include:
 * a feedback link helper to create ticket in cg-project}

  gem.rubyforge_project = "cg_common"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
end

Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'

Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

tasks = Rake.application.instance_variable_get('@tasks')
tasks.delete('release')
tasks.delete('gemcutter:release')
