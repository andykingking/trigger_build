require 'trigger_build/options'
require 'trigger_build/travis'

module TriggerBuild

  def self.travis(args: ARGV)
    opts = Options.parse(args)
    travis = Travis.new(opts)
    travis.trigger('Testing dependency update triggers build', branch: 'master')
  end

end
