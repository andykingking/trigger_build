require 'httparty'

module TriggerBuild
  class TravisAPI
    include HTTParty
    headers 'Accept' => 'application/json',
            'Content-Type' => 'application/json',
            'Travis-API-Version' => '3'

    def initialize(opts)
      url = opts[:pro] ? 'travis-ci.com' : 'travis-ci.org'
      self.class.base_uri "api.#{url}/repo/#{opts[:owner]}\%2F#{opts[:repo]}"
      self.class.headers 'Authorization' => "token #{opts[:token]}"
    end

    def trigger(message, branch: 'master')
      self.class.post('/requests', query: { request: { message: message, branch: branch } })
    end
  end
end
