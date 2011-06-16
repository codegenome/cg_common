require 'cg_common'

module CgCommon
  class Railtie < Rails::Railtie
    initializer "cg_common.action_view" do |app|
      require "cg_common/feedbacks_helper"
      ActionView::Base.send :include, CgCommon::FeedbacksHelper
    end
  end
end
