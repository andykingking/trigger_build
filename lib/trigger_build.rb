require 'trigger_build/options'
require 'trigger_build/repo'
require 'trigger_build/travis'

module TriggerBuild

  def self.travis(args = ARGV)
    opts = Options.parse(args)
    repo = Repo.new
    travis = Travis.new(opts)
    travis.trigger("Triggered by #{repo.name}: #{repo.last_commit_message}", branch: 'master')
  end

end
