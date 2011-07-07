
module CgCommon
  GEM_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

if defined?(::Rails::Railtie)
  require 'cg_common/railtie'
end
