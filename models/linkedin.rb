class Linkedin

  attr_reader :client
  def initialize(settings)
    @client = LinkedIn::Client.new(settings.api, settings.secret)
  end

  attr_reader :req_token
  def request_token(request)
    callback = "http://#{request.host}:#{request.port}/auth/callback"
    @req_token = client.request_token(oauth_callback: callback)
  end

  def authorize_url
    req_token.authorize_url
  end

  def set_auth_session(session, pin)
    return if session[:atoken]
    rtoken = session.fetch(:rtoken)
    rsecret = session.fetch(:rsecret)
    auth = client.authorize_from_request(rtoken, rsecret, pin)
    session[:atoken] = auth[0]
    session[:asecret] = auth[1]
  end
end