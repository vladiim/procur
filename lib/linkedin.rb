module Linkedin
  def self.new_client(settings)
    LinkedIn::Client.new(settings.api, settings.secret)
  end

  def self.request_token(client, request)
    client.request_token(:oauth_callback => "http://#{request.host}:#{request.port}/auth/callback")
  end

  def self.authorize_url(client)
    client.request_token.authorize_url
  end
end