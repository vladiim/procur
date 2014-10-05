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

  describe '#request_token' do
    let(:request)   { OpenStruct.new(host: 'HOST', port: 'PORT') }
    let(:req_token) { linkedin.request_token(request) }
    before { req_token }

    it 'sets up the linkedin.req_token' do
      expect(linkedin.req_token).to eq req_token
    end

    it 'has a token' do
      expect(req_token.token).to eq 'TOKEN'
    end

    it 'has a secret' do
      expect(req_token.secret).to eq 'SECRET'
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