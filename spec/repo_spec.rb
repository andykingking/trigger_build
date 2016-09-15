require 'spec_helper'

describe TriggerBuild::Repo do
  let(:git) { instance_double(Git::Base) }

  subject { TriggerBuild::Repo.new }

  before(:each) do
    allow(Git).to receive(:open).and_return(git)
  end

  describe '#initialize' do
    context 'when no directory is provided' do
      it 'uses the current directory' do
        expect(Git).to receive(:open).with(Dir.pwd)

        subject
      end
    end

    context 'when a directory is provided' do
      subject { TriggerBuild::Repo.new('path/to/the/repo') }

      it 'uses the given directory' do
        expect(Git).to receive(:open).with('path/to/the/repo')

        subject
      end
    end
  end

  describe '#name' do
    let(:git) { instance_double(Git::Base, dir: dir) }
    let(:dir) { instance_double(Git::WorkingDirectory, path: 'path/to/my/repo') }

    it 'uses the current directory as the repo name' do
      expect(subject.name).to eq('repo')
    end
  end

  describe '#last_commit_message' do
    let(:git) { instance_double(Git::Base, log: %w(995204d 64e3218 1b67d9a)) }
    let(:commit) { instance_double(Git::Object::Commit, message: 'Last commit message') }

    before do
      allow(git).to receive(:gcommit).with('995204d').and_return(commit)
    end

    it 'returns the last commit message' do
      expect(subject.last_commit_message).to eq('Last commit message')
    end
  end
end
