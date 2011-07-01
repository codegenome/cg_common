# Global Capistrano Recipes for Code Genome Projects
#   add "require 'cg_common/capistrano'" to your deploy.rb file

Capistrano::Configuration.instance.load do

  # needed for git password prompts
  default_run_options[:pty] = true

  Dir[File.expand_path(File.join(File.dirname(__FILE__), 'capistrano', 'tasks', '*'))].each do |ns|
    require ns
  end

end
