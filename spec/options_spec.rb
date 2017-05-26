require 'spec_helper'

usage = %(usage: trigger_build [options] owner repo

options:
    --pro          use travis-ci.com
    -t, --token    the Travis CI API token (default: TRAVIS_API_TOKEN)
    -h, --help     display this message
    -v, --version  print the version
)

shared_examples 'a valid command line option' do |args, message|
  it 'prints message and exits' do
    expect do
      begin TriggerBuild::Options.parse(args)
      rescue SystemExit => error
        expect(error).to be_a(SystemExit)
        expect(error.status).to eq(0)
      end
    end.to output(message).to_stdout
  end
end

shared_examples 'invalid arguments' do |args|
  it 'prints usage and exits with error' do
    expect do
      begin TriggerBuild::Options.parse(args)
      rescue SystemExit => error
        expect(error).to be_a(SystemExit)
        expect(error.status).to eq(1)
      end
    end.to output(usage).to_stderr
  end
end

describe TriggerBuild::Options do
  describe '#parse' do
    let(:args) { %w[] }

    subject { TriggerBuild::Options.parse(args) }

    context 'when -h option is used' do
      it_behaves_like 'a valid command line option', %w[-h], usage
    end

    context 'when --help option is used' do
      it_behaves_like 'a valid command line option', %w[--help], usage
    end

    context 'when -v option is used' do
      it_behaves_like 'a valid command line option', %w[-v], "#{TriggerBuild::VERSION}\n"
    end

    context 'when --version option is used' do
      it_behaves_like 'a valid command line option', %w[--version], "#{TriggerBuild::VERSION}\n"
    end

    context 'when no parameters are specified' do
      it_behaves_like 'invalid arguments', %w[]
    end

    context 'when not enough parameters are specified' do
      it_behaves_like 'invalid arguments', %w[the_owner]
    end

    context 'when too many parameters are specified' do
      it_behaves_like 'invalid arguments', %w[the_owner a_repo some_stuff]
    end

    context 'when the correct number of parameters are given' do
      context 'and supplied no options' do
        let(:args) { %w[owner repo] }

        it 'uses the given parameters and default options' do
          expect(subject).to eq(owner: 'owner', repo: 'repo', token: nil, pro: false)
        end
      end

      context 'and supplied all options' do
        let(:args) { %w[--token 54321 --pro me repo] }

        it 'uses the given parameters and all supplied options' do
          expect(subject).to eq(owner: 'me', repo: 'repo', token: '54321', pro: true)
        end
      end

      context 'and no token is specified' do
        let(:args) { %w[the_owner a_repo] }

        before do
          ENV['TRAVIS_API_TOKEN'] = 'my_token'
        end

        it 'uses the TRAVIS_API_TOKEN environment variable' do
          expect(subject).to include(token: 'my_token')
        end
      end

      context 'and a token is specified' do
        let(:args) { %w[the_owner a_repo --token 12345] }

        before do
          ENV['TRAVIS_API_TOKEN'] = 'should_not_use_this_token'
        end

        it 'prefers the given token over the environment variable' do
          expect(subject).to include(token: '12345')
        end
      end

      context 'and the --pro flag is specified' do
        let(:args) { %w[the_owner a_repo --pro] }

        it 'sets the pro option' do
          expect(subject).to include(pro: true)
        end
      end

      context 'and the --pro flag is not specified' do
        let(:args) { %w[the_owner a_repo] }

        it 'does not set the pro option' do
          expect(subject).to include(pro: false)
        end
      end
    end
  end
end
