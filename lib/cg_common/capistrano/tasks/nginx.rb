Capistrano::Configuration.instance.load do
  namespace :nginx do

    def update_and_restart(app_server)
      sudo "cp #{current_path}/config/server/#{app_server}/nginx.conf"
      sudo 'monit stop nginx'
      sudo 'monit start nginx'
    end

    desc 'Update passenger config file and restart nginx'
    task :passenger, roles: :app do
      update_and_restart :passenger
    end

    desc 'Update unicorn config file and restart nginx'
    task :unicorn, roles: :app do
      update_and_restart :unicorn
    end

  end
end
