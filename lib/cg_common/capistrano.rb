# Global Capistrano Recipes for Code Genome Projects
#   add "require 'cg_common/capistrano'" to your deploy.rb file

Capistrano::Configuration.instance.load do

  # needed for git password prompts
  default_run_options[:pty] = true

  require 'cg_common'
  tasks_path = CgCommon.gem_path 'lib', 'cg_common', 'capistrano', 'tasks', '*'
  Dir[tasks_path].each do |ns|
    require ns
  end

end
