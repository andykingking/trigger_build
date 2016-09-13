# TriggerBuild

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trigger_build'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trigger_build

## Usage

TriggerBuild is a simple command line application that can be used to trigger builds on Travis CI.

The following example triggers a build of trigger_build:

    $ trigger_build MYOB-Technology trigger_build --token $TRAVIS_API_TOKEN

For detailed usage:

    $ trigger_build -h

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MYOB-Technology/trigger_build.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

