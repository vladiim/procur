require 'spec_helper'

class Company < Sequel::Model
  def self.many_to_one(*args); end
  def id; 1;end
end

require_relative '../../models/company'

RSpec.describe Company do
  describe '.from_linkedin' do
    let(:data) { CompanyData.new }
    let(:company) { Company.from_linkedin(data, 1) }

    before { allow(Company).to receive(:first) { nil } }

    it 'returns a company object' do
      expect(company).to be_a Company
    end

    context 'existing company' do
      it 'returns the existing company' do
        old_company = Object.new
        attrs = { linkedin_id: 11 }
        expect(Company).to receive(:first).with(attrs) { old_company }
        expect(company).to eq old_company
      end
    end

    context 'new company' do
      it "sets up all the company's values" do
        expect(company.values[:position_id]).to eq 1
        expect(company.values[:linkedin_id]).to eq 11
        expect(company.values[:industry]).to eq 'INDUSTRY'
        expect(company.values[:name]).to eq 'NAME'
      end
    end
  end
end

class CompanyData

  attr_reader :id, :industry, :name
  def initialize
    @id = 11
    @industry = 'INDUSTRY'
    @name = 'NAME'
  end
end

# class FakeLinkedin

#   def profile(blah)
#     FakeLinkedin.new
#   end

#   def positions
#     OpenStruct.new(all: companies)
#   end

#   def companies
#     [OpenStruct.new(company: new_company), OpenStruct.new(company: old_company)]
#   end

#   def new_company
#     OpenStruct.new(id: 'ID', industry: 'INDUSTRY', name: 'NAME')
#   end

#   def old_company
#     OpenStruct.new(id: 1, industry: 'INDUSTRY', name: 'NAME')
#   end
# end

# RSpec.describe Company do
#   describe '.from_linkedin' do
#     let(:client) { FakeLinkedin.new }
#     let(:companies) { Company.from_linkedin(client) }

#     it 'returns an array of company instances' do
#       expect(companies[0]).to be_a Company
#     end

#     it "finds the user's positions" do
#       attrs = { fields: ['positions'] }
#       expect(client).to receive(:profile).with(attrs) { FakeLinkedin.new }
#       companies
#     end

#     context 'new companies' do
#       it 'creates a new company and sets up the correct variables' do
#         expect(companies[0].values[:linkedin_id]).to eq 'ID'
#         expect(companies[0].values[:industry]).to eq 'INDUSTRY'
#         expect(companies[0].values[:name]).to eq 'NAME'
#       end
#     end

#     context 'an old company', focus: true do
#       it 'only creates the new company' do
#         query = Object.new
#         old_company = OpenStruct.new(id: 1, industry: 'INDUSTRY', name: 'NAME')
#         expect(Company).to receive(:filter) { query }
#         expect(query).to receive(:all) { [old_company] }
#         expect(Company).to have_received(:create).once
#         companies
#       end
#     end
#   end
# end