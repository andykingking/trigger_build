require 'spec_helper'

describe TriggerBuild::Repo do
  let(:git) { instance_double('Git::Base') }

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
      let(:dir) { 'path/to/the/repo' }

      subject { TriggerBuild::Repo.new(dir) }

      it 'uses the given directory' do
        expect(Git).to receive(:open).with(dir)

        subject
      end
    end
  end

  describe '#name' do
    let(:dir) { instance_double('Git::WorkingDirectory') }

    before do
      allow(git).to receive(:dir).and_return(dir)
      allow(dir).to receive(:path).and_return('path/to/my/repo')
    end

    it 'uses the current directory as the repo name' do
      expect(subject.name).to eq('repo')
    end
  end

  describe '#last_commit_message' do
    let(:commit) { instance_double('Git::Object::Commit') }

    before do
      allow(git).to receive(:log).and_return(%w(995204d 64e3218 1b67d9a))
      allow(git).to receive(:gcommit).with('995204d').and_return(commit)
      allow(commit).to receive(:message).and_return('This is the last commit message')
    end

    it 'returns the last commit message' do
      expect(subject.last_commit_message).to eq('This is the last commit message')
    end
  end
end
