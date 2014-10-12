
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
    require 'debugger'; debugger
    profile.positions_from_linkedin(client)
    # companies = Company.from_linkedin(client)
    # TODO: add start date and position to profile_companies
    # profile.companies = companies
    redirect profile.url
  end

  get :logout, map: '/auth/logout' do
     session[:atoken] = nil
     redirect "/"
  end
end