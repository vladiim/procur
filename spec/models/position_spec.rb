require 'spec_helper'

class Position < Sequel::Model
  def self.one_to_one(*args); end
  def self.many_to_one(*args); end
  def id; 1;end
end

require_relative '../../models/position'

RSpec.describe Position do
  let(:data) { PositionData.new }
  let(:position) { Position.from_linkedin(data, 1, CompanyStub) }

  describe '.from_linkedin' do
    before { allow(Position).to receive(:first) { nil } }

    context 'new position' do
      it 'returns a Position instance' do
        expect(position).to be_a Position
      end

      it 'sets up the correct variables' do
        expect(position.values[:profile_id]).to eq 1
        expect(position.values[:linkedin_id]).to eq 2
        expect(position.values[:is_current]).to eq true
        expect(position.values[:title]).to eq 'TITLE'
      end
    end

    context 'old position' do
      it 'returns the old position' do
        old_position = OpenStruct.new(id: 1)
        args = { linkedin_id: 2 }
        expect(Position).to receive(:first).with(args) { old_position }
        expect(position).to eq old_position
      end
    end

    it 'finds or creates a company from linkedin' do
      expect(CompanyStub).to receive(:from_linkedin).with('COMPANY', 1)
      position
    end

    it 'saves the company to itself', focus: true do
      expect(position.company).to be_a CompanyStub
    end
  end

  describe '.companies' do
    let(:position) { OpenStruct.new(id: 1) }
    let(:positions) { [ position ] }

    it 'returns an array' do
      
    end

    context 'returns a company' do

    end
  end
end

class CompanyStub
  def self.from_linkedin(blah, num); new; end
end

class PositionData
  attr_reader :id, :is_current, :title
  def initialize
    @id = 2
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