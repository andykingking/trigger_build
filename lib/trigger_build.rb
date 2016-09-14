require 'trigger_build/options'
require 'trigger_build/repo'
require 'trigger_build/travis'

module TriggerBuild

  def self.parse_args(args)
    Options.parse(args)
  end

  def self.travis(opts)
    repo = Repo.new
    travis = Travis.new(opts)
    travis.trigger("Triggered by #{repo.name}: #{repo.last_commit_message}", branch: 'master')
  end

end
