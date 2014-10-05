# Set up
require 'capybara/rspec'
RACK_ENV='test'

require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")
Capybara.app = Padrino.application

# JS driver
# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist

# Use Webmock to disable external requests
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

# require File.expand_path(File.dirname(__FILE__) + "/support/fake_linkedin")
# RSpec.configure do |config|
#   config.before(:each) do
#     stub_request(:any, '/linkedin.com/').to_rack(FakeLinkedin)
#   end
# end

# Enable given/when/then syntax
def convert_to_meth(statement)
  method = statement.gsub(' ', '_').downcase.to_sym
  send method
end

def given_i(statement)
  convert_to_meth(statement)
end

def when_i(statement)
  convert_to_meth(statement)
end

def then_i(statement)
  convert_to_meth(statement)
end