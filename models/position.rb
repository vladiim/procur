class Position < Sequel::Model

  attr_accessor :company

  def self.from_linkedin(position_data, profile_id, company_class = Company)
    position = Position.first(linkedin_id: position_data.id)
    position = position || create_position(position_data, profile_id)
    position.company = company_class.from_linkedin(position_data.company)
    position
  end

  private

  def self.create_position(position_data, profile_id)
    create(
      profile_id: profile_id,
      linkedin_id: position_data.id,
      is_current: position_data.is_current,
      title: position_data.title
    )
  end
end