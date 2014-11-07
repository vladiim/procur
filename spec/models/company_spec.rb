require 'spec_helper'

class Company < Sequel::Model
  def self.one_to_many(*args); end
  def self.many_to_many(*args); end
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

  describe '#create_service' do
    let(:result) { company.create_service('SERVICE', 'PROFILE ID', ServiceStub) }

    context "service exists" do
      it "doesn't create a new service" do
        old_service = Object.new
        attrs = { name: 'SERVICE' }
        expect(ServiceStub).to receive(:where).with(attrs) { old_service }
        expect(old_service).to receive(:first) { old_service }
        expect(result).to eq old_service
      end
    end

    context "service doesn't exist" do
      before do
        sequel = Object.new
        expect(ServiceStub).to receive(:where) { sequel }
        expect(sequel).to receive(:first) { nil }
        allow(company).to receive(:id) { 'COMPANY ID' }
      end

      it "sets the service's variables" do
        service = result
        expect(service.company_id).to eq 'COMPANY ID'
        expect(service.name).to eq 'SERVICE'
      end
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

class ServiceStub < OpenStruct
  def self.create_for_vote(name, id, profile_id)
    new(name: name, company_id: id, profile_id: profile_id)
  end
end