# TriggerBuild

TriggerBuild is a simple command line application that can be used to trigger builds on Travis CI.

Installation is as simple as:

    $ gem install trigger_build

##Status

[![Build Status](https://travis-ci.org/MYOB-Technology/trigger_build.png)](https://travis-ci.org/MYOB-Technology/trigger_build)
[![Gem Version](https://badge.fury.io/rb/trigger_build.png)](http://badge.fury.io/rb/trigger_build)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/trigger_build/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/trigger_build)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/trigger_build.png)](https://gemnasium.com/MYOB-Technology/trigger_build)

## Usage

Triggering builds on Travis CI requires a Travis API token, which is specified via the `--token` option.  The `TRAVIS_API_TOKEN` environment variable will be used if no option is supplied.
Note that the user having this token must have at least write permission on the repository whose build will be triggered.

By default public projects hosted on [travis-ci.org](https://travis-ci.org) will be triggered. The `--pro` option must be used if the project is private and hosted on [travis-ci.com](https://travis-ci.com).

The following example triggers a build of trigger_build hosted on [travis-ci.org](https://travis-ci.org/MYOB-Technology/trigger_build):

    $ trigger_build MYOB-Technology trigger_build --token $API_TOKEN

For detailed usage and options:

    $ trigger_build -h

The Travis CI web user interface displays a message for the currently running build. By default this message will include the name of the Git repository from where the `trigger_build` command is executed and the most recent commit message. A generic message will be used if `trigger_build` is not run from a directory containing a Git repository.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MYOB-Technology/trigger_build.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
