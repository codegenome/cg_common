Capistrano::Configuration.instance.load do
  namespace :db do

    desc "Load remote server data (ex: production or staging) into development database"
    task :pull, :roles => :db, :only => { :primary => true } do
      require 'yaml'

      sync_path = "#{shared_path}/sync"
      file = 'config/database.yml'
      databases = YAML::load_file(file)

      Capistrano::CLI.ui.say("Let's start the remote mysqldump...")
      # Let's make sure we have a remote folder to hold our database dump files + history
      run "#{try_sudo} mkdir -p #{sync_path} && chmod g+w #{sync_path}"
      filename = "dump.#{application}.#{stage}.#{Time.now.strftime '%Y-%m-%d_%H-%M-%S'}.sql.gz"
      on_rollback { delete "#{sync_path}/#{filename}" }

      dump_command = "mysqldump" +
        " -u #{databases[stage.to_s]['username']}" +
        " --password=#{databases[stage.to_s]['password']}" +
        " #{databases[stage.to_s]['database']} | gzip > #{sync_path}/#{filename}"

      # surpress debug log output to hide the password
      current_logger_level = self.logger.level
      if current_logger_level >= Capistrano::Logger::DEBUG
        logger.debug %(executing "#{dump_command.sub(/-p\S+/, '-px')}")
        self.logger.level = Capistrano::Logger::INFO
      end

      run dump_command do |channel, stream, data|
        puts data
      end

      Capistrano::CLI.ui.say("A little bit of db dump history cleanup on the remote server...")
      purge_old_backups sync_path

      self.logger.level = current_logger_level

      Capistrano::CLI.ui.say("Downloading the sql gzipped dump to the local server...")
      download "#{sync_path}/#{filename}", filename

      set(:target_db, 'development') unless exists?(:target_db)

      password = if databases[target_db]['password']
                   "--password=#{databases[target_db]['password']}"
                 end

      mysql_command = "mysql" +
        " -u #{databases[target_db]['username']} #{password}" +
        " #{databases[target_db]['database']}"

      Capistrano::CLI.ui.say("Importing the sql gzipped dump the local database...")
      puts "Loading data into #{databases[target_db]['database']}..."
      `gunzip -c #{filename} | #{mysql_command}`

      puts "Cleaning up..."
      `rm #{filename}`

      Capistrano::CLI.ui.say("sync #{application} DB from remote server to local is finished")

    end

    #
    # Purge old backups within the shared sync directory
    #
    def purge_old_backups(remote_path)
      count = fetch(:sync_backups, 5).to_i
      backup_files = capture("ls -xt #{remote_path}/*").split.reverse
      if count >= backup_files.length
        logger.important "no old backups to clean up"
      else
        logger.info "keeping #{count} of #{backup_files.length} sync backups"
        delete_backups = (backup_files - backup_files.last(count)).join(" ")
        try_sudo "rm -rf #{delete_backups}"
      end
    end

  end
end
