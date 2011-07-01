Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :web do

      desc "Present a maintenance page to visitors."
      task :disable, :roles => :web do
        on_rollback { rm "#{shared_path}/system/maintenance.html" }

        require 'erb'
        deadline, reason = ENV['UNTIL'], ENV['REASON']
        maintenance = ERB.new(File.read("./app/views/layouts/maintenance.erb")).result(binding)

        put maintenance, "#{shared_path}/system/maintenance.html", :mode => 0644
      end

    end
  end
end
