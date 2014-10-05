Procur::App.controllers :auth do

  get :auth, map: '/auth' do
    linkedin = Linkedin.new(settings)
    request_token = linkedin.request_token(request)
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    redirect linkedin.authorize_url
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