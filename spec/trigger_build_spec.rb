require 'spec_helper'

describe TriggerBuild do
  describe '#parse_args' do
    subject { TriggerBuild.parse_args(%w(some_guy cool-project --pro --token secret_token)) }

    it 'correctly parses the options' do
      expect(subject).to eq({
        owner: 'some_guy', repo: 'cool-project', token: 'secret_token', pro: true
      })
    end
  end

  describe '#trigger' do
    let(:travis) { instance_double(TriggerBuild::Travis) }
    let(:repo) {
      instance_double(TriggerBuild::Repo, name: 'triggerer', last_commit_message: 'Added stuff')
    }

    before do
      allow(TriggerBuild::Travis).to receive(:new).and_return(travis)
      allow(TriggerBuild::Repo).to receive(:new).and_return(repo)
    end

    context 'with valid parameters and options' do
      let(:opts) { { owner: 'some_guy', repo: 'cool-project', token: 'qwerty', pro: false } }

      subject { TriggerBuild.travis(opts) }

      it 'triggers a build for the defined TravisCI repository' do
        expect(TriggerBuild::Travis).to receive(:new).with({
          owner: 'some_guy', repo: 'cool-project', token: 'qwerty', pro: false
        })
        expect(travis).to receive(:trigger).with(
          'Triggered by triggerer: Added stuff', branch: 'master'
        )

        subject
      end
    end
  end
end
