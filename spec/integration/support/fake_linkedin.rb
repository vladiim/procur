require 'sinatra/base'

class FakeLinkedin < Sinatra::Base
  # get 'uas/oauth/requestToken' do
  #   # set_session_vars
  #   require 'debugger'; debugger
  #   params = {"oauth_token"=>"75--f06753d5-ce84-497a-ad87-87d726039fbf", "oauth_verifier"=>"49634"}
  #   respond 200, params
  # end

  get '/blah' do
    require 'debugger'; debugger
  end

  get '/uas/oauth/authorize' do
    require 'debugger'; debugger
    params = {"oauth_token"=>"75--f06753d5-ce84-497a-ad87-87d726039fbf", "oauth_verifier"=>"49634"}
    redirect 'auth/callback', params
  end

  private

  def set_session_vars
    session[:rtoken] = session_response[:rtoken]
    session[:rsecret] = session_response[:rsecret]
  end

  def session_response
    {"session_id"=>"4913c710f9230c76e185fb1740147f4090a10973d0f7e26383b17b6d8027c159", "csrf"=>"a9931c844a0e8d4faf12c8856eecaaa6", "tracking"=>{"HTTP_USER_AGENT"=>"faff8a65799655e32079979850b1eb12667fce3d", "HTTP_ACCEPT_LANGUAGE"=>"66eae971492938c2dcc2fb1ddc8d7ec3196037da"}, "rtoken"=>"75--f06753d5-ce84-497a-ad87-87d726039fbf", "rsecret"=>"43a4f267-fa73-4630-b7d2-a405d2456dc2", "asecret"=>"48537e12-862d-4882-86af-db253b1a7b85"}
  end
end