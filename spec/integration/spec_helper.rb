require 'capybara/rspec'
require 'factory_girl'
require 'rack_session_access/capybara'

RACK_ENV='test'

require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

# Sequel doesn't have the #save! method
class Sequel::Model
  alias_method :save!, :save
end

# Be able to access the rack session
Procur::App.configure do |app|
  app.use RackSessionAccess::Middleware
  app.protection = false
  app.disable :protection
  app.protect_from_csrf = false
  app.allow_disabled_csrf = true
end

Capybara.app = Procur::App

# Factory girl methods + clean db
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:each) do
    existing_tables = Sequel::Model.db.tables
    tables_to_preserve = [:schema_info, :schema_migrations]
    tables_to_be_emptied = existing_tables - tables_to_preserve
    tables_to_be_emptied.each do |table|
      Sequel::Model.db[table].delete
    end
  end
end

FactoryGirl.definition_file_paths = [File.join(Padrino.root, 'spec', 'factories')]
FactoryGirl.find_definitions

# # JS driver
# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist

# # Use Webmock to disable external requests
# require 'webmock/rspec'
# WebMock.disable_net_connect!(allow_localhost: true)

# require File.expand_path(File.dirname(__FILE__) + "/support/fake_linkedin")
# RSpec.configure do |config|
#   config.before(:each) do
#     stub_request(:any, /linkedin.com/).to_rack(FakeLinkedin)
#   end
# end

# # Enable given/when/then syntax
def convert_to_meth(statement, helper_obj = nil)
  method = statement.gsub(' ', '_').
    gsub('\'', '').
    downcase.to_sym
  send method, helper_obj
end

def given_i(statement, helper_obj = nil)
  convert_to_meth(statement, helper_obj)
end

def and_i(statement, helper_obj = nil)
  convert_to_meth(statement, helper_obj)
end

def and_also(statement, helper_obj = nil)
  convert_to_meth(statement, helper_obj)
end

def when_i(statement, helper_obj = nil)
  convert_to_meth(statement, helper_obj)
end

def then_i(statement, helper_obj = nil)
  convert_to_meth(statement, helper_obj)
end