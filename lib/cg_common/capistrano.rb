# Global Capistrano Recipes for Code Genome Projects

Capistrano::Configuration.instance.load do

  before "deploy:symlink", "cg:version_footer"

  namespace :cg do

    desc "Creates layouts/footer/_version partial view."
    task :version_footer do
      revision_url = "https://github.com/codegenome/#{application}/commit/#{real_revision}"
      html = address +
        " - version #{version}.#{stage}" +
        " - #{Time.now.strftime("%d/%m/%y %I:%M%p %Z")}" +
        " - rev. <a href='#{revision_url}' target='_blank'>#{real_revision[0..6] + "..."}</a>"
      run "echo \"#{html}\"  > #{release_path}/app/views/layouts/footer/_version.html.erb"
    end

  end

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
