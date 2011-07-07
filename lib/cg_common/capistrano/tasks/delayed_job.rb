
Capistrano::Configuration.instance(true).load do
  namespace :delayed_job do

    desc "Start delayed_job daemon"
    task :start do
      puts "Starting delayed job using #{use_monit_for_delayed_job ? 'monit' : 'script/worker'}"

      if use_monit_for_delayed_job
        sudo "monit start #{application}_delayed_job"
      else
        run "cd #{current_path}; script/delayed_job start #{rails_env}"
      end
    end

    desc "Stop delayed_job daemon"
    task :stop do
      puts "Stopping delayed job using #{use_monit_for_delayed_job ? 'monit' : 'script/worker'}"

      if use_monit_for_delayed_job
        sudo "monit stop #{application}_delayed_job"
      else
        run "cd #{current_path}; script/delayed_job stop #{rails_env}"
      end
    end

    desc "Restart delayed_job daemon"
    task :restart do
      puts "Restarting delayed job using #{use_monit_for_delayed_job ? 'monit' : 'script/worker'}"

      if use_monit_for_delayed_job
        sudo "monit restart #{application}_delayed_job"
      else
        run "cd #{current_path}; script/delayed_job restart #{rails_env}"
      end
    end

  end
end
