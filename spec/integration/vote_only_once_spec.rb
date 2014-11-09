require_relative 'spec_helper'

describe 'vote once', type: :feature do
  let(:helper) { OpenStruct.new(name: 'helper') }

  it 'only lets you vote once per service per company' do
    given_i "have voted for a company's service"
    when_i 'try to vote again'
    then_i "get a message that I can't vote again"
  end
end

def have_voted_for_a_companys_service(helper)
  helper.profile = create(:profile, :with_position)
  page.set_rack_session(current_user_id: helper.profile.id)
  
end

def try_to_vote_again(helper)
  
end

def get_a_message_that_i_cant_vote_again(helper)
  
end