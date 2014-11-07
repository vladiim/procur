
Procur::App.controllers :auth do

  get :auth, map: '/auth' do
    linkedin = Linkedin.new(settings)
    linkedin.set_request_session(request, session)
    redirect linkedin.authorize_url
  end

  get :callback, map: '/auth/callback' do
    linkedin = Linkedin.new(settings)
    linkedin.set_auth_session(session, params[:oauth_verifier])
    client = linkedin.client
    profile = Profile.from_linkedin(client)
    session[:current_user_id] = profile.id
    current_user = profile
    profile.positions_from_linkedin(client)
    redirect profile.url
  end

  get :logout, map: '/logout' do
     session[:atoken] = nil
     session[:current_user_id] = nil
     current_user = nil
     redirect "/"
  end
end