Capistrano::Configuration.instance.load do
  before 'deploy:restart' , 'monit:update'

  namespace :monit do

    def with_monit
      run 'whereis monit' do |ch, stream, data|
        if data.match(/^monit: (.*)$/)
          yield
        else
          puts "WARNING: The `monit` binary wasn't found on the target system."
        end
      end
    end

    desc 'Update monit configuration files'
    task :update, :roles => :web do
      with_monit do
        require 'erubis'

        templates = File.join(Dir.pwd, 'config', 'deploy', 'monit', '*.erb')

        path = "#{current_path}/monit"

        run "mkdir -p #{path}"

        run <<-CMD
          sudo ruby -e '
            `echo "include #{path}/*.monitrc" >> /etc/monit/monitrc`
              if `grep "#{path}" /etc/monit/monitrc`.empty?'
        CMD

        Dir[templates].each do |filename|
          file = File.read filename
          buffer = Erubis::Eruby.new(file).result(binding)
          put buffer, "#{current_path}/monit/#{File.basename(filename, '.erb')}.monitrc"
        end

        run 'sudo monit reload'
      end
    end

    desc 'Start DAEMON'
    task :start do
      daemon = ENV['DAEMON']
      if daemon
        with_monit do
          puts "Starting #{daemon} using monit"
          sudo "monit start #{daemon}"
        end
      else
        puts 'You must specify a DAEMON!'
      end
    end

    desc 'Stop DAEMON'
    task :stop do
      daemon = ENV['DAEMON']
      if daemon
        with_monit do
          puts "Stopping #{daemon} using monit"
          sudo "monit stop #{daemon}"
        end
      else
        puts 'You must specify a DAEMON!'
      end
    end

    desc "Restart DAEMON"
    task :restart do
      daemon = ENV['DAEMON']
      if daemon
        with_monit do
          puts "Restarting #{daemon} using monit"
          sudo "monit stop #{daemon}"
          sudo "monit start #{daemon}"
        end
      else
        puts 'You must specify a DAEMON!'
      end
    end

  end
end
