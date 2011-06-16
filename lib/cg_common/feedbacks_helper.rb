require 'cg_common/cg_project_config'

module CgCommon
  module FeedbacksHelper

    def link_to_cg_feedback
      from = (url_for(params.merge(:only_path => false)) rescue params.to_yaml)

      feedback_params = {
        :reporter_email => (current_user.email rescue nil),
        :reporter_name  => (logged_in? ? current_user.to_s : "anonymous user"),
        :reported_from  => from
      }

      link_to "feedback", _cg_feedback_url(feedback_params), :popup => "400x300"
    end

    private

    def _cg_feedback_url(feedback_params)
      config = CgCommon::CgProjectConfig.new(Rails.root)
      feedback_params.merge! :project_token => config.project_token

      config.site_url +
        '/extranet/projects/' +
        config.project_id.to_s +
        '/stories?' +
        feedback_params.to_param
    end

  end
end
