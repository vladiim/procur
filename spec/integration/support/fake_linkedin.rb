# require 'sinatra/base'

# class FakeLinkedin < Sinatra::Base
#   get 'uas/oauth/requestToken' do
#     set_session_vars
#     # require 'debugger'; debugger
#     params = {"oauth_token"=>"75--f06753d5-ce84-497a-ad87-87d726039fbf", "oauth_verifier"=>"49634"}
#     respond 200, params
#   end

#   get '/uas/oauth/authorize' do
#     require 'debugger'; debugger
#     params = {"oauth_token"=>"75--f06753d5-ce84-497a-ad87-87d726039fbf", "oauth_verifier"=>"49634"}
#     redirect 'auth/callback', params
#   end
# end