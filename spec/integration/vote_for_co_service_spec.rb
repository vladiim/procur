require_relative 'spec_helper'

describe 'add service', type: :feature do

  let(:helper) { OpenStruct.new(name: 'helper') }

  it 'displays the service on the company page' do
    given_i 'am a company employee', helper
    and_i 'am on a company page', helper
    when_i 'add digital as a service'
    then_i 'see digital on the page'
    and_i 'have voted for the digital service', helper
  end
end

def am_a_company_employee(helper)
  helper.profile = create(:profile, :with_position)
  helper.position = helper.profile.positions[0]
  helper.company = Company[helper.position.company_id]
  # require 'debugger'; debugger
  page.set_rack_session(current_user_id: helper.profile.id)
  # Procur::App.current_user = helper.profile
end

def am_on_a_company_page(helper)
  visit helper.company.url
end

def add_digital_as_a_service(helper)
  within('.add-service-show') do
    fill_in 'add-service-input', with: 'Digital'
    click_button 'Add'
  end
end

def see_digital_on_the_page(helper)
  expect(page).to have_content 'Digital'
end

def have_voted_for_the_digital_service(helper)
  profile_votes = helper.profile.votes.map { |vote| vote.name }
  expect(profile_votes).to include? 'Digital'
end