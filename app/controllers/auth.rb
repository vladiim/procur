Procur::App.controllers :auth do
  include Linkedin

  get :auth, map: '/auth' do
    client = Linkedin.new_client(settings)
    request_token = Linkedin.request_token(client, request)
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    redirect Linkedin.authorize_url(client)
  end

  get :callback, map: '/auth/callback' do
    # require 'debugger'; debugger
    client = LinkedIn::Client.new(settings.api, settings.secret)
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      # require 'debugger'; debugger
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    end
    # require 'debugger'; debugger
    redirect "/"
  end

  get :logout, map: "/auth/logout" do
     session[:atoken] = nil
     redirect "/"
  end
end