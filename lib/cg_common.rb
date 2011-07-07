
module CgCommon
  GEM_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  def self.gem_path(*string)
    File.join(GEM_ROOT, *string)
  end
end

if defined?(::Rails::Railtie)
  require 'cg_common/railtie'
end
