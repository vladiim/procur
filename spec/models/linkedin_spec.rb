require 'spec_helper'
require_relative '../../models/linkedin'

module LinkedIn
  class Client
    def initialize(api, secret)
      true
    end

    def request_token(callback)
      OpenStruct.new(token: 'TOKEN', secret: 'SECRET', authorize_url: 'AUTH URL')
    end

    def authorize_from_request(rtoken, rsecret, pin)
      [ "#{ rtoken } #{ pin }", "#{ rsecret } #{ pin }" ]
    end
  end
end

RSpec.describe Linkedin do
  let(:settings) { OpenStruct.new(api: 'API', secret: 'SECRET') }
  let(:linkedin) { Linkedin.new(settings) }

  describe '#initialize' do
    it 'sets up a client with the settings' do
      expect(linkedin.client).to be_a LinkedIn::Client
    end
  end

  describe '#set_request_session' do
    let(:request) { OpenStruct.new(host: 'HOST', port: 'PORT') }
    let(:session) { {} }
    before { linkedin.set_request_session(request, session) }

    it 'sets the sessions rtoken' do
      expect(session[:rtoken]).to eq 'TOKEN'
    end

    it 'sets the sessions rsecret' do
      expect(session[:rsecret]).to eq 'SECRET'
    end

    describe '#authorize_url' do
      it 'responds with the authorize url' do
        expect(linkedin.authorize_url).to eq 'AUTH URL'
      end
    end
  end

  describe '#set_auth_session' do
    let(:pin) { 'PIN' }
    before { linkedin.set_auth_session(session, pin) }

    context 'with atoken' do
      let(:session) { { atoken: true } }

      it "doesn't change the session" do
        expect(session).to eq({ atoken: true })
      end
    end

    context 'without atoken' do
      let(:session) { { rtoken: 'ATOKEN', rsecret: 'ASECRET' } }

      it 'sets the session atoken' do
        expect(session[:atoken]).to eq 'ATOKEN PIN'
      end

      it 'sets the session asecret' do
        expect(session[:asecret]).to eq 'ASECRET PIN'
      end
    end
  end
end