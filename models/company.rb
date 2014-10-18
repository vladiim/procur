class Company < Sequel::Model
  # one_to_one :position
  many_to_one :position

  def self.from_linkedin(company_data, position_id)
    company = Company.first(linkedin_id: company_data.id)
    company ? company : create_company(company_data, position_id)
  end

  private

  def self.create_company(company_data, position_id)
    create(
      position_id: position_id,
      linkedin_id: company_data.id,
      industry: company_data.industry,
      name: company_data.name
    )
  end
end