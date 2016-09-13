require 'spec_helper'

describe TriggerBuild do
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
      subject { TriggerBuild.travis(%w(some_guy cool-project --pro --token qwerty)) }

      it 'triggers a build for the defined TravisCI repository' do
        expect(TriggerBuild::Travis).to receive(:new).with({
          url: 'travis-ci.com', owner: 'some_guy', repo: 'cool-project', token: 'qwerty'
        })
        expect(travis).to receive(:trigger).with(
          'Triggered by triggerer: Added stuff', branch: 'master'
        )

        subject
      end
    end
  end
end
