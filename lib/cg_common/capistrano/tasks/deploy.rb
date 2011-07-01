Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :web do

      desc "Present a maintenance page to visitors."
      task :disable, :roles => :web do
        require 'erubis'

        on_rollback { rm "#{shared_path}/system/maintenance.html" }

        deadline, reason = ENV['UNTIL'], ENV['REASON']
        maintenance_file = File.read './app/views/layouts/maintenance.erb'
        maintenance = Erubis::Eruby.new(maintenance_file).result(binding)

        put maintenance, "#{shared_path}/system/maintenance.html", :mode => 0644
      end

    end
  end
end
