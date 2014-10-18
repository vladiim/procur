class Company < Sequel::Model
  one_to_many :positions

  def self.from_linkedin(company_data)
    company = Company.first(linkedin_id: company_data.id)
    company ? company : create_company(company_data)
  end

  private

  def self.create_company(company_data)
    create(
      linkedin_id: company_data.id,
      industry: company_data.industry,
      name: company_data.name
    )
  end
end