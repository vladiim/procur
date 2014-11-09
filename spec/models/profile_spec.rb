require 'spec_helper'
require_relative '../../models/string_helper'

class Profile < Sequel::Model
  def self.one_to_many(*args); end
  def self.many_to_many(*args); end
  def id; 1;end
end

require_relative '../../models/profile'

RSpec.describe Profile do
  let(:client) { ClientStub.new }
  let(:profile) { Profile.new }

  describe '.from_linkedin' do
    let(:profile) { Profile.from_linkedin(client) }

    before { allow(Profile).to receive(:first) { nil } }

    context 'new profile' do
      it 'returns a profile instance' do
        expect(profile).to be_a Profile
      end

      it 'sets up the correct variables' do
        expect(profile.values[:linkedin_token]).to eq 'CONSUMER TOKEN'
        expect(profile.values[:email]).to eq 'EMAIL ADDRESS'
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
    before do
      allow(profile).to receive(:name) { 'NAME' }
      allow(profile).to receive(:surname) { 'SUR NAME' }
    end

    describe '#url' do
      it "returns the profile's show url" do
        allow(profile).to receive(:id) { 1 }
        expect(profile.url).to eq '/profiles/1/name-sur-name'
      end
    end

    describe '#fullname' do
      it 'combines the name and surname' do
        expect(profile.fullname).to eq "Name Sur Name"
      end
    end
  end

  describe '#positions_from_linkedin' do
    let(:position) { OpenStruct.new }
    let(:client) { ClientStub.new(position) }
    let(:positions) { [] }
    before { allow(profile).to receive(:positions) { positions } }

    it 'creates a new position object for each position' do
      expect(PositionStub).to receive(:from_linkedin).with(position, 1)
      profile.positions_from_linkedin(client, PositionStub)
    end

    it 'returns a position array' do
      result = profile.positions_from_linkedin(client, PositionStub)
      expect(result).to eq positions
    end
  end

  describe '#vote_for' do
    it 'creates a new vote' do
      # service_id, company_id
      args = { profile_id: 1, service_id: 'SERVICE ID', company_id: 'COMPANY ID'}
      expect(VoteStub).to receive(:create).with(args)
      profile.vote_for('SERVICE ID', 'COMPANY ID', VoteStub)
    end
  end
end

class ClientStub < OpenStruct
  attr_reader :position
  def initialize(position=Object.new)
    @position = position
  end

  def profile(something='PROFILE')
    case something
    when { fields: ['email-address']}
      OpenStruct.new(email_address: 'EMAIL ADDRESS')
    when { fields: ['positions']}
      self
    else
      profile_data
    end
  end

  def positions; self; end
  def all; [position]; end
  def consumer_token; 'CONSUMER TOKEN'; end
end

class PositionStub
  def self.from_linkedin(position, id)
  end
end

class VoteStub
end

def profile_data
  OpenStruct.new(
    first_name: 'FIRST NAME',
    last_name: 'LAST NAME',
    headline: 'HEADLINE',
    site_standard_profile_request: OpenStruct.new(url: 'URL')
  )
end