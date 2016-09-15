require 'slop'
require 'trigger_build/version'

module TriggerBuild
  class Options
    def self.parse(args)
      opts = build_opts(args)

      abort opts.to_s unless opts.arguments.length == 2

      owner, repo = *opts.args
      { owner: owner, repo: repo, token: opts[:token], pro: opts.pro? }
    end

    def self.build_opts(args)
      Slop.parse(args) do |o|
        o.banner = 'usage: trigger_build [options] owner repo'
        o.separator ''
        o.separator 'options:'
        o.bool '--pro', 'use travis-ci.com'
        o.string '-t', '--token', 'the Travis CI API token (default: TRAVIS_API_TOKEN)',
                 default: ENV['TRAVIS_API_TOKEN']
        o.on '-h', '--help', 'display this message' do
          puts o
          exit
        end
        o.on '-v', '--version', 'print the version' do
          puts TriggerBuild::VERSION
          exit
        end
      end
    end
  end
end
