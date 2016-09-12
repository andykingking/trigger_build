require 'trigger_build/options'

module TriggerBuild

  def self.travis(args: ARGV)
    opts = Options.parse(args)
  end

end
