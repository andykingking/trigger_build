require 'spec_helper'

describe TriggerBuild::Travis do
  let(:opts) { {} }

  subject { TriggerBuild::Travis.new(opts) }

  describe '#initialize' do
    it 'sets the default Accept header' do
      expect(subject.class.headers).to include('Accept' => 'application/json')
    end

    it 'sets the default Content-Type' do
      expect(subject.class.headers).to include('Content-Type' => 'application/json')
    end

    it 'sets the default Travis-API-Version header' do
      expect(subject.class.headers).to include('Travis-API-Version' => '3')
    end

    context 'with options' do
      let(:pro) { false }
      let(:opts) { { owner: 'company', repo: 'super_repo', token: 'abc123', pro: pro } }

      it 'sets the header authorization token using the given options' do
        expect(subject.class.headers).to include('Authorization' => 'token abc123')
      end

      context 'with the pro option' do
        let(:pro) { true }

        it 'sets the base uri using the private travis url' do
          expect(subject.class.base_uri).to eq('http://api.travis-ci.com/repo/company%2Fsuper_repo')
        end
      end

      context 'without the pro option' do
        let(:pro) { false }

        it 'sets the base uri using the public travis url' do
          expect(subject.class.base_uri).to eq('http://api.travis-ci.org/repo/company%2Fsuper_repo')
        end
      end
    end
  end

  describe '#trigger' do
    let(:message) { 'Triggered by build' }
    let(:branch) { 'master' }
    let(:query) { { request: { message: message, branch: branch } } }

    let(:httparty) { class_double('HTTParty') }

    before do
      allow(subject).to receive(:class).and_return(httparty)
    end

    it 'posts a request with the given message' do
      expect(httparty).to receive(:post).with('/requests', query: query)

      subject.trigger('Triggered by build')
    end

    context 'when no branch is defined' do
      it 'posts a request defaulting to the master branch' do
        expect(httparty).to receive(:post).with('/requests', query: query)

        subject.trigger('Triggered by build')
      end
    end

    context 'when a branch is defined' do
      let(:message) { 'Build triggered' }
      let(:branch) { 'development' }

      it 'posts a request defaulting to the given branch' do
        expect(httparty).to receive(:post).with('/requests', query: query)

        subject.trigger('Build triggered', branch: 'development')
      end
    end
  end
end
