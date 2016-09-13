require 'httparty'

module TriggerBuild

  class Travis
    include HTTParty
    headers 'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'Travis-API-Version' => '3'

    def initialize(opts)
      self.class.base_uri "api.#{opts[:url]}/repo/#{opts[:owner]}\%2F#{opts[:repo]}"
      self.class.headers 'Authorization' => "token #{opts[:token]}"
    end

    def trigger(message, branch: 'master')
      self.class.post('/requests', query: { request: { message: message, branch: branch } })
    end
  end

end
