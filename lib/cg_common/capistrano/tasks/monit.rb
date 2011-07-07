
Capistrano::Configuration.instance.load do

  def with_monit
    run 'whereis monit' do |ch, stream, data|
      if data.match(/^monit: (.*)$/)
        yield
      else
        puts "WARNING: The `monit` binary wasn't found on the target system."
      end
    end
  end

  before "deploy:restart" , "monit:create_conf"

  namespace :monit do

    desc "Create monit configuration files"
    task :create_conf, :roles => :web do
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

  end
end
