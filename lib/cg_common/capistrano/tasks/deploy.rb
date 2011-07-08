Capistrano::Configuration.instance.load do
  before "deploy" do
    deploy.web.disable
  end

  after "deploy" do
    deploy.web.enable
  end

  namespace :deploy do
    namespace :web do

      desc "Present a maintenance page to visitors."
      task :disable, :roles => :web do
        require 'erubis'

        on_rollback { rm "#{shared_path}/system/maintenance.html" }

        deadline, reason = ENV['UNTIL'], ENV['REASON']
        file_path = './app/views/layouts/maintenance.erb'
        unless File.exists? file_path
          file_path = CgCommon.gem_path 'lib', 'cg_common', 'capistrano', 'templates', 'maintenance.erb'
        end
        maintenance_file = File.read file_path
        maintenance = Erubis::Eruby.new(maintenance_file).result(binding)

        put maintenance, "#{shared_path}/system/maintenance.html", :mode => 0644
      end

    end
  end
end
