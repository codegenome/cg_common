module CgCommon
  class DevelopmentMailInterceptor
    def self.delivering_email(message)
      # DO NOT OVERRIDE
      # Set shell ENV variable, like this:
      # export DEV_EMAIL="you@your_email.com"
      message.to = ENV['DEV_EMAIL'] ? ENV['DEV_EMAIL'] : "support@codegenome.com"
    end
  end
end
