require 'trigger_build/options'
require 'trigger_build/repo'
require 'trigger_build/travis_api'

module TriggerBuild

  def self.parse_args(args)
    Options.parse(args)
  end

  def self.travis(opts)
    repo = Repo.new
    triggerer = repo.valid? ? "#{repo.name}: #{repo.last_commit_message}" : 'trigger_build'
    TravisAPI.new(opts).trigger("Triggered by #{triggerer}")
  end

end
