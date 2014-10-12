# require 'spec_helper'

# require_relative '../../models/company'

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