# cg_common - Gem used by Code Genome's projects

## Capistrano

This gem contains a bunch of common Capistrano tasks, see `cap -T`.

### Capistrano Variables

 * `:version` - used by version_footer
 * `:use_monit_for_delayed_job`
 * `:use_monit_for_sphinx`

### Using monit for delayed_job and sphinx

When these variable are not `nil`, the tasks in the corresponding
namespaces will use Monit to start, stop or restart these services. By
convention cg_common will use the `#{application}_#{namespace}` name for
that Monit service.

## Helpers

### `env_tag(options = {})`

Creates a tag that is generated only in non-production environments. It
has an `id` set to "rails-env" and a class set to the currently running
environment.

 * options:
   * `:staging_msg`: string appended on another line in the tag when in
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

### `_cg_feedback_url(feedback_params)`

*Mostly for internal use*

Used by `link_to_cg_feedback` and inside cg-project to provide links
inside e-mails. It takes an Hash that must contains the following keys:

 * `:reporter_email`
 * `:reporter_name`
 * `:reported_from`

It can also take optional keys to override the ones found in the
configuration file:

 * `:site_url`
 * `:project_id`
 * `:access_token`

## Development Mail Interceptor

Set shell ENV variable on your development machine, like this:

    export DEV_EMAIL="you@example.com"

## Managing releases

To release a new version of cg_common, we're using the same technique as
describe in the following blog post: [JewelerBundlerGithub].

It works in four steps:

    $ rake version:bump:<major|minor|patch>
    $ rake gemspec
    $ git commit -am "Updated gemspec file."
    $ rake git:release

It's always better to have a look at the generate gemspec file before
commiting it.

[JewelerBundlerGithub]: http://www.cerebris.com/blog/2011/03/15/creating-and-managing-private-rubygems-with-jeweler-github-and-bundler/

## Examples

Check `examples/README.md`


## Credits

![codegenome](http://codegenome.com/assets/180x68-CG-logo.jpg)

cg_common is maintained and funded by [code genome, inc](http://codegenome.com)


## License

cg_common is Copyright © 2011 Code Genome Inc. License terms specified in the LICENSE file.

