# Global Capistrano Recipes for Code Genome Projects

Capistrano::Configuration.instance.load do

  namespace :db do

    desc "Load production data into development database"
    task :pull, :roles => :db, :only => { :primary => true } do
      require 'yaml'

      file = 'config/database.yml'
      databases = YAML::load_file(file)
      filename = "dump.#{Time.now.strftime '%Y-%m-%d_%H-%M-%S'}.sql.gz"

      dump_command = "mysqldump" +
        " -u #{databases[stage.to_s]['username']}" +
        " --password=#{databases[stage.to_s]['password']}" +
        " #{databases[stage.to_s]['database']} | gzip > /tmp/#{filename}"

      # surpress debug log output to hide the password
      current_logger_level = self.logger.level
      if current_logger_level >= Capistrano::Logger::DEBUG
        logger.debug %(executing "#{dump_command.sub(/-p\S+/, '-px')}")
        self.logger.level = Capistrano::Logger::INFO
      end

      run dump_command do |channel, stream, data|
        puts data
      end

      self.logger.level = current_logger_level

      get "/tmp/#{filename}", filename

      password = if databases['development']['password']
                   "--password=#{databases['development']['password']}"
                 end

      mysql_command = "mysql" +
        " -u #{databases['development']['username']} #{password}" +
        " #{databases['development']['database']}"

      puts "Loading data..."
      `gunzip -c #{filename} | #{mysql_command}`

      puts "Cleaning up..."
      `rm #{filename}`
    end

  end

end
