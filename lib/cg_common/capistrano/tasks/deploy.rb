Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :web do

      desc "Present a maintenance page to visitors."
      task :disable, :roles => :web do
        require 'erubis'

        on_rollback { rm "#{shared_path}/system/maintenance.html" }

        deadline, reason = ENV['UNTIL'], ENV['REASON']
        # TODO: [Ticket #05306] test for existence of the maintenance template in the project
        # else, use the one in the gem: ../templates/maintenance.html.erb
        maintenance_file = File.read './app/views/layouts/maintenance.erb'
        maintenance = Erubis::Eruby.new(maintenance_file).result(binding)

        put maintenance, "#{shared_path}/system/maintenance.html", :mode => 0644
      end

    end
  end
end
