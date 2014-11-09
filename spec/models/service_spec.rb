require 'spec_helper'

class Service < Sequel::Model
  def self.many_to_many(*args); end
  def id; 1;end
end

require_relative '../../models/service'

RSpec.describe Service do
  let(:service) { Service.new }

  describe '.create_for_vote' do
    let(:service) { Service.create_for_vote('SERVICE NAME', 'COMPANY ID', 'PROFILE ID', VoteStub) }

    it 'returns a service object' do
      expect(service).to be_a Service
    end

    context 'new service' do
      it "sets up the services's values" do
        expect(service.values[:name]).to eq 'SERVICE NAME'
      end

      it "creates a vote" do
        args = { service_id: 1, company_id: 'COMPANY ID', profile_id: 'PROFILE ID' }
        expect(VoteStub).to receive(:create).with(args)
        service
      end
    end
  end

  describe '.vote_count' do
    it 'returns the vote count' do
      expect(service.vote_count(VoteStub)).to eq 'VOTE COUNT'
    end
  end
end

class VoteStub
  def self.create(*args)
    new
  end

  def self.group_and_count(arg)
    self
  end

  def self.where(arg)
    self
  end

  def self.all
    OpenStruct.new(count: 'VOTE COUNT')
  end
end