require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

class FakeLinkedin < Sinatra::Base
  include Capybara::DSL

  def self.boot
    instace = new
    Capybara::Server.new(instance).tap { |server| server.boot }
  end

  get '/uas/oauth/authorize' do
    # redirect '/auth/callback'
    'Hello'
  end
end

server = FakeLinkedin.boot
LINKEDIN = [server.host, server.port].join(':')

describe 'sign up', type: :feature do
  before do
    stub_request(:any, /linkedin.com/).to_rack(FakeLinkedin)
    Linkedin.stub(:new_client) { OpenStruct.new }
    Linkedin.stub(:request_token) { OpenStruct.new(token: 'TOKEN', secret: 'SECRET') }
    Linkedin.stub(:authorize_url) { "https://#{ LINKEDIN }/uas/oauth/authorize" }
  end

  # it 'stubs the response' do
  #   stub_request(:any, /plop.com/).to_rack(FakeLinkedin)
  #   # visit 'http://www.plot.com/uas/oauth/authorize'
  #   # save_and_open_page
  #   expect(Net::HTTP.get('www.plop.com', '/uas/oauth/authorize')).to eq("Hello")
  # end

  it 'authenticates through linkedin' do
    given_i "am adding my company"
    when_i "authenticate with linkedin"
    then_i "see my profile"
  end
end

def am_adding_my_company
  visit '/companies/new'
end

def authenticate_with_linkedin
  click_link 'Sign in with LinkedIn'
end

def see_my_profile
  save_and_open_page
  expect(page.current_url).to eq '/profiles/1/vlad-mehakovic'
end