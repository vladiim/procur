require 'spec_helper'

module Sequel
  class Model
    attr_accessor :values
    def initialize(*args)
      @values = args[0]
    end
  end
end

require_relative '../../models/company'

class FakeLinkedin
  def profile(blah)
    FakeLinkedin.new
  end

  def positions
    OpenStruct.new(all: [company])
  end

  def company
    OpenStruct.new(
      id: 'ID',
      industry: 'INDUSTRY',
      name: 'NAME'
    )
  end
end

RSpec.describe Company do
  describe '.from_linkedin' do
    let(:client) { FakeLinkedin.new }
    let(:companies) { Company.from_linkedin(client) }

    it 'returns an array of company instances' do
      expect(companies[0]).to be_a Company
    end

    it 'finds the user positions' do
      attrs = { fields: ['positions'] }
      expect(client).to receive(:profile).with(attrs) { FakeLinkedin.new }
      companies
    end

    context 'new companies' do
      it 'sets up the correct variables' do
        expect(companies[0].values[:linkedin_id]).to eq 'ID'
        expect(companies[0].values[:industry]).to eq 'INDUSTRY'
        expect(companies[0].values[:name]).to eq 'NAME'
      end
    end
  end
end