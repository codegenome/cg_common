require 'cg_common/cg_project_config'

module CgCommon
  module Helpers

    def env_tag(options = {})
      unless Rails.env.production?
        content_tag :span, :id => :"rails-env", :class => Rails.env do
          (Rails.env.to_s +
            if options[:staging_msg] && Rails.env.staging?
              "<br />#{options[:staging_msg]}"
            end.to_s).html_safe
        end.html_safe
      end
    end

    def link_to_cg_feedback(name, html_options = {}, optional_params = {})
      from = (url_for(params.merge(:only_path => false)) rescue params.to_yaml)

      feedback_params = {
        :reporter_email => (current_user.email rescue nil),
        :reporter_name  => (logged_in? ? current_user.to_s : "anonymous user" rescue nil),
        :reported_from  => from
      }.delete_if { |k, v| v.nil? }
      feedback_params.merge!(optional_params)

      link_to name, _cg_feedback_url(feedback_params), html_options
    end

    # prefixed with underscore to make sure it won't ever clash with a route helper
    def _cg_feedback_url(feedback_params)
      site_url = feedback_params.delete :site_url
      project_id = feedback_params.delete :project_id
      access_token = feedback_params.delete :access_token

      config = CgCommon::CgProjectConfig.new(Rails.root)
      feedback_params.merge! :access_token => (access_token || config.access_token)

      (site_url || config.site_url) +
        '/extranet/projects/' +
        (project_id || config.project_id.to_s) +
        '/stories?' +
        feedback_params.to_param
    end

  end
end
