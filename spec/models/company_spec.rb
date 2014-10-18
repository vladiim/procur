require 'spec_helper'

class Company < Sequel::Model
  def self.one_to_many(*args); end
  def id; 1;end
  def name; 'COMPANY NAME'; end
end

require_relative '../../models/string_helper'
require_relative '../../models/company'

RSpec.describe Company do
  let(:company) { Company.new }

  describe '.from_linkedin' do
    let(:data) { CompanyData.new }
    let(:company) { Company.from_linkedin(data) }
    before { allow(Company).to receive(:first) { nil } }

    it 'returns a company object' do
      expect(company).to be_a Company
    end

    context 'existing company' do
      it 'returns the existing company' do
        old_company = Object.new
        attrs = { linkedin_id: 'LINKEDIN ID' }
        expect(Company).to receive(:first).with(attrs) { old_company }
        expect(company).to eq old_company
      end
    end

    context 'new company' do
      it "sets up all the company's values" do
        expect(company.values[:linkedin_id]).to eq 'LINKEDIN ID'
        expect(company.values[:industry]).to eq 'INDUSTRY'
        expect(company.values[:name]).to eq 'NAME'
      end
    end
  end

  describe '#url' do
    it 'constructs a url based on the id and name' do
      expect(company.url).to eq '/companies/1/company-name'
    end
  end
end

class CompanyData

  attr_reader :id, :industry, :name
  def initialize
    @id = 'LINKEDIN ID'
    @industry = 'INDUSTRY'
    @name = 'NAME'
  end
end