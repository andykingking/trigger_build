require 'spec_helper'

describe TriggerBuild do
  describe '#parse_args' do
    subject { TriggerBuild.parse_args(%w[some_guy cool-project --pro --token secret_token]) }

    it 'correctly parses the options' do
      expect(subject).to eq(
        owner: 'some_guy', repo: 'cool-project', token: 'secret_token', pro: true
      )
    end
  end

  describe '#trigger' do
    let(:opts) { { owner: 'some_guy', repo: 'cool-project', token: 'qwerty', pro: false } }
    let(:travis) { instance_double(TriggerBuild::TravisAPI) }
    let(:repo) { instance_double(TriggerBuild::Repo, valid?: false) }

    subject { TriggerBuild.travis(opts) }

    before do
      allow(TriggerBuild::TravisAPI).to receive(:new).and_return(travis)
      allow(TriggerBuild::Repo).to receive(:new).and_return(repo)
    end

    context 'with valid parameters and options' do
      it 'triggers a build for the defined TravisCI repository' do
        expect(TriggerBuild::TravisAPI).to receive(:new).with(
          owner: 'some_guy', repo: 'cool-project', token: 'qwerty', pro: false
        )
        expect(travis).to receive(:trigger)

        subject
      end
    end

    context 'from a directory which contains a git repository' do
      let(:repo) do
        instance_double(
          TriggerBuild::Repo, name: 'triggerer', last_commit_message: 'Added stuff', valid?: true
        )
      end

      it 'triggers a build using the repository name and last commit as the message' do
        expect(travis).to receive(:trigger).with('Triggered by triggerer: Added stuff')

        subject
      end
    end

    context 'from a directory which does not contain a git repository' do
      let(:repo) { instance_double(TriggerBuild::Repo, valid?: false) }

      it 'triggers a build using a generic message' do
        expect(travis).to receive(:trigger).with('Triggered by trigger_build')

        subject
      end
    end
  end
end
