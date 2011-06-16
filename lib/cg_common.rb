require "cg_common/version"

module CgCommon
  class << self
    def enable_actionview
      return if ActionView::Base.instance_methods.include_method? :link_to_cg_feedback
      require "cg_common/feedbacks_helper"
      ActionView::Base.send :include, CgCommon::FeedbacksHelper
    end
  end
end

if defined? Rails
  CgCommon.enable_actionview if defined? ActionView
end
