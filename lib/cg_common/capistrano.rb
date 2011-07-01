# Global Capistrano Recipes for Code Genome Projects
#   add "require 'cg_common/capistrano'" to your deploy.rb file

Capistrano::Configuration.instance.load do

  Dir[File.expand_path(File.join(File.dirname(__FILE__), 'recipes', '*'))].each do |ns|
    require ns
  end

end
