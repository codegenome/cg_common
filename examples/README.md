# Examples of configuration & setup files

## Helpers

* link\_to\_cg\_feedback: `cg_project.yml` to be dropped in `#{Rails.root}/config/cg_project.yml`
* env_tag: `rails-env.css` to be included in your application css

## Capistrano & Monit

Depending on your monitoring requirements, drop & tweak the `monit/...` files inside your application  `#{Rails.root}/config/deploy/monit/...`