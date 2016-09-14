# TriggerBuild

TriggerBuild is a simple command line application that can be used to trigger builds on Travis CI.

Installation is as simple as:

    $ gem install trigger_build

## Usage

Triggering builds on Travis CI requires a Travis API token, which is specified via the `--token` option. The `TRAVIS_API_TOKEN` environment variable will be used if no option is supplied.

By default public projects hosted on [travis-ci.org](https://travis-ci.org) will be triggered. The `--pro` option should be used if the project is private and hosted on [travis-ci.com](https://travis-ci.com).

The following example triggers a build of trigger_build hosted on [travis-ci.org](https://travis-ci.org/MYOB-Technology/trigger_build):

    $ trigger_build MYOB-Technology trigger_build --token $API_TOKEN

For detailed usage and options:

    $ trigger_build -h

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MYOB-Technology/trigger_build.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
