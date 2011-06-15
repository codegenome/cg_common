
module CgCommon
  class CgProjectConfig

    attr_accessor :filename

    def initialize(rails_root)
      self.filename = "#{Rails.root}/config/cg_project.yml"

      unless defined? @@config
        file = File.open(self.filename)
        @@config = YAML.load(file)['cg_project'] ||
          error('You must define the cg_project key!')
      end
    end

    def method_missing(m, *args, &block)
      @@config[m.to_s] || error("The #{m} key is missing!")
    end

    def error(msg)
      raise "There's an error in #{self.filename}: #{msg}"
    end

  end
end
