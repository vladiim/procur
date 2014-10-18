class Position < Sequel::Model
  many_to_one :profile
  one_to_many :companies

  attr_accessor :company

  def self.from_linkedin(position_data, profile_id, company_class = Company)
    position = Position.first(linkedin_id: position_data.id)
    company = company_class.from_linkedin(position_data.company)
    position = position || create_position(position_data, profile_id, company.id)
    position
  end

  def self.companies(positions, company_class = Company)
    positions.inject([]) do |companies, position|
      company = company_class[position.company_id]
      company ? companies << company : companies
    end
  end

  private

  def self.create_position(position_data, profile_id, company_id)
    create(
      profile_id: profile_id,
      company_id: company_id,
      linkedin_id: position_data.id,
      is_current: position_data.is_current,
      title: position_data.title
    )
  end
end