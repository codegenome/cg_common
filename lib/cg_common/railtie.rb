require 'cg_common'

module CgCommon
  class Railtie < Rails::Railtie
    initializer "cg_common.action_view" do |app|
      require "cg_common/helpers"
      ActionView::Base.send :include, CgCommon::Helpers
    end

    initializer "cg_common.action_controller" do |app|
      gem_view_path =
        File.expand_path(File.join(CgCommon::GEM_ROOT, 'app', 'views'))
      ActionController::Base.append_view_path gem_view_path
    end

    initializer "cg_common.action_mailer" do |app|
      require "cg_common/development_mail_interceptor"
      ActionMailer::Base.register_interceptor DevelopmentMailInterceptor if Rails.env.development?
    end
  end
end
