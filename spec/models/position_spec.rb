require 'spec_helper'
require_relative '../../models/position'

RSpec.describe Position do
  let(:data) { PositionData.new }

  describe '.from_linkedin' do
    let(:position) { Position.from_linkedin(data) }

    before { allow(Position).to receive(:first) { nil } }

    context 'new position' do
      it 'returns a Position instance' do
        expect(position).to be_a Position
      end

      it 'sets up the correct variables' do
        expect(position.values[:linkedin_id]).to eq 2
        expect(position.values[:is_current]).to eq true
        expect(position.values[:title]).to eq 'TITLE'
      end
    end

    context 'old position' do
      it 'returns the old position' do
        old_position = Object.new
        args = { linkedin_id: 2 }
        expect(Position).to receive(:first).with(args) { old_position }
        expect(position).to eq old_position
      end
    end
  end
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
    OpenStruct.new(
      id: 1, industry: 'INDUSTRY', name: 'NAME',
      size: 'SIZE', employees: 'EMPLOYEES', type: 'TYPE'
    )
  end
end