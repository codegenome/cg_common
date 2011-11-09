Capistrano::Configuration.instance.load do
  namespace :init do
    namespace :upstart do

      def update_upstart_conf(app)
        sudo "#{try_sudo} cp " +
          "#{current_path}/config/server/#{app}/#{app}-upstart.conf " +
          "/etc/init/#{app}.conf"
      end

      desc 'Update DAEMON upstart config file'
      task :update, :roles => :app do
        daemon = ENV['DAEMON']
        if daemon
          update_upstart_conf daemon
        else
          puts 'You must specify a DAEMON!'
        end
      end

    end
  end
end
