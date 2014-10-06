# require_relative 'spec_helper'

# describe 'sign up', type: :feature do
#   # before do
#   #   stub_request(:any, /linkedin.com/).to_rack(FakeLinkedin)
#   #   Linkedin.stub(:new_client) { OpenStruct.new }
#   #   Linkedin.stub(:request_token) { OpenStruct.new(token: 'TOKEN', secret: 'SECRET') }
#   #   Linkedin.stub(:authorize_url) { "https://#{ LINKEDIN }/uas/oauth/authorize" }
#   # end

#   # before do
#   #   Linkedin.stub(:initialize) { OpenStruct.new }
#   #   Linkedin.stub(:set_request_session) { true }
#   #   Linkedin.stub(:authorize_url) { 'https://linkedin.com/uas/oauth/authorize' }
#   # end

#   it 'authenticates through linkedin' do
#     given_i 'am adding my company'
#     when_i 'authenticate with linkedin'
#     then_i 'see my profile'
#   end
# end

# def am_adding_my_company
#   visit '/companies/new'
# end

# def authenticate_with_linkedin
#   click_link 'Sign in with LinkedIn'
# end

# def see_my_profile
#   expect(page.current_url).to eq '/profiles/1/vlad-mehakovic'
# end