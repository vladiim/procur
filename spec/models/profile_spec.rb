require 'spec_helper'
require_relative '../../models/string_helper'

module Sequel
  class Model
    attr_accessor :values
    def initialize(*args)
      @values = args[0]
    end
  end
end

require_relative '../../models/profile'

RSpec.describe Profile do
  let(:client) { OpenStruct.new(profile: profile_data, consumer_token: 'CONSUMER TOKEN') }

  describe '.from_linkedin' do
    let(:profile) { Profile.from_linkedin(client) }

    before { allow(Profile).to receive(:first) { nil } }

    context 'new profile' do
      it 'returns a profile instance' do
        expect(profile).to be_a Profile
      end

      it 'sets up the correct variables' do
        expect(profile.values[:linkedin_token]).to eq 'CONSUMER TOKEN'
        expect(profile.values[:surname]).to eq 'LAST NAME'
        expect(profile.values[:headline]).to eq 'HEADLINE'
        expect(profile.values[:linkedin_url]).to eq 'URL'
        expect(profile.values[:created_at]).to be
      end
    end

    context 'existing linkedin profile' do
      it 'returns the old profile' do
        old_profile = Object.new
        args = { linkedin_token: 'CONSUMER TOKEN' }
        expect(Profile).to receive(:first).with(args) { old_profile }
        expect(profile).to eq old_profile
      end
    end
  end

  context 'basic profile' do
    let(:profile) { Profile.new }

    before do
      profile.stub(:name) { 'NAME' }
      profile.stub(:surname) { 'SUR NAME' }
    end

    describe '#url' do
      it "returns the profile's show url" do
        profile.stub(:id) { 1 }
        expect(profile.url).to eq '/profiles/1/name-sur-name'
      end
    end

    describe '#fullname' do
      it 'combines the name and surname' do
        expect(profile.fullname).to eq "Name Sur Name"
      end
  end
  end
end

def profile_data
  OpenStruct.new(
    first_name: 'FIRST NAME',
    last_name: 'LAST NAME',
    headline: 'HEADLINE',
    site_standard_profile_request: OpenStruct.new(url: 'URL')
  )
end