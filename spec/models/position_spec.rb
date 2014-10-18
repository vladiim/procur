require 'spec_helper'

class Position < Sequel::Model
  def self.one_to_many(*args); end
  def self.many_to_one(*args); end
  def id; 1;end
end

require_relative '../../models/position'

RSpec.describe Position do
  let(:data) { PositionData.new }
  let(:position) { Position.from_linkedin(data, 'PROFILE ID', CompanyStub) }

  describe '.from_linkedin' do
    before { allow(Position).to receive(:first) { nil } }

    context 'new position' do
      it 'returns a Position instance' do
        expect(position).to be_a Position
      end

      it 'sets up the correct variables' do
        expect(position.values[:profile_id]).to eq 'PROFILE ID'
        expect(position.values[:company_id]).to eq 'COMPANY ID'
        expect(position.values[:linkedin_id]).to eq 'LINKEDIN ID'
        expect(position.values[:is_current]).to eq true
        expect(position.values[:title]).to eq 'TITLE'
      end
    end

    context 'old position' do
      it 'returns the old position' do
        old_position = OpenStruct.new(id: 1)
        args = { linkedin_id: 'LINKEDIN ID' }
        expect(Position).to receive(:first).with(args) { old_position }
        expect(position).to eq old_position
      end
    end

    it 'finds or creates a company from linkedin' do
      expect(CompanyStub).to receive(:from_linkedin).with('COMPANY') { CompanyStub.new }
      position
    end
  end

  describe '.companies' do
    let(:position) { OpenStruct.new(company_id: 'COMPANY ID') }
    let(:positions) { [ position ] }
    let(:result) { Position.companies(positions, CompanyStub) }

    it 'returns an array' do
      expect(result).to be_a Array
    end

    context 'position belongs to company' do
      it 'adds the company to the array' do
        expect(CompanyStub).to receive(:[]).with('COMPANY ID') { CompanyStub.new }
        expect(result[0]).to be_a CompanyStub
      end
    end

    context "position doesn't belongs to company" do
      it "doesn't add the company to the array" do
        expect(CompanyStub).to receive(:[]).with('COMPANY ID') { nil }
        expect(result).to eq []
      end
    end
  end
end

class CompanyStub
  def self.from_linkedin(company); new; end
  def id; 'COMPANY ID'; end
  def self.[](blah); new; end
end

class PositionData
  attr_reader :id, :is_current, :title
  def initialize
    @id = 'LINKEDIN ID'
    @is_current = true
    @title = 'TITLE'
  end

  def start_date
    OpenStruct.new(month: 5, year: 2014)
  end

  def company
    'COMPANY'
  end
end