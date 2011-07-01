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
end
