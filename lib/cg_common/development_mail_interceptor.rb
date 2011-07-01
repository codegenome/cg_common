
module CgCommon
  class DevelopmentMailInterceptor
    def self.delivering_email(message)
      message.to = ENV['DEV_EMAIL'] ? ENV['DEV_EMAIL'] : "support@codegenome.com"
    end
  end
end
