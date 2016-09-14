require 'trigger_build/options'
require 'trigger_build/repo'
require 'trigger_build/travis'

module TriggerBuild

  def self.parse_args(args)
    Options.parse(args)
  end

  def self.travis(opts)
    repo = Repo.new
    TravisAPI.new(opts).trigger("Triggered by #{repo.name}: #{repo.last_commit_message}")
  end

end
