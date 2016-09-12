require 'spec_helper'

usage = %Q(usage: trigger_build [options] owner repo

options:
    --pro          use travis-ci.com
    -t, --token    the TravisCI API token (default: TRAVIS_API_TOKEN)
    -h, --help     display this message
    -v, --version  print the version
)

shared_examples 'a valid command line option' do |args, message|
  it 'prints message and exits' do
    expect {
      begin TriggerBuild::Options.parse(args)
      rescue SystemExit => error
        expect(error).to be_a(SystemExit)
        expect(error.status).to eq(0)
      end
    }.to output(message).to_stdout
  end
end

shared_examples 'invalid arguments' do |args|
  it 'prints usage and exits with error' do
    expect {
      begin TriggerBuild::Options.parse(args)
      rescue SystemExit => error
        expect(error).to be_a(SystemExit)
        expect(error.status).to eq(1)
      end
    }.to output(usage).to_stderr
  end
end

describe TriggerBuild::Options do
  context 'when -h option used' do
    it_behaves_like 'a valid command line option', %w(-h), usage
  end

  context 'when --help option used' do
    it_behaves_like 'a valid command line option', %w(--help), usage
  end

  context 'when -v option used' do
    it_behaves_like 'a valid command line option', %w(-v), "#{TriggerBuild::VERSION}\n"
  end

  context 'when --version option used' do
    it_behaves_like 'a valid command line option', %w(--version), "#{TriggerBuild::VERSION}\n"
  end

  context 'when not enough parameters are specified' do
    it_behaves_like 'invalid arguments', %w(the_owner)
  end

  context 'when too many parameters are specified' do
    it_behaves_like 'invalid arguments', %w(the_owner a_repo some_stuff)
  end

  context 'when the correct number of parameters are given' do

    args = %w{the_owner a_repo}
    subject { TriggerBuild::Options.parse(args) }

    context 'and no token is specified' do

      before(:each) do
        args = %w{the_owner a_repo}
        ENV['TRAVIS_API_TOKEN'] = 'my_token'
      end

      it 'uses the TRAVIS_API_TOKEN environment variable' do
        expect(subject).to include({ token: 'my_token' })
      end
    end

    context 'and a token is specified' do

      before(:each) do
        args = %w{the_owner a_repo --token 12345}
        ENV['TRAVIS_API_TOKEN'] = 'should_not_use_this_token'
      end

      it 'prefers the given token over the environment variable' do
        expect(subject).to include({ token: '12345' })
      end
    end
  end
end
