require 'slop'
require 'trigger_build/version'

module TriggerBuild

  class Options

    def self.parse(args)
      opts = Slop.parse args do |o|
        o.banner = "usage: trigger_build [options] owner repo"
        o.separator ""
        o.separator "options:"
        o.bool '--pro', 'use travis-ci.com'
        o.string '-t', '--token',
          'the TravisCI API token (default: TRAVIS_API_TOKEN)', default: ENV['TRAVIS_API_TOKEN']
        o.on '-h', '--help', 'display this message' do
          puts o
          exit
        end
        o.on '-v', '--version', 'print the version' do
          puts TriggerBuild::VERSION
          exit
        end
      end

      unless opts.arguments.length == 2
        abort opts.to_s
      end

      url = opts.pro? ? 'travis-ci.com' : 'travis-ci.org'
      owner, repo = *opts.args

      { owner: owner, repo: repo, token: opts[:token], url: url }
    end

  end

end
