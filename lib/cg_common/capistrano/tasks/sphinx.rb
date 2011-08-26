
Capistrano::Configuration.instance(true).load do
  namespace :sphinx do

    desc "Start sphinx daemon"
    task :start do
      puts "Starting delayed job using #{use_monit_for_sphinx ? 'monit' : 'rake thinking_sphinx'}"

      if use_monit_for_sphinx
        sudo "monit start #{application}_sphinx"
      else
        begin
          run "cd #{release_path}; bundle exec rake thinking_sphinx:start RAILS_ENV=#{rails_env}"
        rescue
          puts "Sphinx is running. No stop required."
        end
      end
    end

    desc "Stop sphinx daemon"
    task :stop do
      puts "Stopping delayed job using #{use_monit_for_sphinx ? 'monit' : 'rake thinking_sphinx'}"

      if use_monit_for_sphinx
        sudo "monit stop #{application}_sphinx"
      else
        begin
          run "cd #{current_path}; bundle exec rake thinking_sphinx:stop RAILS_ENV=#{rails_env}"
        rescue
          puts "Sphinx is not running. No stop required."
        end
      end
    end

    desc "Restart sphinx daemon"
    task :restart do
      puts "Restarting delayed job using #{use_monit_for_sphinx ? 'monit' : 'rake thinking_sphinx'}"

      if use_monit_for_sphinx
        sudo "monit restart #{application}_sphinx"
      else
        run "cd #{release_path}; bundle exec rake thinking_sphinx:restart RAILS_ENV=#{rails_env}"
      end
    end

    desc "Properly reload and start Sphinx."
    task :activate, :roles => [:app] do
      sphinx.symlink_indexes
      sphinx.configure
      # Not sure we have to index at every deploy, crontab should be enough...
      # sphinx.index
      sphinx.start
    end

    desc "Configure, Index and then run Thinking Sphinx"
    task :index do
      run "cd #{release_path}; bundle exec rake thinking_sphinx:index RAILS_ENV=#{rails_env}"
    end

    desc "Configure Thinking Sphinx"
    task :configure do
      run "cd #{release_path}; bundle exec rake thinking_sphinx:configure RAILS_ENV=#{rails_env}"
    end

    desc "Configure, Index and then run Thinking Sphinx"
    task :rebuild do
      run "cd #{release_path}; bundle exec rake thinking_sphinx:rebuild RAILS_ENV=#{rails_env}"
    end

    desc "Link up Sphinx's indexes."
    task :symlink_indexes, :roles => [:app] do
      run "ln -nfs #{shared_path}/db/sphinx #{current_path}/db/sphinx"
    end

  end
end
