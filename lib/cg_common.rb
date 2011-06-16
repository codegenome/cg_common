require "cg_common/version"

module CgCommon
end

if defined?(::Rails::Railtie)
  require 'cg_common/railtie'
end
