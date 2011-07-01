# cg_common - Gem used by Code Genome's projects

## Capistrano

This gem contains a bunch of common Capistrano tasks, see `cap -T`.

### Capistrano Variables

 * `:version` - used by version_footer
 * `:use_monit_for_delayed_job`
 * `:use_monit_for_sphinx`

## Helpers

### `env_tag(options = {})`

Creates a tag that is generated only in non-production environments. It
has an `id` set to "rails-env" and a class set to the currently running
environment.

 * options:
   * `staging_msg`: string appended on another line in the tag when in
     staging environment.

### `link_to_cg_feedback(name, html_options = {})`

Creates a link to cg-project feedback page. It will use the current_user
local variable internally, so it must be there and the email must match
the corresponding cg-project user.

This helper use a configuration file that should be located in
`#{Rails.root}/config/cg_project.yml`. It must contains the following keys:

    cg_project:
      site_url: https://cg-project.codegenome.com
      project_id: <project_id>
      access_token: <access_token>

## Development Mail Interceptor

Set shell ENV variable on your development machine, like this:

    export DEV_EMAIL="you@example.com"
