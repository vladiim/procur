class Linkedin

  attr_reader :client
  def initialize(settings)
    @client = LinkedIn::Client.new(settings.api, settings.secret)
    # @callback_url = "http://#{request.host}:#{request.port}/auth/callback"
  end

  attr_reader :req_token
  def request_token(request)
    callback = "http://#{request.host}:#{request.port}/auth/callback"
    @req_token = client.request_token(oauth_callback: callback)
  end

  def authorize_url
    req_token.authorize_url
  end
end